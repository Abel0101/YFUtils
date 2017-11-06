//
//  UIView+ViewState.h
//  PlaceholderView
//
//  Created by Cerko on 16/12/27.
//  Copyright © 2016年 Cerko. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, JCViewState) {
    JCViewStateNormal,
    JCViewStateLoading,
    JCViewStateEmpty,
    JCViewStateError,
    JCViewStateNoNetConnection     //没网
};

typedef void(^StateViewLayout)(__kindof UIView *theView, JCViewState state, UIView *viewForState);


@interface UIView (ViewState)

//default Normal,设置状态后会显示相应的View
@property (nonatomic, assign) JCViewState currentState;



/**
 
 
 @param view UIView 在该状态的state nil就移除该View
 @param state 该状态
 */
- (void)setview:(nullable __kindof UIView *)view forState:(JCViewState)state;


/**
 获取在该状态的View
 
 @param state 状态
 @return 该状态的View 可能为nil
 */
- (nullable __kindof UIView *)viewForState:(JCViewState)state;


//显示该State状态的View的回调 block中记得用Weak
@property (nonatomic, copy) StateViewLayout showViewForStateBlock;

//隐藏该State状态的View的回调 block中记得用Weak
@property (nonatomic, copy) StateViewLayout hideViewForStateBlock;

#pragma mark - 子类可重写的方法
/**
 显示该状态视图的时候的默认方法,当设置了 showViewForStateBlock 后就不会调用
 
 默认是     if (![view superview]) {
 [self addSubview:view];
 }
 view.hidden = NO;
 
 @param view 要显示的View
 @param state 状态
 */
- (void)onShowView:(__kindof UIView *)view forState:(JCViewState)state;


/**
 隐藏不为State状态的View的默认方法，当设置了hideViewForStateBlock 后就不会调用
 
 默认是view.hidden = YES;
 @param view 要隐藏的View
 @param state 状态
 */
- (void)onHideView:(__kindof UIView *)view forState:(JCViewState)state;

@end

NS_ASSUME_NONNULL_END

