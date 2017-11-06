//
//  TCAutoInjectSubViewView.m
//  GetOn
//
//  Created by Cerko on 15/10/21.
//  Copyright © 2015年 Tonchema. All rights reserved.
//

#import "AutoInjectSubViewView.h"
#import "UIView+TCSubViewInjector.h"


@implementation AutoInjectSubViewView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}
- (void)setup{
    [self setupSubViews];
    [self setupConstraints];
    [self setupDefaultAppreance];
}

- (void)setupSubViews{
    [self injectSubViews];
}

- (void)setupConstraints{

    
}
- (void)setupDefaultAppreance{

}




@end
