//
//  GTBaseController.m
//  GoodThing
//
//  Created by Abel-mac on 2017/9/6.
//  Copyright © 2017年 GoodThing. All rights reserved.
//

#import "GTBaseController.h"
#import "YFConstant.h"

@interface GTBaseController ()

@end

@implementation GTBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)dealloc{


    YFLog(@"%@ dealloc",NSStringFromClass([self class]));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
