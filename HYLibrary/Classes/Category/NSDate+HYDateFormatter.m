//
//  NSDate+HYLibrary.m
//  HYLibrary
//
//  Created by yanghaha on 17/3/26.
//  Copyright © 2017年 hillyoung. All rights reserved.
//

#import "NSDate+HYDateFormatter.h"

@interface NSDateFormatterHelper ()

@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation NSDateFormatterHelper

+ (instancetype)helpger {
    static NSDateFormatterHelper *helpger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helpger = [NSDateFormatterHelper new];
    });
    return helpger;
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    }
    return _dateFormatter;
}

+ (NSDate *)dateFromDateString:(NSString *)dateString format:(NSString *)format {
    return [[NSDateFormatterHelper helpger] makeDateFormaterCall:^id(NSDateFormatterHelper *helper) {
        return [[NSDateFormatterHelper helpger].dateFormatter dateFromString:dateString];
    } format:format];
}

+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format {
    return [[NSDateFormatterHelper helpger] makeDateFormaterCall:^id(NSDateFormatterHelper *helper) {
        return [[NSDateFormatterHelper helpger].dateFormatter stringFromDate:date];
    } format:format];
}

/**
 统一管理，执行时间的格式问题
 */
- (id)makeDateFormaterCall:(id(^)(NSDateFormatterHelper *helper))contentBlock format:(NSString *)format {

    NSString *tempFormat = self.dateFormatter.dateFormat; //保存原始时间格式
    self.dateFormatter.dateFormat = format;

    id result = nil;
    if (contentBlock) {
        result = contentBlock(self);
    }

    self.dateFormatter.dateFormat = tempFormat;   //重置时间格式
    return result;

}

@end


@implementation NSDate (HYDateFormatter)

- (NSString *)stringFromDateFormat:(NSString *)format {
    return [NSDateFormatterHelper stringFromDate:self format:format];
}

- (NSString *)HHmmssStringInEn {
    return [self stringFromDateFormat:@"HH:mm:ss"];
}

- (NSString *)yyyyMMddStringInEn {
    return [self stringFromDateFormat:@"yyyy-MM-dd"];
}

- (NSString *)yyyyMMddHHmmssStringInEn {
    return [self stringFromDateFormat:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSString *)HHmmssStringInZh {
    return [self stringFromDateFormat:@"HH时mm分ss秒"];
}

- (NSString *)yyyyMMddStringInZh {
    return [self stringFromDateFormat:@"yyyy年MM月dd日"];
}

- (NSString *)yyyyMMddHHmmssStringInZh {
    return [self stringFromDateFormat:@"yyyy年MM月dd日HH时mm分ss秒"];
}

@end


@implementation NSString (HYDateFormatter)

- (NSDate *)dateFromDateFormat:(NSString *)format {
    return [NSDateFormatterHelper dateFromDateString:self format:format];
}

- (NSDate *)dateFromyyyyMMddInEn {
    return [self dateFromDateFormat:@"yyyy-MM-dd"];
}

- (NSDate *)dateFromyyyyMMddHHmmssInEn {
    return [self dateFromDateFormat:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSDate *)dateFromyyyyMMddInZh {
    return [self dateFromDateFormat:@"yyyy年MM月dd日"];
}

- (NSDate *)dateFromyyyyMMddHHmmssInZh {
    return [self dateFromDateFormat:@"yyyy年MM月dd日HH时mm分ss秒"];
}

@end
