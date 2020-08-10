//
//  CSLoginManager.m
//  ColorStar
//
//  Created by gavin on 2020/8/6.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSLoginManager.h"

static CSLoginManager * manager = nil;
@implementation CSLoginManager

+ (instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CSLoginManager alloc]init];
    });
    return manager;
}

- (BOOL)isLogin{
    return NO;
}

@end
