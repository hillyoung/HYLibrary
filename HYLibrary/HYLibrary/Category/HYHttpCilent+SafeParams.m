//
//  HYHttpCilent+SafeParams.m
//  HYLibrary
//
//  Created by luculent on 16/7/28.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "HYHttpCilent+SafeParams.h"

@implementation HYHttpCilent (SafeParams)

+ (NSDictionary *)paramsForSafeInterfaceFromParams:(NSDictionary *)params {
    
    return params;
    //    //TODO: 针对安全性添加的代码
    //
    //    APP_CURRENT_USER
    //
    //    NSString *susrnam = user.userId;
    //    long long int time = (long long int)[[NSDate date] timeIntervalSince1970]*1000;
    //    NSString *timestamp = @(time).stringValue;
    //    NSString *appkey = Liems_APPKEY_ID;
    //    NSString *secretkey = Liems_SECRETKEY_ID;
    //    NSString *password = [[user.userId stringByAppendingString:user.pword] hy_md5String];
    //    NSString *signStr = [secretkey stringByAppendingFormat:@"%@%@%@", susrnam, password, timestamp];
    //    signStr = [signStr hy_md5String];
    //
    //
    //    NSDictionary *restDic = @{@"susrnam": susrnam,
    //                              @"timestamp": timestamp,
    //                              @"appkey": appkey,
    //                              @"sign": signStr};
    //
    //    NSMutableDictionary *tempDic = [params mutableCopy];
    //    [tempDic setValuesForKeysWithDictionary:restDic];
    //    
    //    return [tempDic copy];
}

@end
