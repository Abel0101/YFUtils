//
//  UIView+GTExtension.m
//  GoodThing
//
//  Created by hmj on 2017/9/28.
//  Copyright © 2017年 GoodThing. All rights reserved.
//

#import "UIView+GTExtension.h"
#import "UIImageView+YFExtension.h"
#import "UIImage+GTImage.h"

@implementation UIView (GTExtension)

- (void)addLightBlurEffectWithImage:(id)image
                           alpha:(CGFloat)alpha{
    
    [self addBlurEffectWithImage:image blurStyle:UIBlurEffectStyleLight alpha:alpha];
}
- (void)addBlurEffectWithImage:(id)image
                  blurStyle:(UIBlurEffectStyle)style
                      alpha:(CGFloat)alpha{
    
    CGRect imageRect = CGRectZero;
    imageRect.size = self.bounds.size;
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.clipsToBounds = YES;
    bgImageView.frame = imageRect;
    
    if ([image isKindOfClass:[UIImage class]]) {
        bgImageView.image = image;
    }else if ([image isKindOfClass:[NSURL class]]){
        [bgImageView yf_setImageWithURL:image];
    }else{
        bgImageView.image = [UIImage imageWithColor:[UIColor whiteColor]];
    }
    CGRect blurRect = CGRectZero;
    blurRect.size = self.bounds.size;
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:style];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectview.frame = blurRect;
    bgImageView.alpha = alpha;
    [bgImageView addSubview:effectview];
    [self addSubview:bgImageView];
}

@end

