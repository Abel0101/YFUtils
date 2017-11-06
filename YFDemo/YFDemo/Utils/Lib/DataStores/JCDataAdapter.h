//
//  JCDataAdapter.h
//  HeroShow
//
//  Created by Cerko on 16/8/5.
//  Copyright © 2016年 Cerko. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

typedef _Nullable id (^JCDataAdapter)( _Nullable id data);
typedef _Nullable id (^JCDataAdapter2)();

extern _Nullable id excuteDataAdapter(JCDataAdapter adapter, _Nullable id data);
extern _Nullable id excuteDataAdapterEasy(JCDataAdapter2 adapter);

@interface NSArray<__covariant ObjectType> (JCDataAdapter)


/**
 是否当前索引超过了Count

 @param index 索引
 @return YES 有效
 */
- (BOOL)isIndexValid:(NSUInteger)idx;

/**
 如果索引超过了count，就返回nil

 @param index 索引
 @return nil, 如果index
 */
- (ObjectType)jc_objectAtIndex:(NSUInteger)index;


/**
    会遍历自己
 *  在Block中如果返回YES，则遍历停止返回YES
 *
 *  @param block 遍历自己的回调
 *
 *  @return YES 
 */
- (BOOL)containsWithBlock:(BOOL (^)(ObjectType obj))block;

/**
 *  从一个数组转换成另外一种类型的数组，如果在回调中返回nil，那么不会将其插入到新的数组
 *
 *  @param block 回调
 *
 *  @return 一个转换后的数组
 */
- (NSMutableArray  *)arrayByConvertBlock:(id _Nullable (^)(ObjectType obj))block;

- (NSMutableArray *)arraysByConvertBlock:(id _Nullable (^)(ObjectType obj, NSInteger idx))block;

- (NSMutableArray *)arraysByConvertArrayBlock:(id _Nullable (^)(NSMutableArray *array, ObjectType obj, NSInteger idx))block;


/**
 *  获取数组中的某个值
 *
 *  @param block 回调
 *
 *  @return id
 */
- (nullable id)objectByFilter:(id _Nullable(^)(ObjectType obj))block;

@end

@interface NSObject  (JCDataAdapter)


- (nullable id)objectByConvertBlock:(id _Nullable (^) (id obj))block;

@end




@interface NSDictionary<KeyType, ObjectType> (JCDataAdapter)

/**
 *  将Dic转成Mutable的
 *
 *  @param block 回调
 *
 *  @return Dic
 */
- (NSMutableDictionary *)dicByConvertBlock:(void (^)(NSMutableDictionary *dic))block;


/**
 转换字典中的数据

 @param block 回调，如果block 返回非空，则会将其放到新的字典中，否则就抛弃
 @return 新的字典
 */
- (NSMutableDictionary *)dictByConvertIterateWithBlock:(id _Nullable (NS_NOESCAPE ^)( KeyType key, ObjectType obj, BOOL *stop))block;

@end




NS_ASSUME_NONNULL_END
