//
//  UIColor+HYLibrary.h
//  HYLibrary
//
//  Created by yanghaha on 17/3/25.
//  Copyright © 2017年 hillyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HYLibrary)

/**
 *16进制颜色
 */
+ (UIColor *)colorWithHexString: (NSString *)color;

/**
 *传入的色值返回为：0~255
 */
+ (UIColor *)initWith256Red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue ;

+ (UIColor *)initWith256Red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha ;


@end
