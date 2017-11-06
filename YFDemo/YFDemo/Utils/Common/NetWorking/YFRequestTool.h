//
//  YFRequestTool.h
//  GoodThing
//
//  Created by Abel-mac on 2017/9/6.
//  Copyright © 2017年 GoodThing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^YFSuccessCallBack)(NSURLSessionDataTask *_Nullable task,id _Nullable responseObject);
typedef void(^YFFailureCallBack)(NSURLSessionDataTask *_Nullable task,NSError *_Nullable erro);


@interface YFRequestTool : NSObject

/**
 GET 请求

 @param url url
 @param params param
 @param success 返回json
 @param failure error
 */
+ (void)GET:(NSString *_Nonnull)url params:(NSDictionary *_Nonnull)params progress:(void (^)(NSProgress * _Nonnull))downloadProgress success:(YFSuccessCallBack)success failure:(YFFailureCallBack)failure;


/**
 POST 请求

 @param url url
 @param params param
 @param success 返回json
 @param failure error
 */

+ (void)POST:(NSString *_Nonnull)url params:(NSDictionary *_Nonnull)params progress:(void (^)(NSProgress * _Nonnull progress))downloadProgress success:(YFSuccessCallBack)success failure:(YFFailureCallBack)failure;


/**
 多图片上传

 @param imageArray 图片数组
 @param url 上传URLStr
 @param params 参数
 @param downloadProgress 进度
 @param success 状态
 @param failure 状态
 */
+ (void)uploadImages:(NSArray <UIImage *>*)imageArray urlString:(NSString *_Nonnull)url params:(NSDictionary *_Nonnull)params progress:(void (^)(NSProgress * _Nonnull progress))downloadProgress success:(YFSuccessCallBack)success failure:(YFFailureCallBack)failure;

@end

NS_ASSUME_NONNULL_END
