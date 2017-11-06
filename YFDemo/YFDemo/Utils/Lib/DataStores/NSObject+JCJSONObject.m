//
//  NSObject+JCJSONObject.m
//  JCCompositionLib
//
//  Created by Cerko on 17/1/17.
//  Copyright © 2017年 Cerko. All rights reserved.
//

#import "NSObject+JCJSONObject.h"
#import "NSJSONSerialization+JCFactory.h"

@implementation NSObject (JCJSONObject)

+ (instancetype)objectWithJSONDictionary:(NSDictionary *)JSONDictionary{
    NSObject *object = [[self alloc]init];
    [object setKeyValuesWithJSONDictionary:JSONDictionary];
    return object;
}

+ (instancetype)objectWithJSONString:(NSString *)JSONString{
    return [self objectWithJSONDictionary:[NSJSONSerialization JSONObjectWithUTF8EncodingString:JSONString]];
}

+ (NSArray<NSString *> *)JSONObjectKeys{
    return @[];
}

- (NSDictionary *)JSONDictionaryForObject{
    return [self dictionaryWithValuesForKeys:[[self class] JSONObjectKeys]];
}

- (NSString *)JSONStringForObject{
    return [NSJSONSerialization stringUsingUTF8EncodingWithJSONObject:[self JSONDictionaryForObject]];
}

- (void)setKeyValuesWithJSONDictionary:(NSDictionary *)JSONDictionary{
    [self setValuesForKeysWithDictionary:JSONDictionary];
}



@end
