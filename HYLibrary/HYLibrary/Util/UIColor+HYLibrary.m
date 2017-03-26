//
//  UIColor+HYLibrary.m
//  HYLibrary
//
//  Created by yanghaha on 17/3/25.
//  Copyright © 2017年 hillyoung. All rights reserved.
//

#import "UIColor+HYLibrary.h"

@implementation UIColor (HYLibrary)

+ (UIColor *)colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];

    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }

    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    else if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];

    if ([cString length] != 6)
        return [UIColor clearColor];


    unsigned int rgbValue;

    [[NSScanner scannerWithString:cString] scanHexInt:&rgbValue];

    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];
}

+ (UIColor *)initWith256Red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    return [UIColor initWith256Red:red green:green blue:blue alpha:1];
}

+ (UIColor *)initWith256Red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:(red/255.0) green:(green/255.0) blue:(blue/255.0) alpha:alpha];
}

@end
