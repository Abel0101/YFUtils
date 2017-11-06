//
//  UIView+ViewState.m
//  PlaceholderView
//
//  Created by Cerko on 16/12/27.
//  Copyright © 2016年 Cerko. All rights reserved.
//

#import "UIView+ViewState.h"
#import <objc/runtime.h>

@implementation UIView (ViewState)

#pragma mark - properties
- (void)setCurrentState:(JCViewState)currentState{
    NSNumber *_currentState = objc_getAssociatedObject(self, _cmd);
    if (_currentState) {
        if ([_currentState isEqualToNumber:@(currentState)]) {
            return;
        }
    }
    
    objc_setAssociatedObject(self, @selector(currentState), @(currentState), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    //根据当前状态显示相应的View
    [self showViewForState:currentState];
}

- (UIView *)viewForState:(JCViewState)state{
    return self.viewsForState[@(state)];
}


- (JCViewState)currentState{
    return [objc_getAssociatedObject(self, _cmd) unsignedIntegerValue];
}

- (void)setShowViewForStateBlock:(StateViewLayout)showViewForStateBlock{
    objc_setAssociatedObject(self, @selector(showViewForStateBlock), showViewForStateBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    //根据当前状态显示相应的View
    [self showViewForState:self.currentState];
    
}

- (StateViewLayout)showViewForStateBlock{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHideViewForStateBlock:(StateViewLayout)hideViewForStateBlock{
    objc_setAssociatedObject(self, @selector(hideViewForStateBlock), hideViewForStateBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    //根据当前状态显示相应的View
    [self showViewForState:self.currentState];
    
}

- (StateViewLayout)hideViewForStateBlock{
    return objc_getAssociatedObject(self, _cmd);
}


- (NSMutableDictionary <__kindof NSValue *, UIView *> *)viewsForState{
    NSMutableDictionary <__kindof NSValue *, UIView *> *viewsForState = objc_getAssociatedObject(self, _cmd);
    if (!viewsForState) {
        viewsForState = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, _cmd, viewsForState, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return viewsForState;
}




- (void)setview:(__kindof UIView *)view forState:(JCViewState)state{
    
    UIView *_view = [self viewForState:state];
    
    if (_view) {
        
        if (![_view isEqual:view]) {
            [_view removeFromSuperview];
        }
        
    }
    
    [self viewsForState][@(state)] = view;
    
    //根据当前状态显示相应的View
    [self showViewForState:self.currentState];
}


- (void)showViewForState:(JCViewState)state{
    
    NSDictionary <NSNumber *, UIView *> *viewsForState = [self viewsForState];
    
    [viewsForState enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, UIView * _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ([key isEqualToNumber:@(state)]) {
            
            if (self.showViewForStateBlock) {
                self.showViewForStateBlock(self, state, obj);
            }else{
                
                [self onShowView:obj forState:state];
            }
            
        }else{
            
            if (self.hideViewForStateBlock) {
                self.hideViewForStateBlock(self, state, obj);
            }else{
                [self onHideView:obj forState:state];
                
            }
        }
        
    }];
    
}


- (void)onShowView:(UIView *)view forState:(JCViewState)state{
    if (![view superview]) {
        [self addSubview:view];
    }
    view.hidden = NO;
    
}

- (void)onHideView:(UIView *)view forState:(JCViewState)state{
    view.hidden = YES;
}



@end



