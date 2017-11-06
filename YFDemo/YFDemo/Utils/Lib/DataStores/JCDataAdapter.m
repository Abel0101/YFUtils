//
//  JCDataAdapter.m
//  HeroShow
//
//  Created by Cerko on 16/8/5.
//  Copyright © 2016年 Cerko. All rights reserved.
//

#import "JCDataAdapter.h"


id excuteDataAdapter(JCDataAdapter adapter, id data){
    if (!adapter) {
        return nil;
    }
    
    return adapter(data);
}
id excuteDataAdapterEasy(JCDataAdapter2 adapter){
    return adapter();
}


@implementation NSArray (JCDataAdapter)

- (BOOL)isIndexValid:(NSUInteger)idx{
    return idx < self.count;
}

- (id)jc_objectAtIndex:(NSUInteger)index{
    if ([self isIndexValid:index]) {
        return [self objectAtIndex:index];
    }
    return nil;
}

- (BOOL)containsWithBlock:(BOOL (^)(id _Nonnull))block{
    for (id obj in self) {
        BOOL result = block(obj);
        if (result) {
            return YES;
        }
    }
    return NO;
}


- (NSMutableArray *)arrayByConvertBlock:(id  _Nullable (^)(id _Nonnull))block{
    NSMutableArray  *array = [NSMutableArray arrayWithCapacity:self.count];
    for (id data in self) {
        id convertedData = block ? block(data) : data;
        if (!convertedData) {
            continue;
        }
        
       [array addObject:convertedData];
    }
    
    
    return array;
}

- (NSMutableArray *)arraysByConvertBlock:(id _Nullable (^)(id _Nonnull obj, NSInteger idx))block{
    NSMutableArray  *array = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id convertedData = block(obj, idx);
        if (!convertedData) {
            return ;
        }
        [array addObject:convertedData];
    }];
    
    return array;
}

- (NSMutableArray *)arraysByConvertArrayBlock:(id _Nullable (^)(NSMutableArray *array, id obj, NSInteger idx))block{
    
    NSMutableArray  *array = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id convertedData = block(array, obj, idx);
        if (!convertedData) {
            return ;
        }
        [array addObject:convertedData];
    }];
    
    return array;
}


- (id)objectByFilter:(id  _Nullable (^)(id _Nonnull))block{
    for (id data in self) {
        id convertedData = block(data);
        if (convertedData) {
            return convertedData;
        }
    }
    
    return nil;
}

@end


@implementation NSObject (JCDataAdapter)

- (id)objectByConvertBlock:(id  _Nullable (^)(id _Nonnull))block{
    id obj = block(self);
    if (obj) {
        return obj;
    }
    return self;
}

@end

@implementation NSDictionary (JCDataAdapter)


- (NSMutableDictionary *)dicByConvertBlock:(void (^)(NSMutableDictionary * _Nonnull))block{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self];
    if (block) {
        block(dic);
    }
    return dic;
}

- (NSMutableDictionary *)dictByConvertIterateWithBlock:(id _Nullable (^)(id _Nonnull, id _Nonnull, BOOL * _Nonnull))block{
    NSMutableDictionary *theDic = [NSMutableDictionary dictionaryWithDictionary:self];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (block) {
            id theObj = block(key, obj, stop);
            if (theObj) {
                theDic[key] = theObj;
            }
        }
        
    }];
    return theDic;
    
}


@end



