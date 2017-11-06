//
//  GTRequestManager.h
//  GoodThing
//
//  Created by Abel-mac on 2017/9/6.
//  Copyright © 2017年 GoodThing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^RequesSuccessCallBack)(id _Nullable response);
typedef void(^RequestFailureCallBack)(NSError *_Nonnull);


@interface GTRequestManager : NSObject


+ (void)POST:(NSString *_Nonnull)url params:(NSDictionary *_Nonnull)params success:(RequesSuccessCallBack)success failure:(RequestFailureCallBack)failure;


+ (void)GET:(NSString *_Nonnull)url params:(NSDictionary *_Nonnull)params success:(RequesSuccessCallBack)success failure:(RequestFailureCallBack)failure;

@end

NS_ASSUME_NONNULL_END
