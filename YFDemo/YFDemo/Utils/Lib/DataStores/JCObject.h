//
//  JCObject.h
//  JCCompositionLib
//
//  Created by Cerko on 16/12/28.
//  Copyright © 2016年 Cerko. All rights reserved.
//

#import "NSObject+JCJSONObject.h"

NS_ASSUME_NONNULL_BEGIN


/**
 此类重写了valueForUndefinedKey,如果该属性没有声明，那么会存到一个字典中，用来存放额外的参数
 */
@interface JCObject : NSObject <NSCopying, NSCoding>

@property (nonatomic, strong, nullable) NSString *remoteId;
@property (nonatomic, strong, nullable) NSString *UUID;
@property (nonatomic, assign) NSTimeInterval createAt;
@property (nonatomic, assign) NSTimeInterval updateAt;

@property (nonatomic, readonly) NSMutableDictionary <NSString *, id> *undefinedKeyValues;

/**
 
 调用setValue: forKey:，如果传入空值，会从字典中移除该对象
 
 @param obj 任意类型，但是可能会转成JSON，所以尽量传入可以转换成JSON的数据
 @param key 键
 */
- (void)setObject:(nullable id)obj forKey:(NSString *)key;
- (nullable id)objectForKey:(NSString *)key;



@end

NS_ASSUME_NONNULL_END
