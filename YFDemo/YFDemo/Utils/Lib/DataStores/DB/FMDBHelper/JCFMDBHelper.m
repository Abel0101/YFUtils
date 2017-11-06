//
//  JCFMDBHelper.m
//  HeroShow
//
//  Created by Cerko on 16/8/26.
//  Copyright © 2016年 Cerko. All rights reserved.
//

#import "JCFMDBHelper.h"
#import <FMDBHelpers.h>
#import "NSJSONSerialization+JCFactory.h"
#import "CompositionConstants.h"
#import "JCDataAdapter.h"



#pragma mark - Keys
NSString *const kTableColumnKeyUUID = @"UUID";
NSString *const kTableColumnKeyURL = @"URL";
NSString *const kTableColumnKeyCreateAt = @"createAt";
NSString *const kTableColumnKeyUpdateAt = @"updateAt";
NSString *const kTableColumnKeyUserInfo = @"userInfo";
NSString *const kTableColumnKeyJsonData = @"jsonData";

NSString *const kTableFieldTypeTEXT = @"TEXT";
NSString *const kTableFieldTypeBLOB = @"BLOB";
NSString *const kTableFieldTypeINTEGER = @"INTEGER";
NSString *const kTableFieldTypeREAL = @"REAL";
NSString *const kTableFieldTypeTIMESTAMP = @"TIMESTAMP";

NSString *const kTableContraintPrimaryKey = @"PRIMARY KEY";

NSString *const kTableSortTypeDesc = @"DESC";
NSString *const kTableSortTypeAsc = @"ASC";




@interface JCFMDBHelper ()

@property (nonatomic, strong) FMDatabaseQueue *queue;

@end

@implementation JCFMDBHelper

static JCFMDBHelper *_currentDB = nil;

+ (instancetype)currentDB{
    return _currentDB;
}


+ (void)setCurrentDB:(JCFMDBHelper *)DB{
    
    if (_currentDB != DB) {
        [_currentDB.queue close];
        _currentDB = DB;
    }
}



- (instancetype)initWithDatabasePath:(NSString *)filePath{
    if (self = [super init]) {
        _filePath = filePath;
        self.queue = [FMDatabaseQueue databaseQueueWithPath:filePath];
    }
    return self;
}



+ (NSArray <NSString *> *)baseColumns{
    static NSArray <NSString *> *baseColumns = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        baseColumns = @[STRING_BY_COMBINE_WITH_SPACE(kTableColumnKeyUUID, STRING_BY_COMBINE_WITH_SPACE(kTableFieldTypeTEXT, kTableContraintPrimaryKey)),STRING_BY_COMBINE_WITH_SPACE(kTableColumnKeyCreateAt, kTableFieldTypeTIMESTAMP),STRING_BY_COMBINE_WITH_SPACE(kTableColumnKeyUpdateAt, kTableFieldTypeTIMESTAMP),STRING_BY_COMBINE_WITH_SPACE(kTableColumnKeyUserInfo, kTableFieldTypeTEXT),STRING_BY_COMBINE_WITH_SPACE(kTableColumnKeyJsonData, kTableFieldTypeTEXT)];
    });
    return baseColumns;
}



void insertToTableNameWithJSONStringAndUserInfoAndCallback(FMDatabase *db, NSString *tableName,NSString *UUID, id JSONString, id userInfo,NSTimeInterval timeinterval, JCDBSaveCallback callback, NSError ** error_p ){
    
    
    [db insertInto:tableName row:@{kTableColumnKeyUUID:UUID,
                                   kTableColumnKeyCreateAt:@(timeinterval),
                                   kTableColumnKeyUpdateAt:@(timeinterval),
                                   kTableColumnKeyJsonData:JSONString,
                                   kTableColumnKeyUserInfo:userInfo ? JSONObjectToString(userInfo) : [NSNull null]} error:error_p];
    
    if (callback) {
        callback(JCDBSaveTypeInsert, UUID, @(timeinterval), @(timeinterval));
    }
}

void updateTableNameWithJSONStringAndUserInfoAndCallback(FMDatabase *db, NSString *tableName,NSString *UUID, id JSONString, id userInfo,NSTimeInterval timeinterval, JCDBSaveCallback callback, NSError ** error_p ){
    
    [db update:tableName values:@{kTableColumnKeyUpdateAt:@(timeinterval),
                                  kTableColumnKeyJsonData:JSONString,
                                  kTableColumnKeyUserInfo:userInfo ? JSONObjectToString(userInfo): [NSNull null]} matchingValues:@{kTableColumnKeyUUID: UUID} error:error_p];
    if (callback) {
        callback(JCDBSaveTypeUpdate, UUID, nil, @(timeinterval));
    }
}



