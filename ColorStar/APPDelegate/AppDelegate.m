//
//  AppDelegate.m
//  ColorStar
//
//  Created by gavin on 2020/8/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "AppDelegate.h"
#import "CSBaseTabBarController.h"
#import "CSBaseNavigationController.h"
#import "CSHomeViewController.h"
#import "CSCourseViewController.h"
#import "CSMineViewController.h"


@interface AppDelegate ()

@property (nonatomic, strong)CSBaseTabBarController  * rootTabBarVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setupTabbar];
    return YES;
}



- (void)setupTabbar{
    
    CSHomeViewController * csHomeVC = [[CSHomeViewController alloc]init];
    CSBaseNavigationController * csHomeNVC = [[CSBaseNavigationController alloc]initWithRootViewController:csHomeVC];
    csHomeNVC.tabBarItem.image = [UIImage imageNamed:@"cs_tabbar_home"];
    csHomeNVC.tabBarItem.selectedImage = [UIImage imageNamed:@"cs_tabbar_home"];
    csHomeNVC.tabBarItem.title = NSLocalizedString(@"彩色世界", nil);
    
    CSCourseViewController * csCourseVC = [[CSCourseViewController alloc]init];
    CSBaseNavigationController * csCourseNVC = [[CSBaseNavigationController alloc]initWithRootViewController:csCourseVC];
    csCourseNVC.tabBarItem.image = [UIImage imageNamed:@"cs_tabbar_course"];
    csCourseNVC.tabBarItem.selectedImage = [UIImage imageNamed:@"cs_tabbar_course_selected"];
    csCourseNVC.tabBarItem.title = NSLocalizedString(@"查看", nil);

    
    CSMineViewController * mineVC = [[CSMineViewController alloc]init];
    CSBaseNavigationController * mineNVC = [[CSBaseNavigationController alloc]initWithRootViewController:mineVC];
    mineNVC.tabBarItem.image = [UIImage imageNamed:@"cs_tabbar_mine"];
    mineNVC.tabBarItem.selectedImage = [UIImage imageNamed:@"cs_tabbar_mine_selected"];
    mineNVC.tabBarItem.title = NSLocalizedString(@"我的", nil);
    
    self.rootTabBarVC = [[CSBaseTabBarController alloc]init];
    self.rootTabBarVC.viewControllers = @[csHomeNVC,csCourseNVC,mineNVC];
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = self.rootTabBarVC;
    [self.window makeKeyAndVisible];
    
}

@end
