//
//  NSString+CS.m
//  ColorStar
//
//  Created by gavin on 2020/8/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "NSString+CS.h"

@implementation NSString (CS)

+ (BOOL)isNilOrEmpty:(NSString *)str {
    if (!str || ![str isKindOfClass:[NSString class]] || str.length == 0) {
        return YES;
    }
    return NO;
}

- (CGSize)textSizeWithHeight:(CGFloat)heightValue withFont:(UIFont *)font {
    CGSize size = CGSizeZero;
    if (self) {
        CGRect frame = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, heightValue)
                                          options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{ NSFontAttributeName:font }
                                          context:nil];
        
        size = CGSizeMake(frame.size.width, frame.size.height + 1);
    }
    return size;
}

@end
