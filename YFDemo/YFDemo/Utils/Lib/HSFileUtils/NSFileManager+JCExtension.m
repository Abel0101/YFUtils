//
//  NSFileManager+JCExtension.m
//  HeroShow
//
//  Created by Cerko on 16/8/23.
//  Copyright © 2016年 Cerko. All rights reserved.
//

#import "NSFileManager+JCExtension.h"
#import "CompositionConstants.h"


@implementation NSFileManager (JCExtension)

- (BOOL)createDirectoryIfNotExist:(NSString *)directory{
//    BOOL isDirectory;
//    NSLog(@"create Directory:%@", directory);
    
    if (![self fileExistsAtPath:directory isDirectory:NULL]) {
        NSError *error;
        BOOL created = [self createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"directory created error:%@", error);
        }
//        NSLog(@"directory:%@ create ,created:%d", directory, created);

        return created;

    }

    return YES;
}

- (BOOL)createDirectoryIfNotExistAtURL:(NSURL *)url{
    if (![self fileExistsAtURL:url]) {
        __block BOOL created = NO;
        errorHandlerBlock(@"Directory create", ^(NSError * _Nullable __autoreleasing * _Nullable error) {
            created = [self createDirectoryAtURL:url withIntermediateDirectories:YES attributes:nil error:error];
        });
        return created;
        
    }
    
    return YES;
}

- (BOOL)fileExistsAtURL:(NSURL *)url{
    
//    NSString *absolutePath = [url.absoluteString stringByDeletingFromStart:@"file://"];
    return [self fileExistsAtPath:url.absoluteString];
}

- (void)removeFile:(NSString *)file async:(BOOL)async{
    
    dispatch_async(async ? dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) : dispatch_get_main_queue(), ^{
        NSError *error;
        [self removeItemAtPath:file error:&error];
        if (error) {
            
            NSLog(@"删除失败 ,file:%@, error:%@", file, error.localizedDescription);
        }
    });
}

- (void)removeFiles:(NSArray <NSString *> *)files async:(BOOL)async{
    for (NSString *file in files) {
        [self removeFile:file async:async];
    }
}

- (void)removeFileWithURL:(NSURL *)url async:(BOOL)async{
    dispatch_async(async ? dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) : dispatch_get_main_queue(), ^{
        NSError *error;
        [self removeItemAtURL:url error:&error];
        
        if (error) {
            
            NSLog(@"删除失败 ,file:%@, error:%@", url, error.localizedDescription);
        }
    });

}

- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath])
        return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize / (1024.0*1024.0);
}

- (float) fileSizeAtPath:(NSString*) filePath{

    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize] ;
    }
    return 0;
}

- (NSString *)sizeStringFormmaterSize:(Float64)size{
    
    NSString *sizeText;
    if (size >= pow(10, 9)) {
        sizeText = [NSString stringWithFormat:@"%.1fGB", size / pow(10, 9)];
        
    } else if (size >= pow(10, 6)) {
        sizeText = [NSString stringWithFormat:@"%.1fMB", size / pow(10, 6)];
        
    } else if (size >= pow(10, 3)) {
        sizeText = [NSString stringWithFormat:@"%.1fKB", size / pow(10, 3)];
        
    } else {
//        sizeText = [NSString stringWithFormat:@"%zdB", size];
        sizeText = @"0KB";
    }
    return sizeText;

}

@end
