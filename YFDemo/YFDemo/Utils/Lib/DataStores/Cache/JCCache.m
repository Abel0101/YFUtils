//
//  JCCache.m
//  HeroShow
//
//  Created by Cerko on 16/8/5.
//  Copyright © 2016年 Cerko. All rights reserved.
//

#import "JCCache.h"
#import <UIKit/UIKit.h>

@implementation JCCache

+ (instancetype)sharedInstance
{
    static JCCache* instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });

    return instance;
}

- (instancetype)init{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didReceiveMemoryWarn)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
    }
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarn{
    [self removeAllObjects];
}



@end
