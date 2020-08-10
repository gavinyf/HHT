//
//  CSHomeViewController.m
//  ColorStar
//
//  Created by gavin on 2020/8/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSHomeViewController.h"
#import "CSSearchViewController.h"
#import <Masonry.h>
#import "UIView+CS.h"
#import "UIColor+CS.h"

#import "CSHomeSearchBarCell.h"
#import "CSHomeCycleCell.h"
#import "CSHomeCategoryCell.h"
#import "CSHomePressCell.h"
#import "CSHomeSmallCell.h"
#import "CSHomeSquareCell.h"
#import "CSHomeBigCell.h"
#import "CSHomeTopicHeaderReusableView.h"

#import "CSNetworkManager.h"
#import "CSHomeCycleModel.h"
#import "CSHomeCategoryModel.h"
#import "CSHomePressModel.h"
#import "CSHomeTopicSectionModel.h"
#import <YYModel.h>


NSString * const CSHomeSearchBarCellReuseIdentifier = @"CSHomeSearchBarCellReuseIdentifier";
NSString * const CSHomeCycleCellReuseIdentifier = @"CSHomeCycleCellReuseIdentifier";
NSString * const CSHomeCategoryCellReuseIdentifier = @"CSHomeCategoryCellReuseIdentifier";
NSString * const CSHomePressCellReuseIdentifier = @"CSHomePressCellReuseIdentifier";
NSString * const CSHomeSmallCellReuseIdentifier = @"CSHomeSmallCellReuseIdentifier";
NSString * const CSHomeSquareCellReuseIdentifier = @"CSHomeSquareCellReuseIdentifier";
NSString * const CSHomeBigCellReuseIdentifier = @"CSHomeBigCellReuseIdentifier";
NSString * const CSHomeTopicHeaderReusableViewReuseIdentifier = @"CSHomeTopicHeaderReusableViewReuseIdentifier";

@interface CSHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UICollectionView    * collectionView;

@property (nonatomic, strong)NSMutableArray      * banners;//轮播图

@property (nonatomic, strong)NSMutableArray      * categories;//分类

@property (nonatomic, strong)NSMutableArray      * presses;//新闻

@property (nonatomic, strong)NSMutableArray<CSHomeTopicSectionModel*>      * topicList;//专题

@end

@implementation CSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = NSLocalizedString(@"彩色世界", nil);
    self.view.backgroundColor = [UIColor colorWithHexString:@"#121212"];
    [self loadData];
}

- (void)loadData{
    
    [[CSNetworkManager sharedManager] getHomeInfoSuccessComplete:^(CSNetResponseModel * response) {
        
        [self reloadResponse:response];
        
    } failureComplete:^(NSError *error) {
        
        
    }];
    
}


- (void)reloadResponse:(CSNetResponseModel*)response{
    
    NSDictionary * dict = (NSDictionary*)response.data;
    
    //轮播图
    NSArray * banners = [dict valueForKey:@"banner"];
    [self.banners removeAllObjects];
    if (banners.count > 0) {
        for (NSDictionary * dict in banners) {
            CSHomeCycleModel * cycleModel = [CSHomeCycleModel yy_modelWithDictionary:dict];
            [self.banners addObject:cycleModel];
        }
    }
    
    //分类模块
    NSArray * categories = [dict valueForKey:@"recommend"];
    [self.categories removeAllObjects];
    if (categories.count > 0) {
        for (NSDictionary * dict in categories) {
            CSHomeCategoryModel * model = [CSHomeCategoryModel yy_modelWithDictionary:dict];
            [self.categories addObject:model];
        }
    }
    
    //新闻
    NSArray * articles = [dict valueForKey:@"articles"];
    [self.presses removeAllObjects];
    if (articles.count > 0) {
        for (NSDictionary * dict in articles) {
            CSHomePressModel * pressModel = [CSHomePressModel yy_modelWithDictionary:dict];
            [self.presses addObject:pressModel];
        }
    }
    
    //专题分类
    NSDictionary * content = [dict valueForKey:@"content_recommend"];
    NSArray * recommend = [content valueForKey:@"recommend"];
    [self.topicList removeAllObjects];
    if (recommend.count > 0) {
        for (NSDictionary * dict in recommend) {
            CSHomeTopicSectionModel * sectionModel = [CSHomeTopicSectionModel yy_modelWithDictionary:dict];
            if (sectionModel.list.count > 0) {
                [self.topicList addObject:sectionModel];
            }
        }
    }
    [self setupViews];
    [self.collectionView reloadData];
    
}

