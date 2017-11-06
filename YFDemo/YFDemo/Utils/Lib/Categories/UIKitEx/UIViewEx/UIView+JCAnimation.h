//
//  UIView+JCAnimation.h
//  HeroShow
//
//  Created by Cerko on 16/7/8.
//  Copyright © 2016年 Cerko. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (JCAnimation)


/**
 *  做动画的简便方法，在动画前会禁用掉View的交互，动画完成后会恢复交互
 *
 *  @param preparation 在做动画之前的准备工作
 *  @param animations  做动画的代码
 *  @param completion  动画完成后的代码
 *  @param animated    YES 需要动画
 *  @param duration    动画时长
 */
- (void)jc_doAnimatePreparation:(void (^ __nullable)())preparation
                     animations:(void (^)())animations
                     completion:(void (^ __nullable)(BOOL finished))completion
                       animated:(BOOL)animated
                       duration:(NSTimeInterval)duration;

/**
 *  做动画的简便方法，在动画前会禁用掉View的交互，动画完成后会恢复交互，默认0.25秒的动画
 *
 *  @param preparation 在做动画之前的准备工作
 *  @param animations  做动画的代码
 *  @param completion  动画完成后的代码
 */
- (void)jc_doAnimatePreparation:(void (^ __nullable)())preparation
                     animations:(void (^)())animations
                     completion:(void (^ __nullable)(BOOL finished))completion;


/**
 *  做动画的简便方法，preparation为NULL,在动画前会禁用掉View的交互，动画完成后会恢复交互，默认0.25秒的动画
 *
 *  @param animations 做动画的代码
 *  @param completion 动画完成后的代码
 */
- (void)jc_doAnimations:(void (^)())animations
             completion:(void (^ __nullable)(BOOL finished))completion;


#pragma mark alpha动画
/**
 *  用alpha动画来显示一个View
 *
 *  @param view 要显示的View
 */
- (void)jc_showViewUseAlphaAnimation:(UIView *)view;

/**
 *  用alpha动画来隐藏一个View
 *
 *  @param view 要隐藏的View
 */
- (void)jc_hideViewUseAlphaAnimation:(UIView *)view;


@end

NS_ASSUME_NONNULL_END