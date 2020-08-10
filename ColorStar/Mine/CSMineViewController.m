//
//  CSMineViewController.m
//  ColorStar
//
//  Created by gavin on 2020/8/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSMineViewController.h"

@interface CSMineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView  * tableView;

@end

@implementation CSMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = NSLocalizedString(@"个人中心", nil);
    [self setupTableView];
    
}

- (void)setupTableView{
    self.tableView  = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    
}

#pragma mark - UITableView Method



@end
