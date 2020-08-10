//
//  CSCourseChirdrenViewController.m
//  ColorStar
//
//  Created by gavin on 2020/8/7.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSCourseChirdrenViewController.h"
#import "CSNetworkManager.h"
#import "CSCourseSecondLevelCategoryModel.h"
#import "UIColor+CS.h"
#import "UIView+CS.h"
#import "NSString+CS.h"
#import <Masonry.h>
#import <YYModel.h>
#import "CSColorStar.h"
#import "CSCourseTopicTableCell.h"
#import "CSCourseTopicModel.h"

NSString * const CSCourseTopicTableCellReuseIdentifier = @"CSCourseTopicTableCellReuseIdentifier";

@interface CSCourseChirdrenViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)CSCourseTopCategoryModel  * categoryModel;

@property (nonatomic, strong)UIView * containerView;

@property (nonatomic, strong)NSMutableArray * subCategories;

@property (nonatomic, strong)UIScrollView  * titleScrollView;

@property (nonatomic, strong)UITableView   * tableView;

@property (nonatomic, strong)UIButton      * selectedBtn;

@property (nonatomic, strong)NSMutableDictionary   * topicList;

@property (nonatomic, strong)CSCourseSecondLevelCategoryModel * currentSubCategoryModel;

@property (nonatomic, strong)NSMutableDictionary  * pageList;

@end

@implementation CSCourseChirdrenViewController

- (instancetype)initWithCategoryModel:(CSCourseTopCategoryModel*)model{
    if (self = [super init]) {
        _categoryModel = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.containerView];
    self.containerView.frame = CGRectMake(0, 10, self.view.width, self.view.height - 10);
    [self loadData];
}

- (void)loadData{
    
    [[CSNetworkManager sharedManager] getSecondLevelCategoriesWithCategoryId:self.categoryModel.categoryId successComplete:^(CSNetResponseModel *response) {
        
        [self reloadData:response];
        
    } failureComplete:^(NSError *error) {
        
    }];
}

- (void)reloadData:(CSNetResponseModel*)model{
    NSArray * data = (NSArray*)model.data;
    [self.subCategories removeAllObjects];
    if (data.count > 0) {
        for (NSDictionary * dict in data) {
            CSCourseSecondLevelCategoryModel * model = [CSCourseSecondLevelCategoryModel yy_modelWithDictionary:dict];
            [self.subCategories addObject:model];
            
        }
    }
    if (self.subCategories.count > 0) {
        [self setupTitleScrollView];
        [self setupTableView];
    }
    
    
}

- (void)setupTitleScrollView{
    
    self.titleScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.containerView.width, 58)];
    [self.containerView addSubview:self.titleScrollView];
    
    CGFloat leftMargin = 14;
    CGFloat top = 14;
    UIButton * firstBtn;
    for (int i = 0; i < self.subCategories.count; i++) {
        CSCourseSecondLevelCategoryModel * model = self.subCategories[i];
        NSString * title = model.name;
        CGSize  size = [title textSizeWithHeight:12.0f withFont:[UIFont systemFontOfSize:12.0f]];
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(leftMargin, top, size.width + 30, 30)];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor colorWithHexString:@"#344BDC" alpha:0.12];
        btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 15;
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
        btn.tag = i;
        leftMargin = btn.right + 12;
        [self.titleScrollView addSubview:btn];
        if (i == 0) {
            firstBtn = btn;
        }
    }
    CGFloat contentWidth = MAX(ScreenW, leftMargin);
    self.titleScrollView.contentSize = CGSizeMake(contentWidth, 0);
    
    if (firstBtn) {
        [self click:firstBtn];
    }
}

- (void)setupTableView{
    self.tableView.frame = CGRectMake(0, self.titleScrollView.bottom, self.view.width, self.view.height - self.titleScrollView.bottom);
    [self.tableView registerClass:[CSCourseTopicTableCell class] forCellReuseIdentifier:CSCourseTopicTableCellReuseIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

#pragma mark - Click Method

- (void)click:(UIButton*)sender{
    
    self.selectedBtn.backgroundColor = [UIColor colorWithHexString:@"#344BDC" alpha:0.12];
    

    sender.backgroundColor = [UIColor colorWithHexString:@"#344BDC"];
    self.selectedBtn = sender;
    
    CGFloat offset = sender.center.x - ScreenW * 0.5;
    if (offset < 0) {
        offset = 0;
    }
    CGFloat maxOffset  = self.titleScrollView.contentSize.width - ScreenW;
    if (offset > maxOffset) {
        offset = maxOffset;
    }
    [self.titleScrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
    
    self.currentSubCategoryModel = self.subCategories[sender.tag];
    
    [self loadTopicListWithRefresh:YES];
    
    
}


- (void)loadTopicListWithRefresh:(BOOL)refresh{
    if (refresh) {
        NSMutableArray * tableList = [self.topicList valueForKey:self.currentSubCategoryModel.subCategoryId];
        if (tableList) {
            return;
        }
    }
    NSInteger page = [[self.pageList valueForKey:self.currentSubCategoryModel.subCategoryId] integerValue];
    if (refresh) {
        page = 1;
    }
    
    [[CSNetworkManager sharedManager] getTopicListWithCategoryId:self.currentSubCategoryModel.subCategoryId page:page successComplete:^(CSNetResponseModel *response) {
        [self reloadTabel:response];
        
    } failureComplete:^(NSError *error) {
        
    }];
}

- (void)reloadTabel:(CSNetResponseModel*)response{
    
    NSArray * list = (NSArray*)response.data;
    NSMutableArray * tableList = [self.topicList valueForKey:self.currentSubCategoryModel.subCategoryId];
    if (!tableList) {
        tableList = [NSMutableArray arrayWithCapacity:0];
    }
    for (NSDictionary * dict in list) {
        CSCourseTopicModel * topiModel = [CSCourseTopicModel yy_modelWithDictionary:dict];
        [tableList addObject:topiModel];
    }
    
    [self.tableView reloadData];
}

#pragma mark - UITableView Method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableArray * tableList = [self.topicList valueForKey:self.currentSubCategoryModel.subCategoryId];
    return tableList.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CSCourseTopicTableCell * cell = [tableView dequeueReusableCellWithIdentifier:CSCourseTopicTableCellReuseIdentifier forIndexPath:indexPath];
    NSMutableArray * tableList = [self.topicList valueForKey:self.currentSubCategoryModel.subCategoryId];
    [cell configModel:tableList[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;;
}

#pragma mark Properties Method

- (NSMutableArray*)subCategories{
    if (!_subCategories) {
        _subCategories = [NSMutableArray arrayWithCapacity:0];
    }
    return _subCategories;
}

- (UIView*)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectZero];
        _containerView.backgroundColor = [UIColor colorWithHexString:@"#121212"];
    }
    return _containerView;
}

- (NSMutableDictionary*)topicList{
    if (!_topicList) {
        _topicList = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _topicList;
}

- (NSMutableDictionary*)pageList{
    if (!_pageList) {
        _pageList = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _pageList;
}

- (UITableView*)tableView{
    if (_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
    
}

@end
