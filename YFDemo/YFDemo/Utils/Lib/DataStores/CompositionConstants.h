//
//  CompositionConstants.h
//  JCCompositionLib
//
//  Created by Cerko on 16/12/28.
//  Copyright © 2016年 Cerko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define SELECTOR_STRING(sel) NSStringFromSelector(@selector(sel))
#define SELECTOR_IS_EQUAL_TO_STRING(sel, string) ([SELECTOR_STRING(sel) isEqualToString:string])

#define OBJ_IS_KIND_OF_CLASS(obj, className) [obj isKindOfClass:[className class]]


#define jc_dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define jc_dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}



typedef int8_t JCCompositionTrackType;

enum : JCCompositionTrackType{
    JCCompositionTrackTypeUnKnown = 1,
    JCCompositionTrackTypeImage = 2,
    JCCompositionTrackTypeAudio = 3,
    JCCompositionTrackTypeVideo = 4,
    JCCompositionTrackTypeVideoWithTransition = 5,
    JCCompositionTrackTypeAnimation = 6,
    JCCompositionTrackTypeSubtitle = 7,
    JCCompositionTrackTypeSoundEffect = 8

};


/**
 将秒数转为时间

 @param timeInterval 秒数
 @return 时间
 */
static inline NSString *formatTimeInterval(NSInteger timeInterval){
    
//    NSInteger hours = (timeInterval / 3600);
    NSInteger minutes = (timeInterval / 60) % 60;
    NSInteger seconds = timeInterval % 60;
    
//    NSString *formate = @"%02i:%02i:%02i";
//    NSString *recordTime = [NSString stringWithFormat:formate,hours,minutes,seconds];
    NSString *formate = @"%02i:%02i";
    NSString *recordTime = [NSString stringWithFormat:formate,minutes,seconds];

    return recordTime;
}

static inline NSString *formatTime(CMTime time){
    return formatTimeInterval(CMTimeGetSeconds(time));
}


/**
 错误处理C函数

 @param errorLogTag TAG,如果发生Error，会在打印Error之前输出
 @param ^block 将需要错误输出的代码放到此block中
 */
extern void errorHandlerBlock( NSString * _Nullable errorLogTag, void (^block)(NSError **error));




typedef void(^JCBooleanBlock)(BOOL b, NSError *_Nullable error);
typedef void(^JCObjectBlock)(id _Nullable obj, NSError *_Nullable error);
typedef void(^JCDictionaryBlock)(NSDictionary  * _Nullable dictionary, NSError *_Nullable error);
typedef void(^JCArrayBlock)(NSArray  * _Nullable array, NSError *_Nullable error);
typedef void(^JCProgressBlock)(float progress);
typedef void(^HSDownTaskBlock) (NSURLSessionDownloadTask *task);

/**
  默认的TimeScale 25，不会造成两个视频之间会有黑色间隙的情况
 */
extern int32_t kDefaultTimeScale;

/**
 默认动画帧率 15
 */
extern int32_t kDefaultAnimationFrameRate;


/**
 转字符串

 @param obj 所有obj
 @return 字符串
 */
NSString *jc_toString(id obj);

/**
 将timeScale转成25，保证不会造成黑色间隙

 @param time 要转换的时间
 @return 转换后的时间
 */
static inline CMTime CMTimeConvertScaleToDefault(CMTime time){
    return CMTimeConvertScale(time, kDefaultTimeScale, kCMTimeRoundingMethod_QuickTime);
}


/**
 生成时间，用默认的timeScale,如果传入-1则生成kCMTimeInvalid

 @param seconds 秒数
 @return CMTime
 */
static inline CMTime CMTimeMakeWithSecondsUseDefaultScale(Float64 seconds){
    return (-1 == seconds) ? kCMTimeInvalid : CMTimeMakeWithSeconds(seconds, kDefaultTimeScale);
}


/**
 获取秒数

 @param time 时间，CMTime
 @return 秒数
 */
static inline Float64 CMTimeGetSecondsForJSONObject(CMTime time){
    return CMTIME_IS_VALID(time) ? CMTimeGetSeconds(time) : -1;
}


/**
 生成TimeRange，如果duration无效的话，则换成kCMTimeZero

 @param duration 时间
 @return CMTimeRange
 */
static inline CMTimeRange CMTimeRangeMakeWithConvertScaleDuration(CMTime duration){
    
    return CMTimeRangeMake(kCMTimeZero, CMTimeConvertScaleToDefault(CMTIME_IS_VALID(duration) ? duration : kCMTimeZero ));
}



/**
 时间转距离

 @param time 时间
 @param scale 时间和距离的比例
 @return 算出距离
 */
static inline CGFloat jc_timeToDimension(CMTime time, CGFloat scale){
    return CMTimeGetSeconds(time) * scale;
}


/**
 距离转时间

 @param dimension 距离
 @param scale 时间和距离的比例
 @return 时间
 */
static inline CMTime jc_dimensionToTime(CGFloat dimension, CGFloat scale){
    return CMTimeMakeWithSecondsUseDefaultScale(dimension / scale);
}


/**
 将高度按一定的宽高比，计算出宽度

 @param targetHeight 最后的高度
 @param ratio 宽高比
 @return 最后的宽度
 */
static inline CGFloat jc_aspectWidthWithHeightAndAspectRatio(CGFloat targetHeight, CGSize ratio){
    return targetHeight * ratio.width / ratio.height;
}

