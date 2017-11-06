//
//  NSFileManager+JCExtension.h
//  HeroShow
//
//  Created by Cerko on 16/8/23.
//  Copyright © 2016年 Cerko. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (JCExtension)

/**
 *  创建一个目录如果该目录不存在
 *
 *  @param directory 目录
 *
 *  @return YES 创建成功或已存在
 */
- (BOOL)createDirectoryIfNotExist:(NSString *)directory;


/**
 
 创建一个目录，如果该目录不存在的话
 @param url 目录的url
 @return YES 创建成功
 */
- (BOOL)createDirectoryIfNotExistAtURL:(NSURL *)url;


/**
 将file://去掉，直接调用fileExsitAtPath

 @param url url
 @return YES 文件存在了
 */
- (BOOL)fileExistsAtURL:(NSURL *)url;


/**
 *  删除文件
 *
 *  @param file  文件路径
 *  @param async YES 异步删除
 */
- (void)removeFile:(NSString *)file async:(BOOL)async;

- (void)removeFileWithURL:(NSURL *)url async:(BOOL)async;

- (void)removeFiles:(NSArray <NSString *> *)files async:(BOOL)async;

//获取文件夹的大小 返回 M
- (float ) folderSizeAtPath:(NSString*) folderPath;
//单个文件的大小 返回  k
- (float) fileSizeAtPath:(NSString*) filePath;
//文件大小格式
- (NSString *)sizeStringFormmaterSize:(Float64)size;

@end

NS_ASSUME_NONNULL_END
