//
//  NSObject+JCJSONObject.h
//  JCCompositionLib
//
//  Created by Cerko on 17/1/17.
//  Copyright © 2017年 Cerko. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@protocol JCJSONObject <NSObject>

@required
/**
 根据JSON字典来生成一个Object，默认实现是生成一个当前类实例，然后调用setKeyValuesWithJSONDictionary

 @param JSONDictionary JSON字典，
 @return Instance
 */
+ (instancetype)objectWithJSONDictionary:(NSDictionary<NSString *, id> *)JSONDictionary;

/**
 先将JSONString转成NSDictionary再调用 objectWithJSONDictionary

 @param JSONString JSON字符串
 @return Object
 */
+ (instancetype)objectWithJSONString:(NSString *)JSONString;

/**
 要生成JSON数组所需的所有Key

 @return 数组
 */
+ (NSArray <NSString *> *)JSONObjectKeys;


/**
 将对应的JSON数据设置给Object，默认实现是 直接调用KVC的setValuesForKeysWithDictionary

 @param JSONDictionary JSON数据
 */
- (void)setKeyValuesWithJSONDictionary:(NSDictionary <NSString *,id> *)JSONDictionary;


/**
 把Object转成所对应的JSON数据,默认实现是调用dictionaryWithValuesForKeys，并传入JSONObjectKeys数组

 @return JSON字典
 */
- (NSDictionary <NSString *,id> *)JSONDictionaryForObject;

/**
 先将自己转成字典，再将字典转成String

 @return JSONString
 */
- (NSString *)JSONStringForObject;

@end


@interface NSObject (JCJSONObject) <JCJSONObject>

+ (instancetype)objectWithJSONDictionary:(NSDictionary<NSString *, id> *)JSONDictionary;
+ (NSArray <NSString *> *)JSONObjectKeys;

- (void)setKeyValuesWithJSONDictionary:(NSDictionary<NSString *, id> *)JSONDictionary;
- (NSDictionary<NSString *,id> *)JSONDictionaryForObject;


@end

NS_ASSUME_NONNULL_END
