//
//  CompositionConstants.m
//  JCCompositionLib
//
//  Created by Cerko on 16/12/28.
//  Copyright © 2016年 Cerko. All rights reserved.
//

#import "CompositionConstants.h"
#import "YFConstant.h"

int32_t kDefaultTimeScale = NSEC_PER_SEC;
int32_t kDefaultAnimationFrameRate = 15;

NSString *const kXKey = @"x";
NSString *const kYKey = @"y";
NSString *const kWidthKey = @"width";
NSString *const kHeightKey = @"height";
NSString *const kPointKey = @"point";
NSString *const kSizeKey = @"size";

void errorHandlerBlock( NSString * _Nullable errorLogTag, void (^block)(NSError **error)){
    if (block) {
        NSError *error;
        block(&error);
        if (error) {
            YFLog(@"%@ %@", errorLogTag ?: @"", error);
        }
    }
}

NSString *jc_toString(id obj){
    return [NSString stringWithFormat:@"%@", obj ?: @""];
}


NSDictionary <NSString *, NSNumber *> * CGPointToJSONDictionary(CGPoint point){
    return @{kXKey:@(point.x), kYKey:@(point.y)};
}
CGPoint CGPointFromJSONDictionary(NSDictionary <NSString *, NSNumber *> * JSONDictionary){
    
    return CGPointMake([JSONDictionary[kXKey] floatValue], [JSONDictionary[kYKey] floatValue]);
}

#pragma mark - Size
NSDictionary <NSString *, NSNumber *> * CGSizeToJSONDictionary(CGSize size){
    
    return @{kWidthKey:@(size.width),kHeightKey:@(size.height)};
}
CGSize CGSizeFromDictionary(NSDictionary <NSString *, NSNumber *> *JSONDictionary){
    return CGSizeMake([JSONDictionary[kWidthKey] floatValue], [JSONDictionary[kHeightKey] floatValue]);
}

#pragma mark - Rect
NSDictionary <NSString *, NSDictionary <NSString *, NSNumber *> *> * CGRectToJSONDictionary(CGRect rect){
    return @{kPointKey:CGPointToJSONDictionary(rect.origin),kSizeKey:CGSizeToJSONDictionary(rect.size)};
}
CGRect CGRectFromJSONDictionary(NSDictionary <NSString *, NSDictionary <NSString *, NSNumber *> *> *JSONDictionary){
    NSDictionary *pointDic = JSONDictionary[kPointKey];
    NSDictionary *sizeDic = JSONDictionary[kSizeKey];
    return (CGRect){CGPointFromJSONDictionary(pointDic),CGSizeFromDictionary(sizeDic)};
}

NSString *const kStartKey = @"start";
NSString *const kDurationKey = @"duration";



extern NSDictionary <NSString *, NSNumber *> * CMTimeRangeToJSONDictionary(CMTimeRange timeRange){
    return @{kStartKey : @(CMTimeGetSeconds(timeRange.start)) , kDurationKey :@(CMTimeGetSeconds(timeRange.duration))};
}

extern CMTimeRange CMTimeRangeFromJSONDictionary(NSDictionary <NSString *, NSNumber *> * JSONDictionary){
    
    return CMTimeRangeMake(CMTimeMakeWithSecondsUseDefaultScale([JSONDictionary[kStartKey] floatValue]), CMTimeMakeWithSecondsUseDefaultScale([JSONDictionary[kDurationKey] floatValue]));
}

NSString *NSStringFromCMTime(CMTime time){
    CFStringRef startTimeCF = CMTimeCopyDescription(kCFAllocatorDefault, time);
    NSString *startTimeString = (__bridge NSString *)(startTimeCF);
    CFRelease(startTimeCF);
    return startTimeString;
}
NSString *NSStringFromTimeRange(CMTimeRange timeRange){
    CFStringRef timeRangeCF = CMTimeRangeCopyDescription(kCFAllocatorDefault, timeRange);
    
    NSString *timeRangeString = (__bridge NSString *)(timeRangeCF);
    
    CFRelease(timeRangeCF);
    return timeRangeString;
}


