//
//  GTBasePageViewController.h
//  GoodThing
//
//  Created by Abel-mac on 2017/9/27.
//  Copyright © 2017年 GoodThing. All rights reserved.
//

#import "GTBaseController.h"

@interface GTBasePageViewController : GTBaseController
@property (nonatomic, strong) NSArray <__kindof UIViewController *>*controllers;
@property (nonatomic, assign) NSInteger selectedIndex;
/**
 水平滑动

 @param controllers Controllers
 @return controller
 */
- (instancetype)initWithControllers:(NSArray <__kindof UIViewController *>*)controllers
                      selectedIndex:(NSInteger)selectedIndex;

@property (nonatomic, strong) UIPageViewController *pageController;

@end
