//
//  JCCallbacks.h
//  QuickMovie
//
//  Created by Cerko on 16/10/25.
//  Copyright © 2016年 Cerko. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class UIViewController;

typedef void(^JCDictionaryCallback)( NSDictionary  * _Nullable dic , NSError  * _Nullable error);
typedef void(^JCArrayCallback)( NSArray * _Nullable array, NSError* _Nullable error);
typedef void(^JCDataRenderCallback)( id _Nullable data, NSError * _Nullable error);
typedef void(^JCDataBoolCallback)( BOOL succeeded, NSError * _Nullable error);
typedef void(^JCStringCallback)( NSString *_Nullable url, NSError *_Nullable error);
typedef void(^JCCollectionViewControllerCallback)(__kindof UIViewController *controller,NSIndexPath *indexPath);
typedef void(^JCProgressCallback)( float progress);

NS_ASSUME_NONNULL_END