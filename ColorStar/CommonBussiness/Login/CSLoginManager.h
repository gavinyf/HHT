//
//  CSLoginManager.h
//  ColorStar
//
//  Created by gavin on 2020/8/6.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CSLoginManager : NSObject

+ (instancetype)sharedManager;

- (BOOL)isLogin;

@end


