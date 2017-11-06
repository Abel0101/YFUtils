//
//  HSFileUtils.h
//  HeroShow
//
//  Created by Cerko on 16/8/22.
//  Copyright © 2016年 Cerko. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *documentDirectory();

/**
 *  生成一个可用的文件路径 /directory/filePrefix_%d.extension
 *
 *  @param directory  目录
 *  @param filePrefix 文件的前缀名
 *  @param extension  文件后缀名
 *
 *  @return 文件路径
 */
extern NSString *nextAvailableFilePath(NSString *directory , NSString *filePrefix, NSString *extension);

/**
 *  生成一个可用的目录 /rootDirectory/directoryName_%d
 *
 *  @param rootDirectory 该目录的根目录
 *  @param directoryName 目录名
 *
 *  @return 目录
 */
extern NSString *nextAvailableDirectory(NSString *rootDirectory, NSString *directoryName);



/**
 *  登录用户信息目录
 *
 *  @return 放置登录用户的信息
 */
extern NSString *loginUserDirectory();
/**
 *  登录用户信息文件路径
 *
 *  @return 文件路径
 */
extern NSString *loginUserInfoFilePath();

/**
 * 首页视频缓存文件路径
 *
 * @return 文件路径
 */
extern NSString *homePageVideoCacheDirectory();

/**
 首页视频缓存文件路径(含子文件夹)

 @param cacheCategory 文件夹
 @return 路径
 */
extern NSString *homePageVideoCacheCategoryDirectory(NSString *cacheCategory);

/**
 *  用户的根目录
 *
 *  @param userID userID
 *
 *  @return /Users/%@/Home
 */
extern NSString *userHomeDirectory(NSString *userID);

/**
 *  用户的数据库目录
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/Database
 */
extern NSString *userDatabaseDirectory(NSString *userID);
/**
 *
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/Database/db.sqlite
 */
extern NSString *userDatabaseFilePath(NSString *userID);


/**
 滤镜文件路径

 @param userID
 @return /Users/%@/Home/Database/
 */
extern NSString *userFilterFilePath(NSString *userID, NSString *fileName);
/**
 用户滤镜根目录

 @param userID
 @return /Users/%@/Home/Filter
 */
extern NSString *userFiltersDirectory(NSString *userID);

/**
 *  用户的视频根目录
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/Videos
 */
extern NSString *userVideosDirectory(NSString *userID);

extern NSString *userFontsDirectory(NSString *userID);

extern NSString *userLargeMusicDirectory(NSString *userID);
/**
 用户的作品模板目录

 @param userID 用户ID
 @return /Users/%@/Home/Compositions
 */
extern NSString *userCompositionDirectory(NSString *userID);


/**
 *  用户下载的片段目录
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/Videos/VideoFragments
 */
extern NSString *userVideoFragmentsDirectory(NSString *userID);


/**
 *  片段位置Zip包位置
 *
 *  @param userID
 *  @param fileName
 *
 *  @return /Users/%@/Home/Videos/VideoFragments/57e61e28da2f600060c89da4
 */
extern NSString *userVideoFragmentZipFilePath(NSString *userID, NSString *fileName);


#pragma mark 特效文件路径
/**
 特效文件地址Zip包位置

 @param userID
 @param fileName
 @return /Users/%@/Home/Timecodes/~
 */
extern NSString *userTimecodeZipFilePath(NSString *userID, NSString *fileName);

/**
 *  用户的特效根目录
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/Timecodes
 */
extern NSString *userTimecodesDirectory(NSString *userID);

#pragma mark 商店视频文件路径

/**
 商店视频Zip包地址

 @param userID
 @param fileName
 @return /Users/%@/Home/Videos/StoreVideo/~
 */
extern NSString *userStoreVideoZipFilePath(NSString *userID, NSString *fileName);


/**
 商店视频文件目录

 @param userID
 @return /Users/%@/Home/Videos/StoreVideo/
 */
extern NSString *userStoreVideoDirectory(NSString *userID);


/**
 *  录制文件的前缀,Record
 */
extern NSString *const kVideoRecordFilePrefix;


/**
 *  从相册拷贝出来的视频的根目录
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/Videos/Album
 */
extern NSString *userAlbumDirectory(NSString *userID);

/**
 视频商店下载的视频根目录

 @param userID
 @return /User/%@/Home/Videos/StoreVideos
 */
extern NSString *userStoreVideosDirectory(NSString *userID);


/**
 *  从相册拷贝出来的视频的路径
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/Videos/Album/Movie_%d.mp4
 */
extern NSString *nextAvailableAlbumMp4FilePath(NSString *userID);

/**
 *  用户拍摄的视频的根目录
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/Videos/RecordRoot
 */
