//
//  CSHomeSpecialCell.m
//  ColorStar
//
//  Created by gavin on 2020/8/4.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSHomeBigCell.h"
#import <Masonry.h>


@interface CSHomeBigCell ()


@end

@implementation CSHomeBigCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
        [self setupConstraint];
    }
    return self;
}

- (void)setupViews{
    [super setupViews];
    self.studyLabel.hidden = YES;
}

- (void)setupConstraint{
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    [self.thumbnailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.containerView);
        make.left.mas_equalTo(self.containerView).offset(14);
        make.right.mas_equalTo(self.containerView).offset(-14);
        make.height.mas_equalTo(self.thumbnailImageView.mas_width).multipliedBy(215.0/347.0);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.thumbnailImageView).offset(10);
        make.top.mas_equalTo(self.thumbnailImageView.mas_bottom).offset(10);
    }];
    
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(6);
    }];
    
    [self.courceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.thumbnailImageView.mas_right).offset(-6);
        make.bottom.mas_equalTo(self.authorLabel);
    }];
    
    [self.separtLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.courceLabel);
        make.right.mas_equalTo(self.courceLabel.mas_left).offset(-6);
        make.width.mas_equalTo(1);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.separtLine.mas_left).offset(-6);
        make.centerY.mas_equalTo(self.separtLine);
    }];
    
    [self.studyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.courceLabel);
        make.right.mas_equalTo(self.containerView).offset(-10);
    }];
}


@end
