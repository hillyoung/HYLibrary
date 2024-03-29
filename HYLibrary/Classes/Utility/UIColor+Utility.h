//
//  UIColor+Utility.h
//  SimpleTool
//
//  Created by 2 on 2020/9/30.
//  Copyright © 2020 Hillyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Utility)

+ (UIColor *)hy_colorWithHexString:(NSString *)hexString;
+ (UIColor *)hy_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

+ (UIColor *)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue;
+ (UIColor *)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha;

+ (UIColor *)colorWithARGBHexString:(NSString *)hexColorString;
/// 随机色
+ (UIColor *)randomColor ;

@end

NS_ASSUME_NONNULL_END