NSString *const kM11 = @"m11";
NSString *const kM12 = @"m12";
NSString *const kM13 = @"m13";
NSString *const kM14 = @"m14";

NSString *const kM21 = @"m21";
NSString *const kM22 = @"m22";
NSString *const kM23 = @"m23";
NSString *const kM24 = @"m24";

NSString *const kM31 = @"m31";
NSString *const kM32 = @"m32";
NSString *const kM33 = @"m33";
NSString *const kM34 = @"m34";

NSString *const kM41 = @"m41";
NSString *const kM42 = @"m42";
NSString *const kM43 = @"m43";
NSString *const kM44 = @"m44";



NSDictionary <NSString *, NSNumber *> * CATransform3DToJSONDictionary(CATransform3D transform){
    
    return @{kM11:@(transform.m11),kM12:@(transform.m12), kM13: @(transform.m13), kM14 :@(transform.m14), kM21: @(transform.m21), kM22: @(transform.m22), kM23:@(transform.m23), kM24: @(transform.m24), kM31:@(transform.m31),kM32:@(transform.m32),kM33:@(transform.m33),kM34:@(transform.m34),kM41:@(transform.m41),kM42:@(transform.m42),kM43:@(transform.m43),kM44:@(transform.m44) };
}

CATransform3D CATransform3DFromJSONDictionary(NSDictionary <NSString *, NSNumber *> * JSONDictionary){
    CATransform3D transform = CATransform3DIdentity;
    
    transform.m11 = [JSONDictionary[kM11] floatValue];
    transform.m12 = [JSONDictionary[kM12] floatValue];
    transform.m13 = [JSONDictionary[kM13] floatValue];
    transform.m14 = [JSONDictionary[kM14] floatValue];
    
    transform.m21 = [JSONDictionary[kM21] floatValue];
    transform.m22 = [JSONDictionary[kM22] floatValue];
    transform.m23 = [JSONDictionary[kM23] floatValue];
    transform.m24 = [JSONDictionary[kM24] floatValue];
    
    transform.m31 = [JSONDictionary[kM31] floatValue];
    transform.m32 = [JSONDictionary[kM32] floatValue];
    transform.m33 = [JSONDictionary[kM33] floatValue];
    transform.m34 = [JSONDictionary[kM34] floatValue];
    
    transform.m41 = [JSONDictionary[kM41] floatValue];
    transform.m42 = [JSONDictionary[kM42] floatValue];
    transform.m43 = [JSONDictionary[kM43] floatValue];
    transform.m44 = [JSONDictionary[kM44] floatValue];
    
    
    return transform;
}



NSDictionary <NSString *, NSNumber *> * CGAffineTransformToJSONDictionary(CGAffineTransform transform){
    return CATransform3DToJSONDictionary(CATransform3DMakeAffineTransform(transform));
}

CGAffineTransform CGAffineTransformFromJSONDictionary(NSDictionary <NSString *, NSNumber *> * JSONDictionary){
    
    return CATransform3DGetAffineTransform(CATransform3DFromJSONDictionary(JSONDictionary));
}

NSString *const kR = @"r";
NSString *const kG = @"g";
NSString *const kB = @"b";
NSString *const kA = @"a";

NSDictionary <NSString *, NSNumber *> *UIColorToJSONDictionary(UIColor *color){
    if (!color) {
        color = [UIColor whiteColor];
    }
    CGFloat r = 0;
    CGFloat g = 0;
    CGFloat b = 0;
    CGFloat a = 0;
    
    [color getRed:&r green:&g blue:&b alpha:&a];
    return @{kR:@(r), kG:@(g), kB:@(b),kA:@(a)};
}


UIColor * UIColorFromJSONDictionary(NSDictionary <NSString *, NSNumber *> * JSONDictionary){
    
    return [UIColor colorWithRed:[JSONDictionary[kR] floatValue] green:[JSONDictionary[kG] floatValue] blue:[JSONDictionary[kB] floatValue] alpha:[JSONDictionary[kA] floatValue]];
}






