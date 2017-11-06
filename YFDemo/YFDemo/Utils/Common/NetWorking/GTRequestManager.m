//
//  GTRequestManager.m
//  GoodThing
//
//  Created by Abel-mac on 2017/9/6.
//  Copyright © 2017年 GoodThing. All rights reserved.
//

#import "GTRequestManager.h"
#import "YFRequestTool.h"
#import "YFConstant.h"

@implementation GTRequestManager

+ (void)POST:(NSString *)url params:(NSDictionary *)params success:(RequesSuccessCallBack)success failure:(RequestFailureCallBack)failure{

    NSString *requestURL = [kGTBaseUrlString stringByAppendingString:url];
    
    YFLog(@"-----------------\n URL:%@ \n Params: %@",url,params);
    
    [YFRequestTool POST:requestURL params:params progress:^(NSProgress * _Nonnull progress) {
        
    } success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        
        YFLog(@"responseObject %@",responseObject);
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable erro) {
        
        
        YFLog(@"ERROR %@",erro);
        if (failure) {
            failure(erro);
        }
    }];
}

+ (void)GET:(NSString *)url params:(NSDictionary *)params success:(RequesSuccessCallBack)success failure:(RequestFailureCallBack)failure{

    NSString *requestURL = [kGTBaseUrlString stringByAppendingString:url];
    
    YFLog(@"-----------------\n URL:%@ \n Params: %@",url,params);
    
    [YFRequestTool GET:requestURL params:params progress:^(NSProgress * _Nonnull progress) {
        
    } success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        YFLog(@"responseObject %@",responseObject);
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable erro) {
        
        YFLog(@"ERROR %@",erro);
        if (failure) {
            failure(erro);
        }
    }];
    
}

@end
