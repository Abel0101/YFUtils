//
//  YFConstant.h
//  YFDemo
//
//  Created by hmj on 2017/11/6.
//  Copyright © 2017年 lyf. All rights reserved.
//

#ifndef YFConstant_h
#define YFConstant_h

#ifdef DEBUG
#define YFLog(...) NSLog(__VA_ARGS__)
#else
#define YFLog(...)
#endif

#define RGB(rgb) [UIColor colorWithRed:(rgb/0x10000)/255.0f green:((rgb/0x100)&0xFF)/255.0f blue:(rgb&0xFF)/255.0f alpha:1]

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define kGTBaseUrlString  @""

#import <UIImageView+WebCache.h>
#import <Masonry.h>
#import <MJExtension.h>
#import <AFNetworking.h>

#endif /* YFConstant_h */
