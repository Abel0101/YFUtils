//
//  JCFMDBHelper.h
//  HeroShow
//
//  Created by Cerko on 16/8/26.
//  Copyright © 2016年 Cerko. All rights reserved.
//


#import <FMDB.h>
#import "JCPage.h"

NS_ASSUME_NONNULL_BEGIN

#define STRING_BY_COMBINE_WITH_SPACE(string, property) [NSString stringWithFormat:@"%@ %@",(string), (property)]

/**
 操作类型

 - JCDBSaveTypeInsert: 插入
 - JCDBSaveTypeUpdate: 修改
 - JCDBSaveTypeDelete: 删除
 */
typedef NS_ENUM(NSUInteger, JCDBSaveType) {
    JCDBSaveTypeInsert,
    JCDBSaveTypeUpdate,
    JCDBSaveTypeDelete
};



typedef void (^JCDBSaveCallback)(JCDBSaveType saveType, NSString * _Nullable UUID, NSNumber *_Nullable createAt, NSNumber *_Nullable updateAt);


#pragma mark - Keys
//ID
extern NSString *const kTableColumnKeyUUID;
//URL
extern NSString *const kTableColumnKeyURL;
//创建时间
extern NSString *const kTableColumnKeyCreateAt;
//更新时间
extern NSString *const kTableColumnKeyUpdateAt;
//额外数据
extern NSString *const kTableColumnKeyUserInfo;

//JSON的NSData
extern NSString *const kTableColumnKeyJsonData;


#pragma mark - 表的字段类型
//TEXT
extern NSString *const kTableFieldTypeTEXT;
//BLOB
extern NSString *const kTableFieldTypeBLOB;
//INTEGER
extern NSString *const kTableFieldTypeINTEGER;
//REAL
extern NSString *const kTableFieldTypeREAL;
//TIMESTAMP
extern NSString *const kTableFieldTypeTIMESTAMP;

#pragma mark - 约束类型
//PRIMARY KEY
extern NSString *const kTableContraintPrimaryKey;

#pragma mark - 排序类型
//DESC
extern NSString *const kTableSortTypeDesc;
//ASC
extern NSString *const kTableSortTypeAsc;


@interface JCFMDBHelper : NSObject

//获取当前已经打开的数据库
+ (instancetype)currentDB;
//设置当前打开的数据库
+ (void)setCurrentDB:(nullable JCFMDBHelper *)DB;


/**
 *  数据库文件路径
 */
@property (nonatomic, strong, readonly) NSString *filePath;

- (instancetype)initWithDatabasePath:(NSString *)filePath;

@property (nonatomic, readonly) FMDatabaseQueue *queue;


#pragma mark - 增删改



/**
 添加，修改，或删除一条数据,最终会存成String类型

 @param UUID 可以为空，如果为空，jsonData不为空，则创建一条新数据，如果不为空，查库又没有该记录的话，会将该ID直接作为该条数据的ID存储
 @param tableName 表名
 @param jsonData 可以为空，为空就代表要删除一条数据, 数据类型为： NSDictionary, NSArray, NSString, NSData
 @param userInfo 额外数据，随便存
 @param callback 回调， saveType为当前的操作类型，如果是插入的话，会返回新的UUID,如果是更新也会返回UUID，如果是插入的话，会返回createAt 和 updateAt ，如果是更新 会返回updateAt
 @param error_p NSError指针
 */
- (void)saveWithUUID:(nullable NSString *)UUID
         toTableName:(NSString *)tableName
            jsonData:(nullable id)jsonData
            userInfo:(nullable id)userInfo
            callback:(nullable JCDBSaveCallback)callback
               error:(NSError **)error_p;



- (void)saveWithUUID:(nullable NSString *)UUID
         toTableName:(NSString *)tableName
            jsonData:(nullable id)jsonData
              params:(nullable NSDictionary <NSString *, id> *)params
            callback:(nullable JCDBSaveCallback)callback
               error:(NSError **)error_p;


//- (void)saveWithUUID:(NSString *_Nullable * _Nullable)UUID
//            createAt:(NSTimeInterval *)createAt
//            updateAt:(NSTimeInterval *)updateAt
//        toTableName:(NSString *)tableName
//           jsonData:(nullable id)jsonData
//           userInfo:(nullable id)userInfo
//              error:(NSError **)error_p;




