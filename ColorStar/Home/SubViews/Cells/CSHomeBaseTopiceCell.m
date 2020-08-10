//
//  CSHomeBaseTopiceCell.m
//  ColorStar
//
//  Created by gavin on 2020/8/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSHomeBaseTopiceCell.h"
#import <Masonry.h>
#import "UIColor+CS.h"
#import "NSString+CS.h"
#import <SDWebImage/UIImageView+WebCache.h>



@implementation CSHomeBaseTopiceCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setupViews{
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.thumbnailImageView];
    [self.thumbnailImageView addSubview:self.typeLabel];
    [self.containerView addSubview:self.titleLabel];
    [self.containerView addSubview:self.authorLabel];
    [self.containerView addSubview:self.priceLabel];
    [self.containerView addSubview:self.separtLine];
    [self.containerView addSubview:self.courceLabel];
    [self.containerView addSubview:self.studyLabel];
    
}

- (void)setupConstraint{
    
    
}

- (void)configurModel:(CSHomeTopicBaseModel*)model{
    self.baseModel = model;
    if (![NSString isNilOrEmpty:model.thumbnail]) {
        [self.thumbnailImageView sd_setImageWithURL:[NSURL URLWithString:model.thumbnail] placeholderImage:[UIImage imageNamed:@"cs_home_course"]];
    }
    
    self.titleLabel.text = model.title;
    self.authorLabel.text = model.author;
    self.priceLabel.text = model.price;
    self.courceLabel.text = model.courses;
    self.studyLabel.text = model.studies;
}

#pragma mark - Properties

- (UIView*)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectZero];
        _containerView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
    }
    return _containerView;
}

- (UIImageView*)thumbnailImageView{
    if (!_thumbnailImageView) {
        _thumbnailImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _thumbnailImageView.layer.masksToBounds = YES;
        _thumbnailImageView.layer.cornerRadius = 6;
        _thumbnailImageView.image = [UIImage imageNamed:@"cs_home_course"];
    }
    return _thumbnailImageView;
}

- (UILabel*)typeLabel{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _typeLabel.textColor = [UIColor whiteColor];
        _typeLabel.layer.masksToBounds = YES;
        _typeLabel.layer.cornerRadius = 7;
        _typeLabel.backgroundColor = [UIColor colorWithHexString:@"#101426"];
    }
    return _typeLabel;
}


- (UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    return _titleLabel;
}

- (UILabel*)authorLabel{
    if (!_authorLabel) {
        _authorLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _authorLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.6];;
        _authorLabel.font = [UIFont systemFontOfSize:10.0f];
    }
    return _authorLabel;
}

- (UILabel*)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _priceLabel.textColor = [UIColor colorWithHexString:@"#FCB086"];
        _priceLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    return _priceLabel;
}

- (UIView*)separtLine{
    if (!_separtLine) {
        _separtLine = [[UIView alloc]initWithFrame:CGRectZero];
        _separtLine.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.38];
    }
    return _separtLine;
}

- (UILabel*)courceLabel{
    if (!_courceLabel) {
        _courceLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _courceLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.38];
        _courceLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    return _courceLabel;
}

- (UILabel*)studyLabel{
    if (!_studyLabel) {
        _studyLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _studyLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.38];
        _studyLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    return _studyLabel;
}

@end
