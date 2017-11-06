//
//  JCPage.m
//  PictureHandler
//
//  Created by Cerko on 2017/6/1.
//  Copyright © 2017年 Cerko. All rights reserved.
//

#import "JCPage.h"
#import "YFConstant.h"

@implementation JCPage

+ (instancetype)page{
    return [[self alloc]init];
}
- (instancetype)init{
    if (self = [super init]) {
        _page = -1;
        _pageSize = 20;
    }
    return self;
}

- (JCPage *)nextPage{
    JCPage *page = [self copy];
    page.page = self.page + 1;
    
    return page;
}

- (id)copyWithZone:(NSZone *)zone{
    JCPage *page = [[self class] allocWithZone:zone];
    page.totalCount = self.totalCount;
    page.page = self.page;
    page.pageSize = self.pageSize;
    return page;
}

- (NSInteger)limit{
    return self.pageSize;
}

- (NSInteger)skip{
    return  self.page * self.pageSize;
}

- (NSDictionary *)pageDic{
    return [self mj_keyValuesWithKeys:@[@"page",@"totalCount", @"pageSize"]];
}




@end
