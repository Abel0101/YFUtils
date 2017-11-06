//
//  JCValidator.h
//  QuickMovie
//
//  Created by Cerko on 16/9/25.
//  Copyright © 2016年 Cerko. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

/**
 *  校验器
 */
@protocol JCValidator <NSObject>
/**
 *  校验数据的正确性
 *
 *  @param input 输入
 *
 *  @return 如果无效则 NSError不为空
 */
- (nullable NSError *)validateInput:(id)input;

/**
 *  校验数据的正确性
 *
 *  @return 如果无效，则返回ERROR
 */
- (nullable NSError *)isValid;

@end

@interface JCValidator : NSObject <JCValidator>

@property (nonatomic, strong) id input;

- (instancetype)initWithInput:(id)input;

@end

@interface JCValidatorGroup : JCValidator

@property (nonatomic, strong) NSArray <id <JCValidator>> *validators;

- (instancetype)initWithValidators:(NSArray <id <JCValidator>> *)validators;

@end


/**
 *  空值的类型
 */
typedef NS_ENUM(NSInteger, JCEmptyErrorCode) {
    /**
     *  Nil
     */
    JCEmptyErrorCodeNil = -1,
    /**
     *  长度为0 NSString
     */
    JCEmptyErrorCodeLength = -2,
    /**
     *  数量为0 NSArray 等
     */
    JCEmptyErrorCodeCount = -3
};

//@interface NSError (JCEmptyError)
//
//+ (instancetype)errorWithEmptyCode:(JCEmptyErrorCode)code;
//
//@end

/**
 *  空值检测
 */
@interface JCEmptyValidator : JCValidator

@end




NS_ASSUME_NONNULL_END
