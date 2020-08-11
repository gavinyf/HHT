//
//  CSMineTopView.m
//  ColorStar
//
//  Created by gavin on 2020/8/10.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSMineTopView.h"

@interface CSMineTopView ()

@property (nonatomic, strong)CSMineTopViewModel * model;

@end

@implementation CSMineTopView

- (instancetype)initWithTopViewModel:(CSMineTopViewModel*)model{
    if (self = [super init]) {
        _model = model;
        [self setupViews];
    }
    return self;
}


- (void)setupViews{
    
    
    
}
@end
