//
//  CSMineTopItemView.m
//  ColorStar
//
//  Created by gavin on 2020/8/11.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSMineTopItemView.h"

@interface CSMineTopItemView ()

@property (nonatomic, strong)CSMineConfigModel * configModel;

@property (nonatomic, strong)UIImageView  * iconImageView;

@property (nonatomic, strong)UILabel      * titleLabel;

@property (nonatomic, strong)UILabel      * subTitleLabel;

@end

@implementation CSMineTopItemView

- (instancetype)initWithConfigModel:(CSMineConfigModel*)model{
    if (self = [super init]) {
        _configModel = model;
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
}

@end
