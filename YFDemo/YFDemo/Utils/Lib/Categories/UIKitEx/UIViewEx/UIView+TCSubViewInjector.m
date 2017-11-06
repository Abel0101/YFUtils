//
//  UIView+TCSubViewInjector.m
//  GetOn
//
//  Created by Cerko on 15/10/18.
//  Copyright © 2015年 Tonchema. All rights reserved.
//

#import "UIView+TCSubViewInjector.h"

#import <objc/runtime.h>
#import <objc/message.h>
#import "NSObject+Injector.h"

@implementation UIView (TCSubViewInjector)


- (void)injectSubViews{
    [self injectKindOfClass:[UIView class] terminalClass:[UIView class] withCallBack:^(__kindof id selfInstance, __kindof id objInject) {
        [selfInstance addSubview:objInject];
    }];
    
}
@end
