//
//  UIView+JCSnapShot.m
//  CollectionLayoutTest
//
//  Created by Cerko on 16/7/29.
//  Copyright © 2016年 Cerko. All rights reserved.
//

#import "UIView+JCSnapShot.h"

@implementation UIView (JCSnapShot)

#pragma mark - Screen Shotting Methods

- (UIImage *)snapShot {
    return [self toImageWithSize:self.bounds.size];
}

- (UIImage *)toImageWithSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImageView *)snapShotImageView {
    return [self toImageViewWithSize:self.bounds.size];
}

- (UIImageView *)toImageViewWithSize:(CGSize)size {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[self toImageWithSize:size]];
    imageView.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), size.width, size.height);
    return imageView;
}


@end
