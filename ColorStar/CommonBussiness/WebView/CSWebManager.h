//
//  CSWebManager.h
//  ColorStar
//
//  Created by gavin on 2020/8/6.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CSWebManager : NSObject

+ (instancetype)sharedManager;

- (void)enterWebVCWithURL:(NSString*)url title:(NSString*)title withSupVC:(UIViewController*)vc;

@end


