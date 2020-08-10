//
//  CSHomeBaseTopiceCell.h
//  ColorStar
//
//  Created by gavin on 2020/8/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSHomeTopicBaseModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface CSHomeBaseTopiceCell : UICollectionViewCell

@property (nonatomic, strong)CSHomeTopicBaseModel  * baseModel;

@property (nonatomic, strong)UIView      * containerView;

@property (nonatomic, strong)UIImageView * thumbnailImageView;

@property (nonatomic, strong)UILabel     * typeLabel;

@property (nonatomic, strong)UILabel     * titleLabel;

@property (nonatomic, strong)UILabel     * authorLabel;

@property (nonatomic, strong)UILabel     * priceLabel;

@property (nonatomic, strong)UIView      * separtLine;

@property (nonatomic, strong)UILabel     * courceLabel;

@property (nonatomic, strong)UILabel     * studyLabel;

- (void)setupViews;

- (void)setupConstraint;

- (void)configurModel:(CSHomeTopicBaseModel*)model;

@end

NS_ASSUME_NONNULL_END
