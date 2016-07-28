//
//  HYGlobalCommon.h
//  DemoProject
//
//  Created by yanghaha on 15/8/27.
//  Copyright (c) 2015年 yanghaha. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Tosta_delay 1   //根据不同项目配置不同的延时

@interface HYGlobalCommon : NSObject

+ (void)showTosta:(NSString *)msg;

+ (void)showTosta:(NSString *)msg hideAfterDelay:(NSTimeInterval)times;

+ (void)showTosta:(NSString *)msg view:(UIView *)view hideAfterDelay:(NSTimeInterval)times;

+(id)showProgress:(UIView *)view animated:(BOOL)animated;

/**
 *@params title:显示的标题 view:父视图 animated:是否启用动画
 **/
+ (id)showTitle:(NSString *)title view:(UIView *)view animated:(BOOL)animated;

/**
 *16进制颜色
 */
+ (UIColor *)colorWithHexString: (NSString *)color;

+ (CGFloat)systemVersion;

/**
 *  日期格式 yyyy-MM-dd
 */
+ (NSDateFormatter *)commonDateFormatter;

+ (NSString *)stringFromCommonDateFormatterWithDate:(NSDate *)date ;

/**
 *  时间格式 HH:mm:ss
 */
+ (NSDateFormatter *)commonTimeFormatter ;

+ (NSString *)stringFromCommonTimeFormatterWithDate:(NSDate *)date ;

/**
 *  时间格式 yyyy-MM-dd HH:mm:ss
 */
+ (NSDateFormatter *)commonDateTimeFormatter ;

+ (NSString *)stringFromCommonDateTimeFormatterWithDate:(NSDate *)date ;

@end
