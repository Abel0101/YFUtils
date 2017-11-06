
//
//  JCObject.m
//  JCCompositionLib
//
//  Created by Cerko on 16/12/28.
//  Copyright © 2016年 Cerko. All rights reserved.
//

#import "JCObject.h"
#import "YFConstant.h"

@interface JCObject ()

/**
 用来存储没有定义的键值
 */
@property (nonatomic, strong) NSMutableDictionary <NSString *, id> *undefinedKeyValues;

@end

NSString *const kEncodeJSONKey = @"com.cerko.json";

@implementation JCObject

#pragma mark - properties
- (NSMutableDictionary<NSString *,id> *)undefinedKeyValues{
    if (!_undefinedKeyValues) {
        _undefinedKeyValues = [NSMutableDictionary dictionary];
    }
    return _undefinedKeyValues;
}


#pragma mark - KVC

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    self.undefinedKeyValues[key] = value;
    YFLog(@"set un definedKey:%@, value:%@", key, value);
}

- (id)valueForUndefinedKey:(NSString *)key{
    return [self.undefinedKeyValues objectForKey:key];
}

- (void)setValue:(id)value forKey:(NSString *)key{
    
    if ([NSStringFromSelector(@selector(undefinedKeyValues)) isEqualToString:key]) {
        [self.undefinedKeyValues removeAllObjects];
        [self.undefinedKeyValues addEntriesFromDictionary:value];
        return;
    }
    
    [super setValue:value forKey:key];
}

#pragma mark - public
- (void)setObject:(id)obj forKey:(NSString *)key{
    if (!obj) {
        [self.undefinedKeyValues removeObjectForKey:key];
        return;
    }
    
    [self setValue:obj forKey:key];
}

- (id)objectForKey:(NSString *)key{
    return [self valueForKey:key];
}


- (id)copyWithZone:(NSZone *)zone{
    return [[self class] objectWithJSONDictionary:[self JSONDictionaryForObject]];
}



- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    id JSONDictionaryForObject = [aDecoder decodeObjectForKey:kEncodeJSONKey];
    
    return [[self class] objectWithJSONDictionary:JSONDictionaryForObject];;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:[self JSONDictionaryForObject] forKey:kEncodeJSONKey];
}

+ (NSArray<NSString *> *)JSONObjectKeys{
    return @[NSStringFromSelector(@selector(undefinedKeyValues))];
}

- (NSString *)description{
    
    return [NSString stringWithFormat:@"%@, undefinedKeyValues:%@",[super description], self.undefinedKeyValues.description];
}

- (BOOL)isEqual:(id)object{
    if ([object isKindOfClass:[JCObject class]]) {
        JCObject *theObj = object;
        if (self.UUID.length) {
            return [self.UUID isEqualToString:theObj.UUID];
        }
        
        if (self.remoteId.length) {
            return [self.remoteId isEqualToString:theObj.remoteId];
        }
        
    }
    
    return [super isEqual:object];
    
}

@end




