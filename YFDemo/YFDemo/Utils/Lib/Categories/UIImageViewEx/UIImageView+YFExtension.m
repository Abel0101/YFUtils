//
//  UIImageView+YFExtension.m
//  GoodThing
//
//  Created by hmj on 2017/9/26.
//  Copyright © 2017年 GoodThing. All rights reserved.
//

#import "UIImageView+YFExtension.h"
#import "YFConstant.h"


@implementation UIImageView (YFExtension)

- (void)yf_setImageWithURL:(NSURL *)url{
    
    [self yf_setImageWithURL:url placeholderImageName:nil];
}

- (void)yf_setImageWithURLStr:(NSString *)url{
    
    [self yf_setImageWithURLStr:url placeholderImageName:nil];
}

- (void)yf_setImageWithURLStr:(NSString *)url placeholderImageName:(NSString *)imageName{
    
    NSURL *URL = url ? [NSURL URLWithString:url] : nil;
    [self yf_setImageWithURL:URL placeholderImageName:imageName];
}

- (void)yf_setImageWithURL:(NSURL *)url placeholderImageName:(NSString *)imageName{
    NSURL *URL = url ? url : nil;
    UIImage *placeholderImage = imageName ? [UIImage imageNamed:imageName] : nil;
    [self sd_setImageWithURL:URL placeholderImage:placeholderImage];
}

@end