extern NSString *userVideoRecordRootDirectory(NSString *userID);

/**
 *  用户拍摄的普通视频目录
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/Videos/RecordRoot/Records
 */
extern NSString *userVideoRecordsCommonDirectory(NSString *userID);

/**
 *  /Users/%@/Home/Videos/RecordRoot/Records/Record_%d.mov
 *
 *  @param userID
 *
 *  @return
 */
extern NSString *nextAvailableRecordFilePath(NSString *userID);


/**
 *  ChromaKey
 */
extern NSString * const kVideoChromakeyFilePrefix;

/**
 *
 *  抠绿相机拍摄的视频目录
 *  @param userId
 *
 *  @return /Users/%@/Home/Videos/RecordRoot/ChromaKey
 */
extern NSString *userVideoRecordChromakeyDirectory(NSString *userID);

/**
 *  /Users/%@/Home/Videos/RecordRoot/ChromaKey/ChromaKey_%d.mov
 *
 *  @param userID
 *
 *  @return
 */
extern NSString *nextAvailableChromakeyFilePath(NSString *userID);


/**
 *  视频项目前缀 VideoProject
 */
extern NSString *const kVideoProjectFilePrefix;
/**
 *  用户剪辑的目录
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/Videos/Projects
 */
extern NSString *userVideoProjectsDirectory(NSString *userID);

/**
 *  
 *  /Users/%@/Home/Videos/Projects/VideoProject_%d.mp4
 *
 *  @param userID
 *
 *  @return
 */
extern NSString *nextAvailableVideoProjectFilePath(NSString *userID);


/**
 *  用户的脚本目录
 *
 *  @param userID 用户ID
 *
 *  @return 用户脚本根目录 /Users/%@/Home/Scripts
 */
extern NSString *userScriptsDirectory(NSString *userID);

/**
 *
 *
 *  @param userID USERID
 *
 *  @return /Users/%@/Home/Audios
 */
extern NSString *userAudiosDirectory(NSString *userID);

/**
 *
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/Audios/Sounds
 */
extern NSString *userSoundsDirectory(NSString *userID);

/**
 *
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/Audios/Voices
 */
extern NSString *userVoicesDirectory(NSString *userID);

/**
 *  声音文件
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/Audios/Voices/Voice_%d.caf
 */
extern NSString *nextAvailableVoiceFilePath(NSString *userID);

/**
 *  Voice
 */
extern NSString *const kVoiceFilePrefix;

/**
 *
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/Audios/Music
 */
extern NSString *userMusicDirectory(NSString *userID);



/**
 *  音乐的前缀Music_%d
 */
extern NSString *const kMusicFilePrefix;
/**
 *
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/Downloads
 */
extern NSString *userDownloadsDirectory(NSString *userID);


/**
 *
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/Downloads/Musics
 */
extern NSString *userDownloadsMusicDirectory(NSString *userID);

/**
 *
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/Downloads/Sounds
 */
extern NSString *userDownloadsSoundDirectory(NSString *userID);

/**
 *
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/Images
 */
extern NSString *userImagesDirectory(NSString *userID);

/**
 *  缩略图前缀 Thumbnail
 */
extern NSString *const kThumbnailFilePrefix;



/**
 *  缩略图
 *
 *  @param userID userID
 *
 *  @return /Users/%@/Home/Images/Thumbnails
 */
extern NSString *userThumbnailsDirectory(NSString *userID);

/**
 *  下一个可用的thumbnail的路径
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/Images/Thumbnails/Thumbnail_%d.png
 */
extern NSString *nextAvailabelThumbnailPNGFilePath(NSString *userID);

extern NSString *nextAvailabelThumbnailJPGFilePath(NSString *userID);

/**
 *  GIF
 */
extern NSString *const kGIFDirectoryPrefix;
/**
 *
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/GIFs
 */
extern NSString *userGIFsDirectory(NSString *userID);

/**
 *  GIF文件夹目录
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/GIFs/GIF_%d
 */
extern NSString *nextAvailabelGIFDirectory(NSString *userID);

/**
 *
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/Animations
 */
extern NSString *userAnimationsDirectory(NSString *userID);

/**
 用户目录下的归档文件

 @param userID userid
 @return /Users/%@/Home/Archive
 */
extern NSString *userArchiveDirectory(NSString *userID);
/**
 *
 *
 *  @param userID
 *
 *  @return /Users/%@/Home/Documents
 */
extern NSString *userDocumentsDirectory(NSString *userID);

@interface NSString (HSRelativePath)


- (NSString *)hs_relativePathForDocuments;
- (NSString *)hs_absolutePathForDocuments;

@end