void insertToTableNameWithJSONStringAndParamsAndCallback(FMDatabase *db, NSString *tableName,NSString *UUID, id JSONString, NSDictionary<NSString *, id> *params,NSTimeInterval timeinterval, JCDBSaveCallback callback, NSError ** error_p ){
    
    NSMutableDictionary <NSString *, id> *rows = [NSMutableDictionary dictionaryWithDictionary:params];
    [rows addEntriesFromDictionary:@{kTableColumnKeyUUID:UUID,
                                    kTableColumnKeyCreateAt:@(timeinterval),
                                    kTableColumnKeyUpdateAt:@(timeinterval),
                                     kTableColumnKeyJsonData:JSONString}];
    
    
    [db insertInto:tableName row:rows error:error_p];
    
    if (callback) {
        callback(JCDBSaveTypeInsert, UUID, @(timeinterval), @(timeinterval));
    }
}

void updateTableNameWithJSONStringAndParamsAndCallback(FMDatabase *db, NSString *tableName,NSString *UUID, id JSONString, NSDictionary<NSString *, id> *params,NSTimeInterval timeinterval, JCDBSaveCallback callback, NSError ** error_p ){
    
    
    NSMutableDictionary <NSString *, id> *rows = [NSMutableDictionary dictionaryWithDictionary:params];
    [rows addEntriesFromDictionary:@{kTableColumnKeyUpdateAt:@(timeinterval),
                                     kTableColumnKeyJsonData:JSONString
                                     }];

    
    [db update:tableName values:rows matchingValues:@{kTableColumnKeyUUID: UUID} error:error_p];
    if (callback) {
        callback(JCDBSaveTypeUpdate, UUID, nil, @(timeinterval));
    }
}




- (void)saveWithUUID:(nullable NSString *)UUID
         toTableName:(NSString *)tableName
            jsonData:(nullable id)jsonData
            userInfo:(nullable id)userInfo
            callback:(nullable JCDBSaveCallback)callback
               error:(NSError **)error_p{
    
    NSAssert(tableName.length, @"Table name can not be nil!!");
    
    
    [self.queue inDatabase:^(FMDatabase *db) {
        if (![db tableExists:tableName]) {
            [self createTableWithDB:db tableName:tableName];
        }
        
        //兼容java 用1970，否则用reference Date,2001年
        NSTimeInterval timeinterval = [[NSDate date] timeIntervalSince1970];
        
        //1.如果有数据,则判断是否有UUID，如果有ID，则是更新，没有，则插入
        
        if (jsonData) {
            
            NSString *jsonString = JSONObjectToString(jsonData);
            
            
            if (UUID.length) {
                
                NSInteger count = [db countFrom:tableName matchingValues:@{kTableColumnKeyUUID: UUID} error:error_p];
                
                if (count > 0) {
                    //有数据,更新
                    updateTableNameWithJSONStringAndUserInfoAndCallback(db, tableName, UUID, jsonString, userInfo, timeinterval, callback, error_p);

                }else{
                    //没数据，直接用传进来的ID插
                    insertToTableNameWithJSONStringAndUserInfoAndCallback(db, tableName,UUID, jsonString, userInfo, timeinterval, callback, error_p);
                }

            }else{
                //创建一个新的ID插入
                insertToTableNameWithJSONStringAndUserInfoAndCallback(db, tableName,[NSUUID UUID].UUIDString, jsonString, userInfo, timeinterval, callback, error_p);
            }
            
        }else{
            //2.没有数据，如果有UUID，则删除该数据
            if (UUID.length) {
                [db deleteFrom:tableName matchingValues:@{kTableColumnKeyUUID:UUID} error:error_p];
            }
            if (callback) {
                callback(JCDBSaveTypeDelete, nil, nil, nil);
            }
        }
        
    }];
    
}

