//
//  HSFileUtils.m
//  HeroShow
//
//  Created by Cerko on 16/8/22.
//  Copyright © 2016年 Cerko. All rights reserved.
//

#import "HSFileUtils.h"
#import "NSFileManager+JCExtension.h"

#define HS_ROOT_DIRECTORY @"Users"
#define HS_USER_HOME_DIRECTORY_FORMART @"%@/Home"

#define HS_LOGIN_USER_DIRECTORY @"LoginUser"
#define HS_LOGIN_USER_INFO_FILE_NAME @"LoginUser.data"

#define HS_CACHE_HOMEPAGE_VIDEO @"VideoCache"

NSString *documentDirectory(){

    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];

    return docDir;
}

NSString *nextAvailableFilePath(NSString *directory , NSString *filePrefix, NSString *extension){
//    int sequence = 0;
    
    do {
        NSString *UUID = [NSUUID UUID].UUIDString;
        NSString *fileName = [NSString stringWithFormat:@"%@_%@",filePrefix,UUID];
        
        fileName = [fileName stringByAppendingPathExtension:extension];
        
        NSString *filePath = [directory stringByAppendingPathComponent:fileName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isExist = [fileManager fileExistsAtPath:filePath];
        
        if (!isExist) {
            return filePath;
        }
//        sequence++;
    } while (1);
    
}

NSString *nextAvailableDirectory(NSString *rootDirectory, NSString *directoryName){
    int sequence = 0;
    do {
        NSString *fileName = [NSString stringWithFormat:@"%@_%d",directoryName,sequence] ;
        
        NSString *filePath = [rootDirectory stringByAppendingPathComponent:fileName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        BOOL isExist = [fileManager fileExistsAtPath:filePath isDirectory:nil];
        
        if (!isExist) {
            return filePath;
        }
        sequence++;
    } while (1);
}


NSString *loginUserDirectory(){
    NSString *directory = [documentDirectory() stringByAppendingPathComponent:HS_LOGIN_USER_DIRECTORY];
    
    //创建
    [[NSFileManager defaultManager] createDirectoryIfNotExist:directory];

    return [documentDirectory() stringByAppendingPathComponent:HS_LOGIN_USER_DIRECTORY];
}

NSString *loginUserInfoFilePath(){
    NSString *directory = [loginUserDirectory() stringByAppendingPathComponent:HS_LOGIN_USER_INFO_FILE_NAME];
    
    return directory;
}

NSString *homePageVideoCacheDirectory(){
    NSString *directory = [documentDirectory() stringByAppendingPathComponent:HS_CACHE_HOMEPAGE_VIDEO];
    
    [[NSFileManager defaultManager] createDirectoryIfNotExist:directory];
    
    return [documentDirectory() stringByAppendingPathComponent:HS_CACHE_HOMEPAGE_VIDEO];
}

NSString *homePageVideoCacheCategoryDirectory(NSString *cacheCategory){
    NSString *directory = [[documentDirectory() stringByAppendingPathComponent:HS_CACHE_HOMEPAGE_VIDEO] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",cacheCategory]];
    [[NSFileManager defaultManager] createDirectoryIfNotExist:directory];
    return directory;
}

NSString *userHomeDirectory(NSString *userID){
    NSString *directory = [[documentDirectory() stringByAppendingPathComponent:HS_ROOT_DIRECTORY] stringByAppendingPathComponent:[NSString stringWithFormat:HS_USER_HOME_DIRECTORY_FORMART,userID]];
    [[NSFileManager defaultManager] createDirectoryIfNotExist:directory];
    return directory;
}

NSString *userDatabaseDirectory(NSString *userID){
    NSString *directory = [userHomeDirectory(userID) stringByAppendingPathComponent:@"Database"];
    [[NSFileManager defaultManager] createDirectoryIfNotExist:directory];
    return directory;

}

NSString *userDatabaseFilePath(NSString *userID){
    return [userDatabaseDirectory(userID) stringByAppendingPathComponent:@"db.sqlite"];
}

NSString *userFilterFilePath(NSString *userID, NSString *fileName){
    return [userFiltersDirectory(userID) stringByAppendingPathComponent:fileName];
}

NSString *userFiltersDirectory(NSString *userID){
    NSString *directory = [userHomeDirectory(userID) stringByAppendingPathComponent:@"Filters"];
    [[NSFileManager defaultManager] createDirectoryIfNotExist:directory];
    return directory;
}

/**
 *  用户的视频根目录
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/Videos
 */
NSString *userVideosDirectory(NSString *userID){
    NSString *directory = [userHomeDirectory(userID) stringByAppendingPathComponent:@"Videos"];
    [[NSFileManager defaultManager] createDirectoryIfNotExist:directory];
    
    return directory;
}

NSString *userArchiveDirectory(NSString *userID){
    NSString *directory = [userHomeDirectory(userID) stringByAppendingPathComponent:@"Archive"];
    [[NSFileManager defaultManager] createDirectoryIfNotExist:directory];
    return directory;
}

NSString *userCompositionDirectory(NSString *userID){
    NSString *directory = [userHomeDirectory(userID) stringByAppendingPathComponent:@"Compositions"];
    [[NSFileManager defaultManager] createDirectoryIfNotExist:directory];
    return directory;
}



NSString *userAlbumDirectory(NSString *userID){
    NSString *directory = [userVideosDirectory(userID) stringByAppendingPathComponent:@"Album"];
    [[NSFileManager defaultManager] createDirectoryIfNotExist:directory];
    return directory;

}

NSString *userStoreVideosDirectory(NSString *userID){
    NSString *directory = [userVideosDirectory(userID) stringByAppendingPathComponent:@"StoreVideos"];
    [[NSFileManager defaultManager] createDirectoryIfNotExist:directory];
    return directory;
}

NSString *nextAvailableAlbumMp4FilePath(NSString *userID){
    return nextAvailableFilePath(userAlbumDirectory(userID), @"Movie", @"mp4");
}


NSString *userVideoFragmentsDirectory(NSString *userID){
    NSString *directory = [userVideosDirectory(userID) stringByAppendingPathComponent:@"VideoFragments"];
    [[NSFileManager defaultManager] createDirectoryIfNotExist:directory];
    return directory;
}

NSString *userVideoFragmentZipFilePath(NSString *userID, NSString *fileName){
    
    return [userVideoFragmentsDirectory(userID) stringByAppendingPathComponent:fileName];
    
}

NSString *userTimecodeZipFilePath(NSString *userID, NSString *fileName){
    
    return [userTimecodesDirectory(userID) stringByAppendingPathComponent:fileName];
    
}
/**
 *  用户的特效根目录
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/Timecodes
 */
NSString *userTimecodesDirectory(NSString *userID){
    NSString *directory = [userHomeDirectory(userID) stringByAppendingPathComponent:@"Timecodes"];
    [[NSFileManager defaultManager] createDirectoryIfNotExist:directory];
    
    return directory;
}


NSString *userStoreVideoZipFilePath(NSString *userID, NSString *fileName){
    
    return [userStoreVideoDirectory(userID) stringByAppendingPathComponent:fileName];
}

NSString *userStoreVideoDirectory(NSString *userID){
    NSString *directory = [userVideosDirectory(userID) stringByAppendingPathComponent:@"StoreVideo"];
    [[NSFileManager defaultManager] createDirectoryIfNotExist:directory];
    return directory;
}



NSString * const kVideoRecordFilePrefix = @"Record";
NSString * const kVideoChromakeyFilePrefix = @"Chromakey";

/**
 *  用户拍摄的视频
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/Videos/RecordRoot
 */
NSString *userVideoRecordRootDirectory(NSString *userID){
    NSString *directory = [userVideosDirectory(userID) stringByAppendingPathComponent:@"RecordRoot"];
    [[NSFileManager defaultManager] createDirectoryIfNotExist:directory];
    return directory;
}

NSString *userVideoRecordsCommonDirectory(NSString *userID){
    NSString *directory = [userVideoRecordRootDirectory(userID) stringByAppendingPathComponent:@"Common"];
    [[NSFileManager defaultManager] createDirectoryIfNotExist:directory];
    return directory;
    
}

NSString *nextAvailableRecordFilePath(NSString *userID){
    return nextAvailableFilePath(userVideoRecordsCommonDirectory(userID), kVideoRecordFilePrefix, @"mov");
}

NSString *userVideoRecordChromakeyDirectory(NSString *userID){
    NSString *directory = [userVideoRecordRootDirectory(userID) stringByAppendingPathComponent:@"ChromaKey"];
    [[NSFileManager defaultManager] createDirectoryIfNotExist:directory];
    return directory;
    
}
NSString *nextAvailableChromakeyFilePath(NSString *userID){
    return nextAvailableFilePath(userVideoRecordChromakeyDirectory(userID), kVideoChromakeyFilePrefix, @"mov");

}


NSString *const kVideoProjectFilePrefix = @"VideoProjct";
/**
 *  用户剪辑的目录
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/Videos/Projects
 */
NSString *userVideoProjectsDirectory(NSString *userID){
    NSString *directory = [userVideosDirectory(userID) stringByAppendingPathComponent:@"Projects"];
    [[NSFileManager defaultManager] createDirectoryIfNotExist:directory];
    return directory;
}

NSString *nextAvailableVideoProjectFilePath(NSString *userID){
//    return nextAvailableFilePath(userVideoProjectsDirectory(userID), kVideoProjectFilePrefix, @"mov");
    return nextAvailableFilePath(userVideoProjectsDirectory(userID), kVideoProjectFilePrefix, @"mp4");
    
}


/**
 *  用户的脚本目录
 *
 *  @param userID 用户ID
 *
 *  @return 用户脚本根目录 /Users/%@/Home/Scripts
 */
NSString *userScriptsDirectory(NSString *userID){
    NSString *directory = [userHomeDirectory(userID) stringByAppendingPathComponent:@"Scripts"];
    [[NSFileManager defaultManager] createDirectoryIfNotExist:directory];
    return directory;
}
/**
 *
 *
 *  @param userID USERID
 *
 *  @return /Users/%@/Home/Audios
 */
NSString *userAudiosDirectory(NSString *userID){
    NSString *directory = [userHomeDirectory(userID) stringByAppendingPathComponent:@"Audios"];
    [[NSFileManager defaultManager] createDirectoryIfNotExist:directory];
    return directory;
}
/**
 *
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/Audios/Sounds
 */
NSString *userSoundsDirectory(NSString *userID){
    NSString *directory = [userAudiosDirectory(userID) stringByAppendingPathComponent:@"Sounds"];
    [[NSFileManager defaultManager] createDirectoryIfNotExist:directory];
    return directory;
}
/**
 *
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/Audios/Voices
 */
NSString *userVoicesDirectory(NSString *userID){
    NSString *directory = [userAudiosDirectory(userID) stringByAppendingPathComponent:@"Voices"];
    [[NSFileManager defaultManager] createDirectoryIfNotExist:directory];
    return directory;
}

NSString *nextAvailableVoiceFilePath(NSString *userID){
    return nextAvailableFilePath(userVoicesDirectory(userID), kVoiceFilePrefix, @"caf");
}



NSString *const kVoiceFilePrefix = @"Voice";
/**
 *
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/Audios/Music
 */
NSString *userMusicDirectory(NSString *userID){
    NSString *directory = [userAudiosDirectory(userID) stringByAppendingPathComponent:@"Music"];
    [[NSFileManager defaultManager] createDirectoryIfNotExist:directory];
    return directory;
}

NSString *const kMusicFilePrefix = @"Music";
NSString *const kSoundFilePrefix = @"Sounds";
/**
 *
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/Downloads
 */
NSString *userDownloadsDirectory(NSString *userID){
    NSString *directory = [userHomeDirectory(userID) stringByAppendingPathComponent:@"Downloads"];
    [[NSFileManager defaultManager] createDirectoryIfNotExist:directory];
    return directory;
}


NSString *userDownloadsMusicDirectory(NSString *userID){
    
    NSString *directory = [userDownloadsDirectory(userID) stringByAppendingPathComponent:kMusicFilePrefix];
    [[NSFileManager defaultManager] createDirectoryIfNotExist:directory];
    
    return directory;
    
}

NSString *userDownloadsSoundDirectory(NSString *userID){
    NSString *directory = [userDownloadsDirectory(userID) stringByAppendingPathComponent:kSoundFilePrefix];
    [[NSFileManager defaultManager] createDirectoryIfNotExist:directory];
    return directory;
}

/**
 *
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/Images
 */
NSString *userImagesDirectory(NSString *userID){
    NSString *directory = [userHomeDirectory(userID) stringByAppendingPathComponent:@"Images"];
    [[NSFileManager defaultManager] createDirectoryIfNotExist:directory];
    return directory;
}

NSString *const kThumbnailFilePrefix = @"Thumbnail";

NSString *userThumbnailsDirectory(NSString *userID){
    NSString *directory = [userImagesDirectory(userID) stringByAppendingPathComponent:@"Thumbnails"];
    
    [[NSFileManager defaultManager] createDirectoryIfNotExist:directory];
    return directory;
}

NSString *nextAvailabelThumbnailPNGFilePath(NSString *userID){
    return nextAvailableFilePath(userThumbnailsDirectory(userID), kThumbnailFilePrefix, @"png");
}
extern NSString *nextAvailabelThumbnailJPGFilePath(NSString *userID){
    return nextAvailableFilePath(userThumbnailsDirectory(userID), kThumbnailFilePrefix, @"jpg");
    
}


NSString *const kGIFDirectoryPrefix = @"GIF";
/**
 *
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/GIFs
 */
NSString *userGIFsDirectory(NSString *userID){
    NSString *directory = [userHomeDirectory(userID) stringByAppendingPathComponent:@"GIFs"];
    [[NSFileManager defaultManager] createDirectoryIfNotExist:directory];
    return directory;
}

NSString *nextAvailabelGIFDirectory(NSString *userID){
    NSString *directory = nextAvailableDirectory(userGIFsDirectory(userID), kGIFDirectoryPrefix);
    [[NSFileManager defaultManager] createDirectoryIfNotExist:directory];
    return directory;
}

/**
 *
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/Animations
 */
NSString *userAnimationsDirectory(NSString *userID){
    NSString *directory = [userHomeDirectory(userID) stringByAppendingPathComponent:@"Animations"];
    [[NSFileManager defaultManager] createDirectoryIfNotExist:directory];
    return directory;
}

/**
 *
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/Documents
 */
NSString *userDocumentsDirectory(NSString *userID){
    NSString *directory = [userHomeDirectory(userID) stringByAppendingPathComponent:@"Documents"];
    [[NSFileManager defaultManager] createDirectoryIfNotExist:directory];
    return directory;
}
/**
 *  用户的字体目录
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/Videos
 */
NSString *userFontsDirectory(NSString *userID){
    NSString *directory = [userHomeDirectory(userID) stringByAppendingPathComponent:@"Fonts"];
    [[NSFileManager defaultManager] createDirectoryIfNotExist:directory];
    
    return directory;
}

NSString *userLargeMusicDirectory(NSString *userID){
    NSString *directory = [userHomeDirectory(userID) stringByAppendingPathComponent:@"LargeMusic"];
    [[NSFileManager defaultManager] createDirectoryIfNotExist:directory];
    
    return directory;
}


@implementation NSString (HSRelativePath)


- (NSString *)hs_relativePathForDocuments{
    NSRange range = [self rangeOfString:@"Documents/"];
    if (range.length == 0) {
        return self;
    }
//    NSString *relative = [self substringFromIndex:NSMaxRange(range)];
//    NSLog(@"relative:%@", relative);
    return [self substringFromIndex:NSMaxRange(range)];

}
- (NSString *)hs_absolutePathForDocuments{
    NSRange range = [self rangeOfString:@"Documents/"];
    if (range.length == 0) {
        return [documentDirectory() stringByAppendingPathComponent:self];
    }
    return self;
}

@end