/**
 调用上面的方法，userInfo传入空
 
 @param UUID 同上
 @param tableName 同上
 @param jsonData 同上
 @param error_p 同上
 @return 同上
 */
//- (nullable NSString *)saveWithUUID:(nullable NSString *)UUID
//         toTableName:(NSString *)tableName
//            jsonData:(nullable id)jsonData
//               error:(NSError **)error_p;


#pragma mark - 查


/**
 查询数据 UUID, createAt, updateAt, jsonData, userInfo

 @param tableName 表明
 @param where 调节
 @param limit 限制条数
 @param offset 偏移
 @param orderBy 排序
 @param error_p NSError
 @return 不会为nil，返回的数组元素数量可能为0
 */
- (NSArray <NSDictionary <NSString *, id> *> *)selectFromTable:(NSString *)tableName
                                                         where:(nullable NSDictionary <NSString *, id> *)where
                                                     withLimit:(nullable NSNumber *)limit
                                                        offset:(nullable NSNumber *)offset
                                                       orderBy:(nullable NSString *)orderBy
                                                         error:(NSError **)error_p;


/**
 查询数据 UUID, createAt, updateAt, jsonData, userInfo

 @param tableName 表名
 @param limit 限制条数
 @param offset 偏移
 @param orderBy 排序
 @param error_p NSError
 @return 不会为nil，返回的数组元素数量可能为0
 */
- (NSArray <NSDictionary <NSString *, id> *> *)selectFromTable:(NSString *)tableName
                                                     withLimit:(nullable NSNumber *)limit
                                                        offset:(nullable NSNumber *)offset
                                                       orderBy:(nullable NSString *)orderBy
                                                         error:(NSError **)error_p;


/**
 调用上面的函数传入orderBy为创建时间

 @param tableName 同上
 @param limit 同上
 @param offset 同上
 @param error_p 同上
 @return 同上
 */
- (NSArray <NSDictionary <NSString *, id> *> *)selectFromTable:(NSString *)tableName
                                      orderByCreateAtWithLimit:(nullable NSNumber *)limit
                                                        offset:(nullable NSNumber *)offset
                                                         error:(NSError **)error_p;



- (NSArray <NSDictionary <NSString *, id> *> *)selectFromTable:(NSString *)tableName
                                                          page:(nullable JCPage *)page
                                                       orderBy:(nullable NSString *)orderBy
                                                         error:(NSError **)error_p;


- (NSInteger)countFromTableName:(NSString *)tableName
                 matchingValues:(nullable NSDictionary *)matchingValues error:(NSError **)error_p;


@end



extern void deleteFromDB(NSString *tableName, NSString *UUID);
extern void saveToDBWithCallback(NSString *tableName, id JSONData, JCDBSaveCallback callback);
extern void saveToDB(NSString *tableName, id JSONData);


/**
 存储或更新到数据库
 
 @param tableName 表名
 @param UUID 可以为空，为空，自动创建UUID， 不为空，则查询该条数据是否存在，如果不存在，则根据该ID创建一条数据，否则更新该条数据
 @param JSONData 数据
 @param userInfo 随便存
 @param callback 回调
 */
extern void saveToDBWithUUIDAndCallback(NSString *tableName, NSString * _Nullable UUID, _Nullable id JSONData,_Nullable id userInfo,_Nullable JCDBSaveCallback callback);


extern void saveToDBWithUUIDAndParamsCallback(NSString *tableName,NSString *UUID, id JSONData, NSDictionary <NSString *, id> * _Nullable params, _Nullable JCDBSaveCallback callback);


/**
 查询并会调用转换block
 
 @param tableName 表名
 @param page 分页 ，可以为空
 @param where 条件,可以为空
 @param orderBy 排序，可以为空
 @param ^convertBlock 转换回调
 @return 结果
 */
extern NSArray *selectFromDB(NSString *tableName, JCPage *_Nullable page, NSDictionary <NSString *,id> * _Nullable where, NSString *_Nullable orderBy,_Nullable id (^convertBlock)(NSDictionary <NSString *, id> *srcObj));


extern NSInteger countFromTable(NSString *tableName, NSDictionary * _Nullable matching);

NS_ASSUME_NONNULL_END

#import "JCFMDBHelper+HSUtils.h"
