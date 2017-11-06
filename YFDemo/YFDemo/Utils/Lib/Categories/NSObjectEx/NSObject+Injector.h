//
//  NSObject+Injector.h
//  RuntimeDemo
//
//  Created by Cerko on 15/10/21.
//  Copyright © 2015年 Cerko. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Injector)

/**
 *  注入所有的类，直到父类为NSObject为止
 */
- (void)inject;
/**
 *  注入property
 *
 *  @param kindOfClazz   要注入的一类Class
 *  @param terminalClazz 当此类的父类是这个类时，注入结束
 *  @param block         回调
 */
- (void)injectKindOfClass:(Class)kindOfClazz
            terminalClass:(Class)terminalClazz
             withCallBack:(nullable void (^)(__kindof id selfInstance, __kindof id objInject))block;
@end

NS_ASSUME_NONNULL_END