- (void)setupViews{
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[CSHomeSearchBarCell class] forCellWithReuseIdentifier:CSHomeSearchBarCellReuseIdentifier];
    [self.collectionView registerClass:[CSHomeCycleCell class] forCellWithReuseIdentifier:CSHomeCycleCellReuseIdentifier];
    [self.collectionView registerClass:[CSHomeCategoryCell class] forCellWithReuseIdentifier:CSHomeCategoryCellReuseIdentifier];
    [self.collectionView registerClass:[CSHomePressCell class] forCellWithReuseIdentifier:CSHomePressCellReuseIdentifier];
    [self.collectionView registerClass:[CSHomeSmallCell class] forCellWithReuseIdentifier:CSHomeSmallCellReuseIdentifier];
    [self.collectionView registerClass:[CSHomeSquareCell class] forCellWithReuseIdentifier:CSHomeSquareCellReuseIdentifier];
    [self.collectionView registerClass:[CSHomeBigCell class] forCellWithReuseIdentifier:CSHomeBigCellReuseIdentifier];
    
    [self.collectionView registerClass:[CSHomeTopicHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CSHomeTopicHeaderReusableViewReuseIdentifier];
    
}


#pragma mark - UICollectionView Method

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4 + self.topicList.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0 || section == 1 || section == 3) {
        return 1;
    }else if (section == 2){
        return self.categories.count;
    }else{
        return self.topicList[section - 4].list.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {//头部搜索框
        CSHomeSearchBarCell * searchBarCell = (CSHomeSearchBarCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CSHomeSearchBarCellReuseIdentifier forIndexPath:indexPath];
        return searchBarCell;
    }else if (indexPath.section == 1){//轮播图
        CSHomeCycleCell * cycleCell = (CSHomeCycleCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CSHomeCycleCellReuseIdentifier forIndexPath:indexPath];
        [cycleCell configModels:self.banners];
        cycleCell.cycleClick = ^(CSHomeCycleModel *model) {
            [self clickCycleModel:model];
        };
        return cycleCell;
    }else if (indexPath.section == 2){//分类
        CSHomeCategoryCell * categoryCell = (CSHomeCategoryCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CSHomeCategoryCellReuseIdentifier forIndexPath:indexPath];
        [categoryCell configModel:self.categories[indexPath.row]];
        return categoryCell;
    }else if (indexPath.section == 3){//新闻
        CSHomePressCell * pressCell = (CSHomePressCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CSHomePressCellReuseIdentifier forIndexPath:indexPath];
        [pressCell configPresses:self.presses];
        return pressCell;
    }else{
        CSHomeTopicSectionModel * model = self.topicList[indexPath.section - 4];
        CSHomeTopicBaseModel * topicModel = model.list[indexPath.row];
        if (model.sectionType == CSHomeTopicSectionTypeBig) {
            CSHomeBigCell * bigCell = (CSHomeBigCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CSHomeBigCellReuseIdentifier forIndexPath:indexPath];
            [bigCell configurModel:topicModel];
            return bigCell;
        }else if (model.sectionType == CSHomeTopicSectionTypeSmall){
            CSHomeSmallCell * smallCell = (CSHomeSmallCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CSHomeSmallCellReuseIdentifier forIndexPath:indexPath];
            [smallCell configurModel:topicModel];
            return smallCell;
        }else if (model.sectionType == CSHomeTopicSectionTypeSquare){
            CSHomeSquareCell * squareCell = (CSHomeSquareCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CSHomeSquareCellReuseIdentifier forIndexPath:indexPath];
            [squareCell configurModel:topicModel];
            return squareCell;
        }
        return nil;
    }
    
    return nil;
}

- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section > 3 && [kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CSHomeTopicSectionModel * model = self.topicList[indexPath.section - 4];
        if (model.sectionType == CSHomeTopicSectionTypeSquare || model.sectionType == CSHomeTopicSectionTypeSmall) {
            
            CSHomeTopicHeaderReusableView * reuseView = (CSHomeTopicHeaderReusableView*)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:CSHomeTopicHeaderReusableViewReuseIdentifier forIndexPath:indexPath];
            reuseView.sectionModel = model;
            return reuseView;
        }
        return nil;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat margin = 10;
    if (indexPath.section == 0) {//搜索框
        return CGSizeMake(self.view.width, 30 + margin*2);
    }else if (indexPath.section == 1){//轮播图
        CGFloat width = self.view.width - 28;
        CGFloat height = width*(160.0/347.0);
        return CGSizeMake(self.view.width, height + 20);
    }else if (indexPath.section == 2){//分类
        CGFloat sideMargin = 10;
        CGFloat itemWidth = (self.view.width - sideMargin*2)/5;
        return CGSizeMake(itemWidth, 35 + 30);
        
    }else if (indexPath.section == 3){//新闻
        return CGSizeMake(self.view.width, 20 + 15*2);
    }else{
        CSHomeTopicSectionModel * model = self.topicList[indexPath.section - 4];
        if (model.sectionType == CSHomeTopicSectionTypeBig) {
            CGFloat width = self.view.width - 28;//386
            CGFloat height = width*(215.0/347.0);//289
            
            return CGSizeMake(self.view.width, height + 55);
        }else if (model.sectionType == CSHomeTopicSectionTypeSmall){
            return CGSizeMake(self.view.width, 106);
        }else if (model.sectionType == CSHomeTopicSectionTypeSquare){
            CGFloat width = self.view.width/2 - 14 - 8;
            CGFloat height = width*(124.0/165.0);
            return CGSizeMake(width, height + 65);
        }
        return CGSizeZero;
    }
    
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section > 3) {
         CSHomeTopicSectionModel * model = self.topicList[section - 4];
        if (model.sectionType == CSHomeTopicSectionTypeSquare || model.sectionType == CSHomeTopicSectionTypeSmall) {
            return CGSizeMake(self.view.width, 55);
        }
    }
    return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    if (section == 2) {
        return UIEdgeInsetsMake(18, 10, 10, 10);
    }
    if (section > 3) {
        CSHomeTopicSectionModel * model = self.topicList[section - 4];
        if (model.sectionType == CSHomeTopicSectionTypeSquare) {
            return UIEdgeInsetsMake(0, 14, 0, 14);
        }
    }
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section > 3) {
        CSHomeTopicSectionModel * model = self.topicList[section - 4];
        if (model.sectionType == CSHomeTopicSectionTypeBig) {
            return 10;
        }
    }
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (section > 3) {
        CSHomeTopicSectionModel * model = self.topicList[section - 4];
        if (model.sectionType == CSHomeTopicSectionTypeSquare) {
            return 16;
        }
    }
    return 0;
}


#pragma mark - Private Method
///进入搜索界面
- (void)enterSearchVC{
    
}

///轮播图点击
- (void)clickCycleModel:(CSHomeCycleModel*)model{
    
}

#pragma mark - Properties Method

- (UICollectionView*)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (NSMutableArray*)banners{
    if (!_banners) {
        _banners = [NSMutableArray arrayWithCapacity:0];
    }
    return _banners;
}

- (NSMutableArray*)categories{
    if (!_categories) {
        _categories = [NSMutableArray arrayWithCapacity:0];
    }
    return _categories;
}

- (NSMutableArray*)presses{
    if (!_presses) {
        _presses = [NSMutableArray arrayWithCapacity:0];
    }
    return _presses;
}

- (NSMutableArray<CSHomeTopicSectionModel *>*)topicList{
    if (!_topicList) {
        _topicList = [NSMutableArray arrayWithCapacity:0];
    }
    return _topicList;
}

- (NSInteger)topicStartIndex{
    NSInteger count = 1;
    count += self.banners.count > 0 ? 1 : 0;
    count += self.categories.count > 0 ? 1 : 0;
    count += self.presses.count > 0 ? 1 : 0;
    return count;
}

@end
