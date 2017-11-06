//
//  UIView+JCBorder.h
//  HeroShow
//
//  Created by Cerko on 16/6/29.
//  Copyright © 2016年 Cerko. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (JCBorder)

/**
 *  设置边框
 *
 *  @param width 边框宽度
 *  @param color 颜色
 */
- (void)setBorderWidth:(CGFloat)width color:(nullable UIColor *)color;

@end


NS_ASSUME_NONNULL_END