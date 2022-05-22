//
//  NSDate+HYLibrary.h
//  HYLibrary
//
//  Created by yanghaha on 17/3/26.
//  Copyright © 2017年 hillyoung. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 提高时间格式化的性能，使用此类时，请使用单例
 */
@interface NSDateFormatterHelper : NSObject

@property (strong, nonatomic, readonly) NSDateFormatter *dateFormatter;

/**
 获取单例对象
 */
+ (instancetype)helpger ;

/**
 通过传入时间及格式，获取从NSDate类型转化为NSString类型
 */
+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format ;

/**
 通过传入时间的字符串、格式，获取格式化后的NSDate类型
 */
+ (NSDate *)dateFromDateString:(NSString *)dateString format:(NSString *)format;

@end



@interface NSDate (HYDateFormatter)

/**
 通过传入时间格式，获取从NSDate类型转化为NSString类型
 */
- (NSString *)stringFromDateFormat:(NSString *)format ;

/**
 格式为"HH:mm:ss"的字符串
 */
- (NSString *)HHmmssStringInEn ;

/**
 格式为"yyyy-MM-dd"的字符串
 */
- (NSString *)yyyyMMddStringInEn ;

/**
 格式为"yyyy-MM-dd HH:mm:ss"的字符串
 */
- (NSString *)yyyyMMddHHmmssStringInEn ;

/**
 格式为"HH时mm分ss秒"的字符串
 */
- (NSString *)HHmmssStringInZh ;

/**
 格式为"yyyy年MM月dd日"的字符串
 */
- (NSString *)yyyyMMddStringInZh ;

/**
 格式为"yyyy年MM月dd日HH时mm分ss秒"的字符串
 */
- (NSString *)yyyyMMddHHmmssStringInZh ;

@end



@interface NSString (HYDateFormatter)

/**
 通过传入
 */
- (NSDate *)dateFromDateFormat:(NSString *)format;


/**
 从格式为"yyyy-MM-dd"的字符串生成NSDate
 */
- (NSDate *)dateFromyyyyMMddInEn ;

/**
 从格式为"yyyy-MM-dd HH:mm:ss"的字符串生成NSDate
 */
- (NSDate *)dateFromyyyyMMddHHmmssInEn ;

/**
 从格式为"yyyy年MM月dd日"的字符串生成NSDate
 */
- (NSDate *)dateFromyyyyMMddInZh ;

/**
 从格式为"yyyy年MM月dd日HH时mm分ss秒"的字符串生成NSDate
 */
- (NSDate *)dateFromyyyyMMddHHmmssInZh ;

@end
