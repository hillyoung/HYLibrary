//
//  UIDevice+HYLibrary.m
//  HYLibrary
//
//  Created by yanghaha on 17/3/26.
//  Copyright © 2017年 hillyoung. All rights reserved.
//

#import "UIDevice+HYLibrary.h"

@implementation UIDevice (HYLibrary)

+ (CGFloat)systemVersion {
    static NSUInteger deviceSystemMajorVersion = -1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion]
                                      componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
    });

    return deviceSystemMajorVersion;
}

@end
