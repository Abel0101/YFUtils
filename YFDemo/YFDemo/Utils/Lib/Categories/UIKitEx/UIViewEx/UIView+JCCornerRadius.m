//
//  UIView+JCCornerRadius.m
//  HeroShow
//
//  Created by Cerko on 16/6/23.
//  Copyright © 2016年 Cerko. All rights reserved.
//

#import "UIView+JCCornerRadius.h"

@implementation UIView (JCCornerRadius)
- (void)setCornerRadius:(CGFloat)cornerRadius;{
    self.layer.cornerRadius = cornerRadius;
    self.clipsToBounds = YES;
}

+ (instancetype)viewWithCornerRadius:(CGFloat)cornerRadius{
    return [self viewWithBackgroundColor:nil cornerRadius:cornerRadius];
}


+ (instancetype)viewWithBackgroundColor:(UIColor *)backgroundColor{
    return [self viewWithBackgroundColor:backgroundColor cornerRadius:0];
}

+ (instancetype)viewWithBackgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius{
    UIView *instance = [[[self class]alloc]init];
    [instance setCornerRadius:cornerRadius];
    instance.backgroundColor = backgroundColor;
    return instance;

}


@end
