//
//  NSObject+Injector.m
//  RuntimeDemo
//
//  Created by Cerko on 15/10/21.
//  Copyright © 2015年 Cerko. All rights reserved.
//

#import "NSObject+Injector.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (Injector)
- (void)inject{
    [self injectKindOfClass:[NSObject class] terminalClass:[NSObject class] withCallBack:NULL];
}


- (void)injectKindOfClass:(Class)kindOfClazz
            terminalClass:(Class)terminalClazz
             withCallBack:(nullable void (^)(__kindof id selfInstance,__kindof id objInject))block{
    
    Class clazz = self.class;
    while (clazz != terminalClazz) {
        unsigned int outCount = 0;
        objc_property_t *propertyList = class_copyPropertyList(clazz, &outCount);
        for (int i = 0; i < outCount; i++) {
            objc_property_t property = *(propertyList + i);
            
            char *propertyType = property_copyAttributeValue(property, "T");
            NSString *className = [NSString stringWithUTF8String:propertyType];
            NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"\"@"];
            className = [className stringByTrimmingCharactersInSet:set];
            Class propertyClazz =  NSClassFromString(className);
            
            if ([propertyClazz isSubclassOfClass:kindOfClazz]) {
                NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
                Method methodGet = class_getInstanceMethod(clazz, NSSelectorFromString(propertyName));
                
                id (* msg_invoke_get)(id , Method) = (void *)method_invoke;
                id obj = msg_invoke_get(self, methodGet);//调用getter
                
                //如果没有值,则注入
                if (!obj) {
                    obj = [[propertyClazz alloc] init];
                    
                    NSString *setterName = [NSObject setterMethodNameWithPropertyName:propertyName];//拼装setter
                    
                    Method methodSet = class_getInstanceMethod(clazz, NSSelectorFromString(setterName));
                    
                    void (* msg_invoke_set)(id, Method,id) = (void *)method_invoke;
                    msg_invoke_set(self, methodSet, obj);
                }
                if (block && obj) {
                    //回调
                    block(self, obj);
                }
                
            }
            free(propertyType);
            
        }
        free(propertyList);
        clazz = [clazz superclass];
    }

}

+ (NSString *)setterMethodNameWithPropertyName:(NSString *)propertyName{
    NSString *alpha = [[propertyName substringToIndex:1] uppercaseString];
    NSString *theLast = [propertyName substringFromIndex:1];
    NSString *setterName = [NSString stringWithFormat:@"set%@%@:",alpha,theLast];
    return setterName;
}
@end
