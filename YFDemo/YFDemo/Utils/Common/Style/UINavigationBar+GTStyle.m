//
//  UINavigationBar+GTStyle.m
//  GoodThing
//
//  Created by hmj on 2017/9/19.
//  Copyright © 2017年 GoodThing. All rights reserved.
//

#import "UINavigationBar+GTStyle.h"
#import "UIImage+GTImage.h"
#import "YFConstant.h"

@implementation UINavigationBar (GTStyle)

+ (void)initialize{
    
    //使用这个以后所有其他自定义类的nav都会使用该背景色
    //UINavigationBar *bar = [UINavigationBar appearance];
    //只在本类及子类有效
    //UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setTintColor:RGB(0x4A4A4A)];
    [navigationBar setBarTintColor:[UIColor whiteColor]];

    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor], NSFontAttributeName : [UIFont systemFontOfSize:15 weight:UIFontWeightMedium]}];

    UIImage *image = [UIImage imageWithColor:[UIColor orangeColor]];
    [navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];

    [navigationBar setShadowImage:[UIImage new]];
    
    // 设置返回按钮图片
    UIImage *backImage = [UIImage imageNamed:@"navigation_back_icon"];
    backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navigationBar.backIndicatorTransitionMaskImage = backImage;
    navigationBar.backIndicatorImage = backImage;
    // 将返回按钮的文字移到屏幕外面
    UIBarButtonItem *backItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UINavigationBar class]]];
    UIOffset offset = UIOffsetMake(-100, 0);
    [backItem setBackButtonTitlePositionAdjustment:offset forBarMetrics:UIBarMetricsDefault];
}

@end
