//
//  UIViewController+GTDataLoad.m
//  higoodthings
//
//  Created by hmj on 2017/9/20.
//  Copyright © 2017年 mayunfei. All rights reserved.
//

#import "UIViewController+GTDataLoad.h"
#import <MBProgressHUD.h>

static NSTimeInterval const kHUDAppearanceTime = 2.0;  // 文字提示持续时间
static CGFloat const kTextMargin = 5.0; //文字提示框到边距的距离


@implementation UIViewController (GTDataLoad)

- (void)yf_loadData{

}

- (void)yf_showErrorViewWithError:(NSError *)error{

    if (error) {
        UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"提示" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alter addAction:actionConfirm];
        
        [self presentViewController:alter animated:YES completion:nil];
    }
}

- (void)yf_showLoadingView{
    UIView *containerView = [self yf_HUDSuperView];
    [MBProgressHUD showHUDAddedTo:containerView animated:YES];
}

- (void)yf_hideLoadingView{

    [self yf_showLoadingViewWithMsg:nil];
}

- (void)yf_showLoadingViewWithMsg:(NSString *)msg{
    UIView *containerView = [self yf_HUDSuperView];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:containerView animated:YES];
    if (msg.length) {
        hud.labelText = msg;
    }
}

- (void)yf_showAlterViewWithMsg:(NSString *)msg{
    
    [self yf_showAlterViewWIthMsg:msg duration:kHUDAppearanceTime];
}

- (void)yf_showAlterViewWIthMsg:(NSString *)msg duration:(NSTimeInterval)duration{
    UIView *containerView = [self yf_HUDSuperView];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:containerView animated:YES];
    hud.labelText = msg;
    hud.margin = kTextMargin;
    hud.mode = MBProgressHUDModeText;
    [hud hide:YES afterDelay:duration];
}

- (UIView *)yf_HUDSuperView{

    if (self.navigationController.view) {
        return self.navigationController.view;
    }
    return self.view;
}


@end
