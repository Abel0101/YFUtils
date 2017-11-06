//
//  UIView+GTExtension.h
//  GoodThing
//
//  Created by hmj on 2017/9/28.
//  Copyright © 2017年 GoodThing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GTExtension)

/**
 添加模糊效果

 @param image 背景图片，可以为空，UIImage，NSURL
 @param alpha 透明度
 */
- (void)addLightBlurEffectWithImage:(id)image
                              alpha:(CGFloat)alpha;

@end
