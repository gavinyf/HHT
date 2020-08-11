//
//  CSEmptyRefreshView.m
//  ColorStar
//
//  Created by gavin on 2020/8/11.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSEmptyRefreshView.h"

@interface CSEmptyRefreshView ()

@property (nonatomic, strong)UIImageView  * emptyImageView;

@property (nonatomic, strong)UILabel      * emptyLabel;

@property (nonatomic, strong)UIButton     * emptyBtn;

@end

@implementation CSEmptyRefreshView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
}

@end
