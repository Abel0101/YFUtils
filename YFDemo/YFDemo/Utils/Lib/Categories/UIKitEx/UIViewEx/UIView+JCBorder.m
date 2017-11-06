//
//  UIView+JCBorder.m
//  HeroShow
//
//  Created by Cerko on 16/6/29.
//  Copyright © 2016年 Cerko. All rights reserved.
//

#import "UIView+JCBorder.h"

@implementation UIView (JCBorder)


- (void)setBorderWidth:(CGFloat)width color:(UIColor *)color{
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}

@end