static inline CGSize jc_aspectSizeWithHeightAndAspectRatio(CGFloat targetHeight, CGSize ratio){
    return CGSizeMake(jc_aspectWidthWithHeightAndAspectRatio(targetHeight, ratio), targetHeight);
}

/**
 将宽度按一定的宽高比，计算出高度

 @param targetWidth 最后的宽度
 @param ratio 宽高比
 @return 最后的高度
 */
static inline CGFloat jc_aspectHeightWithWidthAndAspectRatio(CGFloat targetWidth, CGSize ratio){
    return targetWidth * ratio.height / ratio.width;
}

static inline CGSize jc_aspectSizeWithWidthAndAspectRatio(CGFloat targetWidth, CGSize ratio){
    return CGSizeMake(targetWidth, jc_aspectHeightWithWidthAndAspectRatio(targetWidth, ratio));
}

extern NSString *const kXKey;
extern NSString *const kYKey;
extern NSString *const kWidthKey;
extern NSString *const kHeightKey;
extern NSString *const kPointKey;
extern NSString *const kSizeKey;



#pragma mark

/**
 将point结构体转成所需要的字典
 

 @param point CGPoint
 @return {
            "x": NSNumber(float),
            "y": NSNumber(float)
         }
 */
extern NSDictionary <NSString *, NSNumber *> * CGPointToJSONDictionary(CGPoint point);
extern CGPoint CGPointFromJSONDictionary(NSDictionary <NSString *, NSNumber *> * JSONDictionary);

#pragma mark - Size

/**
 将size结构体转成所需的字典

 @param size CGSize
 @return 
            {
                "width": NSNumber(float),
                "height": NSNumber(float)
            }
 */
extern NSDictionary <NSString *, NSNumber *> * CGSizeToJSONDictionary(CGSize size);
extern CGSize CGSizeFromDictionary(NSDictionary <NSString *, NSNumber *> *JSONDictionary);

#pragma mark - Rect

/**
 将rect结构体转成字典

 @param rect CGRect
 @return 
        {
            "point" : {"x":NSNumber(float), "y":NSNumber(float)}
            "size"  : {"width": NSNumber(float), "height":NSNumber(float)}
        }
 */
extern NSDictionary <NSString *, NSDictionary <NSString *, NSNumber *> *> * CGRectToJSONDictionary(CGRect rect);
extern CGRect CGRectFromJSONDictionary(NSDictionary <NSString *, NSDictionary <NSString *, NSNumber *> *> *JSONDictionary);


extern NSString *const kStartKey;
extern NSString *const kDurationKey;

#pragma mark - CMTimeRange

/**
 将TimeRange转成字典

 @param timeRange CMTimeRange
 @return   
            {
                "start":NSNumber(float),
                "duration":NSNumber(float)
            }
 */
extern NSDictionary <NSString *, NSNumber *> * CMTimeRangeToJSONDictionary(CMTimeRange timeRange);
extern CMTimeRange CMTimeRangeFromJSONDictionary(NSDictionary <NSString *, NSNumber *> * JSONDictionary);


/**
 将Time转换成文本

 @param time CMTime
 @return 文本
 */
extern NSString *NSStringFromCMTime(CMTime time);

/**
 将TimeRange转场成文本

 @param timeRange timerange
 @return 文本
 */
extern NSString *NSStringFromTimeRange(CMTimeRange timeRange);


#pragma mark - CATransfrom3D

/**
 将CATransform3D转成字典

 @param transform CATransform3D
 @return {
 
            "m11": NSNumber(float),
            "m12": NSNumber(float),
            "m13": NSNumber(float),
            "m14": NSNumber(float),

            "m11": NSNumber(float),
            "m22": NSNumber(float),
            "m23": NSNumber(float),
            "m24": NSNumber(float),

            "m31": NSNumber(float),
            "m32": NSNumber(float),
            "m33": NSNumber(float),
            "m34": NSNumber(float)

            "m41": NSNumber(float),
            "m42": NSNumber(float),
            "m43": NSNumber(float),
            "m44": NSNumber(float)

 
        }
 */
extern NSDictionary <NSString *, NSNumber *> * CATransform3DToJSONDictionary(CATransform3D transform);

extern CATransform3D CATransform3DFromJSONDictionary(NSDictionary <NSString *, NSNumber *> * JSONDictionary);


/**
 先转成CATransform3D 再调用  CATransform3DToJSONDictionary

 @param transform affineTransform
 @return 字典
 */
extern NSDictionary <NSString *, NSNumber *> * CGAffineTransformToJSONDictionary(CGAffineTransform transform);

/**
 先调用 CATransform3DFromJSONDictionary转成 CATransform3D ，再转成 CGAffineTransform

 @param JSONDictionary 要转换的字典
 @return CGAffineTransform
 */
extern CGAffineTransform CGAffineTransformFromJSONDictionary(NSDictionary <NSString *, NSNumber *> * JSONDictionary);



//"textColor": {"r": NSNumber(float) ,"g": NSNumber(float),"b": NSNumber(float),"a": NSNumber(float)}
extern NSDictionary <NSString *, NSNumber *> *UIColorToJSONDictionary(UIColor *color);

extern UIColor * UIColorFromJSONDictionary(NSDictionary <NSString *, NSNumber *> * JSONDictionary);

NS_ASSUME_NONNULL_END
