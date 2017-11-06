//
//  UIViewController+GTDataLoad.h
//  higoodthings
//
//  Created by hmj on 2017/9/20.
//  Copyright © 2017年 mayunfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (GTDataLoad)

- (void)yf_loadData;

/**
 转菊花
 */
- (void)yf_showLoadingView;

/**
 转菊花并提示用户

 @param msg 提示语
 */
- (void)yf_showLoadingViewWithMsg:(NSString *)msg;

/**
 提示框

 @param msg 提示语
 */
- (void)yf_showAlterViewWithMsg:(NSString *)msg;

/**
 有时间限制的提示框

 @param msg 提示语
 @param duration 时间间隔
 */
- (void)yf_showAlterViewWIthMsg:(NSString *)msg duration:(NSTimeInterval)duration;

/**
 有提示框的报错

 @param error error
 */
- (void)yf_showErrorViewWithError:(NSError *)error;

/**
 隐藏HUD
 */
- (void)yf_hideLoadingView;

@end
