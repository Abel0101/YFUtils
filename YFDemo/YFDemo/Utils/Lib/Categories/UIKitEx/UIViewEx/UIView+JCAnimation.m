//
//  UIView+JCAnimation.m
//  HeroShow
//
//  Created by Cerko on 16/7/8.
//  Copyright © 2016年 Cerko. All rights reserved.
//

#import "UIView+JCAnimation.h"

@implementation UIView (JCAnimation)

- (void)jc_doAnimatePreparation:(void (^ __nullable)())preparation
                  animations:(void (^)())animations
                  completion:(void (^ __nullable)(BOOL finished))completion
                    animated:(BOOL)animated
                    duration:(NSTimeInterval)duration
{
    if (preparation) {
        preparation();
    }
    
    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:animated ? duration : 0
                     animations:animations
                     completion:^(BOOL finished) {
                         if (completion) {
                             completion(finished);
                         }
                         
                         self.userInteractionEnabled = YES;
                     }];
}

- (void)jc_doAnimatePreparation:(void (^ __nullable)())preparation
                     animations:(void (^)())animations
                     completion:(void (^ __nullable)(BOOL finished))completion{
    [self jc_doAnimatePreparation:preparation animations:animations completion:completion animated:YES duration:0.25];
}

- (void)jc_doAnimations:(void (^)())animations
             completion:(void (^ __nullable)(BOOL finished))completion{
    [self jc_doAnimatePreparation:NULL animations:animations completion:completion];
}



- (void)jc_showViewUseAlphaAnimation:(UIView *)view{
    [self jc_doAnimatePreparation:^{
        view.alpha = 0;
        view.hidden = NO;
        
    } animations:^{
        view.alpha = 1;
    } completion:NULL];

}
- (void)jc_hideViewUseAlphaAnimation:(UIView *)view{
    
    if (view.isHidden) {
        return;
    }
    
    [self jc_doAnimations:^{
        view.alpha = 0;
    } completion:^(BOOL finished) {
        view.hidden = YES;
    }];

}



@end
