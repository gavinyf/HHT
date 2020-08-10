//
//  CSBaseTabBarController.m
//  ColorStar
//
//  Created by gavin on 2020/8/5.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseTabBarController.h"

@interface CSBaseTabBarController ()

@end

@implementation CSBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [[UITabBar appearance] setBarTintColor:[UIColor blackColor]];
    [UITabBar appearance].translucent = NO;
}

@end
