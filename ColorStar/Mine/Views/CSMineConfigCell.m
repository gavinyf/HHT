//
//  CSMineConfigCell.m
//  ColorStar
//
//  Created by gavin on 2020/8/10.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSMineConfigCell.h"

@interface CSMineConfigCell ()

@property (nonatomic, strong)UIImageView  * iconImageView;

@property (nonatomic, strong)UILabel      * titleLabel;

@property (nonatomic, strong)UIImageView  * arrowImageView;

@end

@implementation CSMineConfigCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.arrowImageView];
    
}


#pragma mark - Properties Method

- (UIImageView*)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    }
    return _iconImageView;
}

- (UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    }
    return _titleLabel;
}

- (UIImageView*)arrowImageView{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    }
    return _arrowImageView;
}

@end
