//
//  CSWebManager.m
//  ColorStar
//
//  Created by gavin on 2020/8/6.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSWebManager.h"
#import "CSWebViewController.h"


CSWebManager * manager = nil;
@implementation CSWebManager

+ (instancetype)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CSWebManager alloc]init];
    });
    return manager;
}

- (void)enterWebVCWithURL:(NSString*)url title:(NSString*)title withSupVC:(UIViewController*)vc{
    
    CSWebViewController * webVC = [[CSWebViewController alloc]init];
    webVC.title = title;
    webVC.url = url;
    [vc.navigationController pushViewController:webVC animated:YES];
    
}



@end
