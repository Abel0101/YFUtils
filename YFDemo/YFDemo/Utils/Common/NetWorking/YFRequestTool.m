//
//  YFRequestTool.m
//  GoodThing
//
//  Created by Abel-mac on 2017/9/6.
//  Copyright © 2017年 GoodThing. All rights reserved.
//

#import "YFRequestTool.h"
#import "YFConstant.h"


@implementation YFRequestTool

+ (void)GET:(NSString *_Nonnull)url params:(NSDictionary *_Nonnull)params progress:(void (^)(NSProgress * _Nonnull))downloadProgress success:(YFSuccessCallBack)success failure:(YFFailureCallBack)failure{

   
   
    
    
    [[AFHTTPSessionManager manager] GET:url parameters:params progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(task,responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            
            failure(task, error);
        }
    }];
}

+ (void)POST:(NSString *_Nonnull)url params:(NSDictionary *_Nonnull)params progress:(void (^)(NSProgress * _Nonnull progress))downloadProgress success:(YFSuccessCallBack)success failure:(YFFailureCallBack)failure{

    [[AFHTTPSessionManager manager] POST:url parameters:params progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
            success (task,responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(task, error);
        }
    }];

}

+ (void)uploadImages:(NSArray<UIImage *> *)imageArray urlString:(NSString *)url params:(NSDictionary *)params progress:(void (^)(NSProgress * _Nonnull))downloadProgress success:(YFSuccessCallBack)success failure:(YFFailureCallBack)failure{
    
    [[AFHTTPSessionManager manager] POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [imageArray enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            
            // 压缩图片，指定宽度
            // UIImage *  resizedImage =  [UIImage imageCompressed:image withdefineWidth:width];
            NSData * imgData = UIImageJPEGRepresentation(obj, 0.5);
            // 拼接Data
            // name：对应网站上[upload.php中]处理文件的字段（比如upload）
            // fileName：要保存在服务器上的文件名
            // mimeType：上传的文件的类型
            [formData appendPartWithFileData:imgData name:[NSString stringWithFormat:@"picflie%ld",(long)idx] fileName:@"image.png" mimeType:@" image/jpeg"];
            idx ++;
            
        }];
        
        
    } progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}


@end