- (void)saveWithUUID:(nullable NSString *)UUID
         toTableName:(NSString *)tableName
            jsonData:(nullable id)jsonData
              params:(nullable NSDictionary <NSString *, id> *)params
            callback:(nullable JCDBSaveCallback)callback
               error:(NSError **)error_p{
    
    NSAssert(tableName.length, @"Table name can not be nil!!");
    
    
    [self.queue inDatabase:^(FMDatabase *db) {
        if (![db tableExists:tableName]) {
            [self createTableWithDB:db tableName:tableName];
        }
        
        if (params.count) {
            NSArray <NSString *> *keys = params.allKeys;
            [keys enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if (![db columnExists:obj inTableWithName:tableName]) {
                    NSError *error = nil;
                    [db addColumn:obj toTable:tableName error:&error];
                    if (error) {
                        NSLog(@"Add column error:%@", error);
                    }
                }
            }];
        }
        
        //兼容java 用1970，否则用reference Date,2001年
        NSTimeInterval timeinterval = [[NSDate date] timeIntervalSince1970];
        
        //1.如果有数据,则判断是否有UUID，如果有ID，则是更新，没有，则插入
        
        if (jsonData) {
            
            NSString *jsonString = JSONObjectToString(jsonData);
            
            
            if (UUID.length) {
                
                NSInteger count = [db countFrom:tableName matchingValues:@{kTableColumnKeyUUID: UUID} error:error_p];
                
                if (count > 0) {
                    updateTableNameWithJSONStringAndParamsAndCallback(db, tableName, UUID, jsonString, params, timeinterval, callback, error_p);
                    //有数据,更新
                }else{
                    //没数据，直接用传进来的ID插
                    insertToTableNameWithJSONStringAndParamsAndCallback(db, tableName, UUID, jsonString, params, timeinterval, callback, error_p);
                    
                }
                
            }else{
                //创建一个新的ID插入
                insertToTableNameWithJSONStringAndParamsAndCallback(db, tableName, [NSUUID UUID].UUIDString, jsonString, params, timeinterval, callback, error_p);
            }
            
        }else{
            //2.没有数据，如果有UUID，则删除该数据
            if (UUID.length) {
                [db deleteFrom:tableName matchingValues:@{kTableColumnKeyUUID:UUID} error:error_p];
            }
            if (callback) {
                callback(JCDBSaveTypeDelete, nil, nil, nil);
            }
        }
        
    }];
    
}







- (void)createTableWithDB:(FMDatabase *)db
                tableName:(NSString *)tableName
                  columns:(NSArray <NSString *> *)aColumns
          tableExistBlock:(void (^)())block{
    
    if (![db tableExists:tableName]) {
        
        NSMutableArray <NSString *> *columns = [[self class] baseColumns].mutableCopy;
        [columns addObjectsFromArray:aColumns];
        NSError *error = nil;
        [db createTableWithName:tableName
                        columns:columns
                    constraints:nil
                          error:&error];
        if (error) {
            NSLog(@"createTable:%@, error:%@", tableName, error);
        }
        
        
        //创建索引 创建时间的索引和更新时间的索引
        [db createIndexWithName:[NSString stringWithFormat:@"%@_create_at_index",tableName] tableName:tableName columns:@[kTableColumnKeyCreateAt] error:&error];
        [db createIndexWithName:[NSString stringWithFormat:@"%@_update_at_index",tableName] tableName:tableName columns:@[kTableColumnKeyUpdateAt] error:&error];
        
    }else{
        if (block) {
            block();
        }
    }
}


- (void)createTableWithDB:(FMDatabase *)db
                tableName:(NSString *)tableName{
    [self createTableWithDB:db tableName:tableName columns:@[] tableExistBlock:NULL];
}

- (NSArray <NSDictionary <NSString *, id> *> *)selectFromTable:(NSString *)tableName
                                                         where:(nullable NSDictionary <NSString *, id> *)where
                                                     withLimit:(nullable NSNumber *)limit
                                                        offset:(nullable NSNumber *)offset
                                                       orderBy:(nullable NSString *)orderBy
                                                         error:(NSError **)error_p{
    __block NSArray <NSDictionary <NSString *, id> *> *results = nil;
    [self.queue inDatabase:^(FMDatabase *db) {
        results = [db selectResults:nil
                               from:tableName
                     matchingValues:where
                            orderBy:orderBy
                              limit:limit
                             offset:offset
                              error:error_p].allRecords;
    }];
    
    return results;

}


- (NSArray <NSDictionary <NSString *, id> *> *)selectFromTable:(NSString *)tableName
                        withLimit:(nullable NSNumber *)limit
                           offset:(nullable NSNumber *)offset
                          orderBy:(nullable NSString *)orderBy
                            error:(NSError **)error_p{
    return [self selectFromTable:tableName
                           where:nil
                       withLimit:limit
                          offset:offset
                         orderBy:orderBy
                           error:error_p];
}


- (NSArray <NSDictionary <NSString *, id> *> *)selectFromTable:(NSString *)tableName
         orderByCreateAtWithLimit:(nullable NSNumber *)limit
                           offset:(nullable NSNumber *)offset
                            error:(NSError **)error_p{
    return [self selectFromTable:tableName withLimit:limit offset:offset orderBy:STRING_BY_COMBINE_WITH_SPACE(kTableColumnKeyCreateAt, kTableSortTypeDesc) error:error_p];
}

