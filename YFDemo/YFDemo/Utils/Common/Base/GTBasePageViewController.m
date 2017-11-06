//
//  GTBasePageViewController.m
//  GoodThing
//
//  Created by Abel-mac on 2017/9/27.
//  Copyright © 2017年 GoodThing. All rights reserved.
//

#import "GTBasePageViewController.h"
#import "YFConstant.h"

@interface GTBasePageViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@end

@implementation GTBasePageViewController

- (instancetype)initWithControllers:(NSArray <__kindof UIViewController *>*)controllers
                      selectedIndex:(NSInteger)selectedIndex{
    if (self = [super init]) {
        
        _pageController = [[UIPageViewController alloc]
                           initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                           navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                           options:nil];
        _controllers = controllers;
        _selectedIndex = selectedIndex;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupPageController];
}

- (void)setupPageController{
    _pageController.view.backgroundColor = [UIColor whiteColor];
    _pageController.delegate = self;
    _pageController.dataSource = self;
    [_pageController setViewControllers:@[self.controllers[self.selectedIndex]]
                              direction:UIPageViewControllerNavigationDirectionForward
                               animated:YES
                             completion:nil];
    
    [self addChildViewController:self.pageController];
    [self.view addSubview:self.pageController.view];
    [self.pageController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    [_pageController setViewControllers:@[self.controllers[self.selectedIndex]]
                              direction:UIPageViewControllerNavigationDirectionForward
                               animated:YES
                             completion:nil];
}

#pragma mark PageViewDataSource
#pragma mark 返回上一个ViewController对象

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self indexOfViewController:viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    // 返回的ViewController，将被添加到相应的UIPageViewController对象上。
    // UIPageViewController对象会根据UIPageViewControllerDataSource协议方法,自动来维护次序
    // 不用我们去操心每个ViewController的顺序问题
    
    self.selectedIndex = index;
    return [self viewControllerAtIndex:index];
    
    
}
#pragma mark 返回下一个ViewController对象

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self indexOfViewController:viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [self.controllers count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

#pragma mark - 根据index得到对应的UIViewController

- (__kindof UIViewController *)viewControllerAtIndex:(NSUInteger)index {
    if (([self.controllers count] == 0) || (index >= [self.controllers count])) {
        return nil;
    }
    // 创建一个新的控制器类，并且分配给相应的数据
    return self.controllers[index];
}

#pragma mark - 数组元素值，得到下标值

- (NSUInteger)indexOfViewController:(__kindof UIViewController *)viewController {
    return [self.controllers indexOfObject:viewController];
}




@end
