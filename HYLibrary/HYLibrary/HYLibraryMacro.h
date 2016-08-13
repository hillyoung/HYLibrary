//
//  HYLibraryMacro.h
//  MDPMS
//
//  Created by luculent on 16/6/3.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

//依赖
//pod 'Masonry', ' 1.0.1'
//pod 'AFNetworking', '~> 2.6.3'
//pod 'MJRefresh', '~> 3.1.10'
//pod 'JGActionSheet', '~> 1.0.5'
//pod 'MBProgressHUD', '~> 1.0.0'

#ifndef HYLibraryMacro_h
#define HYLibraryMacro_h

#if DEBUG

#define HY_LOG(args, ...) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(args), ##__VA_ARGS__] )

#else

#define HY_LOG(args, ...)

#endif


#import "Masonry.h"
#import "HYGlobalCommon.h"
#import "MBProgressHUD.h"

#import "HYLRTextField.h"

#pragma mark - Category

#import "UIView+EffectAnimation.h"
#import "UIImage+HYLibrary.h"
#import "UIViewController+HYLibrary.h"
#import "NSString+Encrypt.h"
#import "NSObject+HYLibrary.h"
#import "HYHttpCilent+SafeParams.h"
#import "NSLayoutConstraint+EasyAutoLayout.h"

#pragma mark - Base

#import "MJRefresh.h"
#import "PHAsset+HYLoadLocalSource.h"

#pragma mark - Model

#import "HYModelMacro.h"

#pragma mark - Network

#import "HYHttpCilent.h"

#pragma mark - View

#import "HYViewMacro.h"

#pragma mark - VC

#import "HYMetadataViewController.h"

#pragma mark - UIImage

#define HY_IMAGE_NAMEED(name) [UIImage imageNamed:name]


#pragma mark - NSNumber
//封装int
#define HY_NUMBER_WITH_INT(number) [NSNumber numberWithInteger:number]
//封装
#define HY_NUMBER_WITH_FLOAT(number) [NSNumber numberWithFloat:number]
//封装
#define HY_NUMBER_WITH_BOOL(number) [NSNumber numberWithBool:number]
//weakself
#define HY_WEAKSELF(object) __weak typeof(&*object) weakSelf = object

#pragma mark - Color
//自定义颜色
#define HY_COLOR_RGB(r, g, b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]

#define HY_COLOR_RGBA(r, g, b, a) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:a]

//随机颜色
#define HY_COLOR_RANDOM HY_COLOR_RGB(arc4random()%256, arc4random()%256, arc4random()%256)



#pragma mark - NSString

#define NSStringFromInt(intValue) [NSString stringWithFormat:@"%d",intValue]

#pragma mark - System

//获取屏幕 宽度、高度
#define HY_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define HY_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
//获取系统版本号
#define HY_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define HY_SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)

#define HY_SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

#define HY_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define HY_SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

#define HY_SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#pragma mark - PATH 

#define HY_Cache_Path [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

#endif /* HYLibraryMacro_h */
