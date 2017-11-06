//
//  JCValidator.m
//  QuickMovie
//
//  Created by Cerko on 16/9/25.
//  Copyright © 2016年 Cerko. All rights reserved.
//

#import "JCValidator.h"

@implementation JCValidator

- (instancetype)initWithInput:(id)input{
    if (self = [super init]) {
        self.input = input;
    }
    return self;
}

- (NSError *)validateInput:(NSString *)input{
    return nil;
}
- (NSError *)isValid{
    return [self validateInput:self.input];
}


@end

@implementation JCValidatorGroup

- (instancetype)initWithValidators:(NSArray <id <JCValidator>> *)validators{
    if (self = [super init]) {
        _validators = validators;
    }
    return self;
}

- (NSError *)validateInput:(id)input{
    for (id <JCValidator> validator in self.validators) {
        NSError *error = [validator validateInput:input];
        if (error) {
            return error;
        }
    }
    
    return nil;
}

- (NSError *)isValid{
    for (id <JCValidator> validator in self.validators) {
        NSError *error = [validator isValid];
        if (error) {
            return error;
        }
    }
    
    return nil;
}


@end


#define JCErrorDomain @"com.cerko.error.domain"
//@implementation NSError (JCEmptyError)
//
//+ (instancetype)errorWithEmptyCode:(JCEmptyErrorCode)code{
//    NSDictionary *userInfo = [self errorUserInfoWithDataValidateCode:code];
//    return [self dataValidateErrorWithErrorCode:code userInfo:userInfo];
//
//}
//
//
//+ (instancetype)errorWithEmptyCode:(JCEmptyErrorCode)code userInfo:(nullable NSDictionary *)userInfo{
//    return [self errorWithDomain:JCErrorDomain code:code userInfo:userInfo];
//    
//}
//
//+ (instancetype)errorWithDataValidateErrorCode:(HSDataValidateErrorCode)code{
//    NSDictionary *userInfo = [self errorUserInfoWithDataValidateCode:code];
//    return [self dataValidateErrorWithErrorCode:code userInfo:userInfo];
//}
//
//+ (NSDictionary *)errorUserInfoWithDataValidateCode:(JCEmptyErrorCode)code{
//    
//    NSString *errorDes = @"";
//    switch (code) {
//        case JCEmptyErrorCodeNil:
//            errorDes = NSLocalizedString(@"Phone number not valid", @"手机号格式不正确");
//            break;
//        case HSDataValidateErrorCodeInviteCodeFormatError:
//            errorDes = NSLocalizedString(@"Invite code format not valid", @"邀请码格式不正确");
//            
//            break;
//        case HSDataValidateErrorCodeCaptchaEmptyError:
//            errorDes = NSLocalizedString(@"Captcha can not be empty", @"验证码不能为空");
//            break;
//        case HSDataValidateErrorCodePasswordFormatError:
//            errorDes = NSLocalizedString(@"The length of password must >= 6", @"密码必须大于6位");
//            break;
//            
//        case HSDataValidateErrorCodeNickNameFormatError:
//            errorDes = NSLocalizedString(@"The length of nickname must >0 and <=14", @"昵称长度必须大于0 小于等于14");
//            break;
//        case HSDataValidateErrorCodeRatingTooLowError:
//            errorDes = NSLocalizedString(@"Must select at least one star", @"最少选择一颗星");
//            
//            break;
//            
//        default:
//            break;
//    }
//    
//    
//    return @{NSLocalizedDescriptionKey:errorDes};
//    
//}
//
//
//+ (NSDictionary *)errorUserInfoWithDataValidateCode:(HSDataValidateErrorCode)code{
//    
//    NSString *errorDes = @"";
//    switch (code) {
//        case HSDataValidateErrorCodePhoneNumberFormatError:
//            errorDes = NSLocalizedString(@"Phone number not valid", @"手机号格式不正确");
//            break;
//        case HSDataValidateErrorCodeInviteCodeFormatError:
//            errorDes = NSLocalizedString(@"Invite code format not valid", @"邀请码格式不正确");
//            
//            break;
//        case HSDataValidateErrorCodeCaptchaEmptyError:
//            errorDes = NSLocalizedString(@"Captcha can not be empty", @"验证码不能为空");
//            break;
//        case HSDataValidateErrorCodePasswordFormatError:
//            errorDes = NSLocalizedString(@"The length of password must >= 6", @"密码必须大于6位");
//            break;
//            
//        case HSDataValidateErrorCodeNickNameFormatError:
//            errorDes = NSLocalizedString(@"The length of nickname must >0 and <=14", @"昵称长度必须大于0 小于等于14");
//            break;
//        case HSDataValidateErrorCodeRatingTooLowError:
//            errorDes = NSLocalizedString(@"Must select at least one star", @"最少选择一颗星");
//            
//            break;
//            
//        default:
//            break;
//    }
//    
//    
//    return @{NSLocalizedDescriptionKey:errorDes};
//    
//}
//
//@end



@implementation JCEmptyValidator



- (NSError *)validateInput:(id)input{
    
    if (!input) {
        return [NSError errorWithDomain:JCErrorDomain code:JCEmptyErrorCodeNil userInfo:@{}];
    }
    
    if ([input respondsToSelector:@selector(length)]) {
        if (![input length]) {
            return [NSError errorWithDomain:JCErrorDomain code:JCEmptyErrorCodeLength userInfo:@{}];
        }
    }
    
    if ([input respondsToSelector:@selector(count)]) {
        if (![input count]) {
            return [NSError errorWithDomain:JCErrorDomain code:JCEmptyErrorCodeCount userInfo:@{}];
        }
    }
    
    return nil;
}


@end






