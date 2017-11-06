//
//  TCAutoInjectSubViewView.h
//  GetOn
//
//  Created by Cerko on 15/10/21.
//  Copyright © 2015年 Tonchema. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutoInjectSubViewView : UIView

//此方法默认将view的所有子视图addsubview到自己中，子类可以重写
- (void)setupSubViews;

//设置约束的操作应该在此方法中执行，子类重写
- (void)setupConstraints;
/**
 *  设置默认的文字，图片，字体等，子类重写
 */
- (void)setupDefaultAppreance;

@end
