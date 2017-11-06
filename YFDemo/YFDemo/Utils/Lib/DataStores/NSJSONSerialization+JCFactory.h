//
//  NSJSONSerialization+JCFactory.h
//  JCCompositionLib
//
//  Created by Cerko on 17/1/17.
//  Copyright © 2017年 Cerko. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSString (UTF8String)

+ (instancetype)UTF8StringWithData:(NSData *)data;

@end

@interface NSJSONSerialization (JCFactory)

/**
 调用JSONObjectWithData 传入kNilOptions

 @param data 数据
 @return 转换后的对象
 */
+ (nullable id)JSONObjectWithData:(NSData *)data;

/**
 将String转回对象，先把字符串转成data，再转成obj，一般是NSArray 或者是 NSDictionary

 @param string 字符串数据
 @return JSON对象
 */
+ (nullable id)JSONObjectWithUTF8EncodingString:(NSString *)string;


/**
 调用dataWithJSONObject 传入kNilOptions

 @param obj obj
 @return NSData
 */
+ (nullable NSData *)dataWithJSONObject:(id)obj;

/**
 先把obj转成 NSData,再转成字符串

 @param obj 对象
 @return 字符串
 */
+ (nullable NSString *)stringUsingUTF8EncodingWithJSONObject:(id)obj;

@end


/**
 将 以下类型转成String,如果传入的就是String,会直接返回该String

 @param jsonData NSDictionary, NSArray, NSString, NSData
 @return JSON 字符串或者是 原字符串
 */
extern NSString *JSONObjectToString(id jsonData);

/**
 将 json字符串转成 NSDictionary,NSArray,如果不能转，则会直接返回string

 @param string JSON字符串
 @return NSDictionary,NSArray
 */
extern id stringToJSONObject(NSString *string);


NS_ASSUME_NONNULL_END


