//
//  NSObject+HYLibrary.m
//  eStyle
//
//  Created by yanghaha on 16/7/30.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "NSObject+HYLibrary.h"

@implementation UIColor (HYLibrary)

+ (UIColor *)initWith256Red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    return [UIColor initWith256Red:red green:green blue:blue alpha:1];
}

+ (UIColor *)initWith256Red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:(red/255.0) green:(green/255.0) blue:(blue/255.0) alpha:alpha];
}

@end
