//
//  UIView+JCCornerRadius.h
//  HeroShow
//
//  Created by Cerko on 16/6/23.
//  Copyright © 2016年 Cerko. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (JCCornerRadius)

/**
 *  圆角视图，会调用setCornerRadius
 *
 *  @param cornerRadius 圆角大小
 *
 *  @return 圆角视图
 */
+ (instancetype)viewWithCornerRadius:(CGFloat)cornerRadius;


/**
 *  工厂方法传入背景颜色
 *
 *  @param backgroundColor 背景色
 *
 *  @return instance
 */
+ (instancetype)viewWithBackgroundColor:(nullable UIColor *)backgroundColor;

/**
 *  工厂方法传入背景颜色，圆角
 *
 *  @param backgroundColor 背景色
 *  @param cornerRadius    圆角
 *
 *  @return UIView
 */
+ (instancetype)viewWithBackgroundColor:(nullable UIColor *)backgroundColor
                           cornerRadius:(CGFloat)cornerRadius;
/**
 *  设置圆角
 *
 *  @param cornerRadius 圆角大小
 */
- (void)setCornerRadius:(CGFloat)cornerRadius;



@end

NS_ASSUME_NONNULL_END
