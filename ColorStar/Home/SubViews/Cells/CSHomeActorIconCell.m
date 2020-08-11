//
//  CSHomeActorIconCell.m
//  ColorStar
//
//  Created by gavin on 2020/8/11.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSHomeActorIconCell.h"
#import "CSHomeActorIconModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry.h>
#import "NSString+CS.h"

NSString * const CSHomeActorIconItemCellReuseIdentifier = @"CSHomeActorIconItemCellReuseIdentifier";

@interface CSHomeActorIconItemCell : UICollectionViewCell

@property (nonatomic, strong)UIView   * containerView;

@property (nonatomic, strong)UIImageView  * imageView;

@property (nonatomic, strong)CSHomeActorIconModel  * iconModel;

@end

@implementation CSHomeActorIconItemCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)configModel:(CSHomeActorIconModel*)model{
    self.iconModel = model;
    
    if ([NSString isNilOrEmpty:self.iconModel.pic]) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.iconModel.pic] placeholderImage:[UIImage imageNamed:@""]];
    }
    
    
}

- (void)setupViews{
    
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.imageView];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.containerView);
    }];
    
}

#pragma mark - Properties Method

- (UIView*)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectZero];
        _containerView.layer.masksToBounds = YES;
        _containerView.layer.cornerRadius = 5;
    }
    return _containerView;
}

- (UIImageView*)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _imageView.image = [UIImage imageNamed:@""];
    }
    return _imageView;
}

@end

@interface CSHomeActorIconCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UICollectionView  * collectionView;

@property (nonatomic, strong)NSArray           * models;

@end

@implementation CSHomeActorIconCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.contentView.bounds collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[CSHomeActorIconItemCell class] forCellWithReuseIdentifier:CSHomeActorIconItemCellReuseIdentifier];
    [self.contentView addSubview:self.collectionView];
    
}

- (void)configModels:(NSArray*)models{
    self.models = models;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView Method

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CSHomeActorIconItemCell * itemCell = [collectionView dequeueReusableCellWithReuseIdentifier:CSHomeActorIconItemCellReuseIdentifier forIndexPath:indexPath];
    CSHomeActorIconModel * model = self.models[indexPath.row];
    [itemCell configModel:model];
    return itemCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

@end
