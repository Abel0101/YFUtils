//
//  UIImageView+YFExtension.h
//  GoodThing
//
//  Created by hmj on 2017/9/26.
//  Copyright © 2017年 GoodThing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (YFExtension)

- (void)yf_setImageWithURL:(NSURL *)url;

- (void)yf_setImageWithURLStr:(NSString *)url;

- (void)yf_setImageWithURLStr:(NSString *)url placeholderImageName:(NSString *)imageName;

@end
