//
//  YFBaseNavigationController.m
//  GoodThing
//
//  Created by hmj on 2017/9/19.
//  Copyright © 2017年 GoodThing. All rights reserved.
//

#import "YFBaseNavigationController.h"
#import "UIImage+GTImage.h"

@interface YFBaseNavigationController ()

@end

@implementation YFBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

}

// 设置完可以在各个controller中自己设置自己的样式
- (UIStatusBarStyle)preferredStatusBarStyle{
    return self.topViewController.preferredStatusBarStyle;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