- (NSArray <NSDictionary <NSString *, id> *> *)selectFromTable:(NSString *)tableName
                                                          page:(JCPage *)page
                                                       orderBy:(nullable NSString *)orderBy
                                                         error:(NSError **)error_p{
    
    return [self selectFromTable:tableName withLimit:page? @(page.limit): nil offset:page? @(page.skip): nil orderBy:orderBy error:error_p];
}


- (NSInteger)countFromTableName:(NSString *)tableName
                 matchingValues:(nullable NSDictionary *)matchingValues error:(NSError **)error_p{
    __block NSInteger count = 0;
    
    [self.queue inDatabase:^(FMDatabase *db) {
        count = [db countFrom:tableName matchingValues:matchingValues error:error_p];
    }];
    return count;
}


@end



void deleteFromDB(NSString *tableName, NSString *UUID){
    
    errorHandlerBlock(STRING_BY_COMBINE_WITH_SPACE(tableName, @"delete"), ^(NSError * _Nullable __autoreleasing * _Nullable error) {
        [[JCFMDBHelper currentDB] saveWithUUID:UUID toTableName:tableName jsonData:nil userInfo:nil callback:NULL error:error];
    });
    
}

void saveToDBWithCallback(NSString *tableName, id JSONData, JCDBSaveCallback callback){
    
    errorHandlerBlock(STRING_BY_COMBINE_WITH_SPACE(tableName, @"save"), ^(NSError * _Nullable __autoreleasing * _Nullable error) {
        [[JCFMDBHelper currentDB] saveWithUUID:nil toTableName:tableName jsonData:JSONData userInfo:nil callback:callback error:error];
    });
    
}

void saveToDB(NSString *tableName, id JSONData){
    
    errorHandlerBlock(STRING_BY_COMBINE_WITH_SPACE(tableName, @"save"), ^(NSError * _Nullable __autoreleasing * _Nullable error) {
        [[JCFMDBHelper currentDB] saveWithUUID:nil
                                             toTableName:tableName
                                                jsonData:JSONData
                                                userInfo:nil
                                                callback:NULL
                                                   error:error];
        
        
    });
    
}

void saveToDBWithUUIDAndCallback(NSString *tableName,NSString *UUID, id JSONData,id userInfo, JCDBSaveCallback callback){
    errorHandlerBlock(STRING_BY_COMBINE_WITH_SPACE(tableName, @"save"), ^(NSError * _Nullable __autoreleasing * _Nullable error) {
        [[JCFMDBHelper currentDB] saveWithUUID:UUID
                                             toTableName:tableName
                                                jsonData:JSONData
                                                userInfo:userInfo
                                                callback:callback
                                                   error:error];
        
    });
}

void saveToDBWithUUIDAndParamsCallback(NSString *tableName,NSString *UUID, id JSONData,NSDictionary <NSString *, id> *params, JCDBSaveCallback callback){
    errorHandlerBlock(STRING_BY_COMBINE_WITH_SPACE(tableName, @"save"), ^(NSError * _Nullable __autoreleasing * _Nullable error) {
        [[JCFMDBHelper currentDB] saveWithUUID:UUID
                                             toTableName:tableName
                                                jsonData:JSONData
                                                  params:params
                                                callback:callback
                                                   error:error];
        
        
    });
}



NSArray *selectFromDB(NSString *tableName,JCPage *page,NSDictionary <NSString *,id> *where, NSString *orderBy,id (^convertBlock)(NSDictionary <NSString *, id> *srcObj)){
    __block NSArray *results = nil;
    errorHandlerBlock(STRING_BY_COMBINE_WITH_SPACE(tableName, @"SELECT"), ^(NSError * _Nullable __autoreleasing * _Nullable error) {
        NSArray <NSDictionary <NSString *, id> *> *datas =  [[JCFMDBHelper currentDB] selectFromTable:tableName where:where withLimit:page ? @(page.limit) : nil offset:page ? @(page.skip) : nil orderBy:orderBy error:error];
        results = [datas arrayByConvertBlock:convertBlock];
    });
    return results;
}

NSInteger countFromTable(NSString *tableName, NSDictionary * _Nullable matching){
    __block NSInteger count = 0;
    errorHandlerBlock(STRING_BY_COMBINE_WITH_SPACE(tableName, @"COUNT"), ^(NSError * _Nullable __autoreleasing * _Nullable error) {
        count = [[JCFMDBHelper currentDB] countFromTableName:tableName matchingValues:matching error:error];
    });
    return count;
}



