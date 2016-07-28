//
//  HYGlobalCommon.m
//  DemoProject
//
//  Created by yanghaha on 15/8/27.
//  Copyright (c) 2015年 yanghaha. All rights reserved.
//

#import "HYGlobalCommon.h"

@implementation HYGlobalCommon

+ (UIStoryboard *)storyboardWithName:(NSString *)name {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:name bundle:nil];

    return storyboard;
}

+ (void)showTosta:(NSString *)msg {
    [HYGlobalCommon showTosta:msg hideAfterDelay:Tosta_delay];
}

+(void)showTosta:(NSString *)msg hideAfterDelay:(NSTimeInterval)times
{

//    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication] delegate] window] animated:YES];
//    HUD.detailsLabelFont = HUD.labelFont;
//    HUD.detailsLabelText = msg;
//    HUD.mode = MBProgressHUDModeText;
//
//    //指定距离中心点的X轴和Y轴的偏移量，如果不指定则在屏幕中间显示
//    //    HUD.yOffset = 150.0f;
//    //    HUD.xOffset = 100.0f;
//
//
//    [HUD hide:YES afterDelay:times];
    
    [HYGlobalCommon showTosta:msg view:[[[UIApplication sharedApplication] delegate] window] hideAfterDelay:times];
}

+ (void)showTosta:(NSString *)msg view:(UIView *)view hideAfterDelay:(NSTimeInterval)times {
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.detailsLabelFont = HUD.labelFont;
    HUD.detailsLabelText = msg;
    HUD.mode = MBProgressHUDModeText;
    
    //指定距离中心点的X轴和Y轴的偏移量，如果不指定则在屏幕中间显示
    //    HUD.yOffset = 150.0f;
    //    HUD.xOffset = 100.0f;
    
    
    [HUD hide:YES afterDelay:times];
}

+(id)showProgress:(UIView *)view animated:(BOOL)animated {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:animated];

    return hud;
}

+ (id)showTitle:(NSString *)title view:(UIView *)view animated:(BOOL)animated {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.removeFromSuperViewOnHide = YES;
    hud.labelText = title;
    [view addSubview:hud];
    [hud show:YES];

    return hud;
}

#pragma mark - 颜色

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

+ (CGFloat)systemVersion {
    static NSUInteger deviceSystemMajorVersion = -1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion]
                                       componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
    });

    return deviceSystemMajorVersion;
}

+ (NSDateFormatter *)commonDateFormatter {
    NSDateFormatter *dateFormtter = [[NSDateFormatter alloc] init];
    dateFormtter.dateFormat = @"yyyy-MM-dd";

    return dateFormtter;
}

+ (NSString *)stringFromCommonDateFormatterWithDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [HYGlobalCommon commonDateFormatter];
    return [dateFormatter stringFromDate:date];
}

+ (NSDateFormatter *)commonTimeFormatter {
    NSDateFormatter *dateFormtter = [[NSDateFormatter alloc] init];
    dateFormtter.dateFormat = @"HH:mm:ss";
    
    return dateFormtter;
}

+ (NSString *)stringFromCommonTimeFormatterWithDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [HYGlobalCommon commonTimeFormatter];
    return [dateFormatter stringFromDate:date];
}

+ (NSDateFormatter *)commonDateTimeFormatter {
    NSDateFormatter *dateFormtter = [[NSDateFormatter alloc] init];
    dateFormtter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    return dateFormtter;
}

+ (NSString *)stringFromCommonDateTimeFormatterWithDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [HYGlobalCommon commonDateTimeFormatter];
    return [dateFormatter stringFromDate:date];
}

@end
