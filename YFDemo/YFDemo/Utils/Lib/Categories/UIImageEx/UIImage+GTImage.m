//
//  UIImage+GTImage.m
//  GoodThing
//
//  Created by hmj on 2017/9/19.
//  Copyright © 2017年 GoodThing. All rights reserved.
//

#import "UIImage+GTImage.h"

@implementation UIImage (GTImage)

+ (UIImage *)imageWithColor:(UIColor *)color{

    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
