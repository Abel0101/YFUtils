//
//  JCPage.h
//  PictureHandler
//
//  Created by Cerko on 2017/6/1.
//  Copyright © 2017年 Cerko. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JCPage : NSObject

/**
 *  Default -1
 */
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, assign) NSInteger totalCount;

@property (nonatomic, readonly) NSInteger limit;
@property (nonatomic, readonly) NSInteger skip;

- (JCPage *)nextPage;

- (NSDictionary *)pageDic;

+ (instancetype)page;




@end

NS_ASSUME_NONNULL_END
