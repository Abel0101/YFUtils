//
//  UIView+JCSnapShot.h
//  CollectionLayoutTest
//
//  Created by Cerko on 16/7/29.
//  Copyright © 2016年 Cerko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JCSnapShot)

/**
 * Returns the UIImage representation of this view.
 */
- (UIImage *)snapShot;

/**
 * Returns a UIImageView representation of this view.  The image view's initial frame
 * is set to the frame as the view.
 */
- (UIImageView *)snapShotImageView;


@end
