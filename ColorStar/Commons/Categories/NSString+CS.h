//
//  NSString+CS.h
//  ColorStar
//
//  Created by gavin on 2020/8/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (CS)

/// 判断是否为空
+ (BOOL)isNilOrEmpty:(NSString *)str;

/**
 *  根据字体大小和高度获取宽度
 *
 *  @param heightValue 高度
 *  @param font        字体大小
 *
 *  @return 计算后文本的Size
 */
- (CGSize)textSizeWithHeight:(CGFloat)heightValue
                    withFont:(UIFont *)font;
@end

NS_ASSUME_NONNULL_END
