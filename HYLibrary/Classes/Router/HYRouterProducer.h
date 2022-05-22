//
//  SDRouterProducer.h
//  SimpleTool
//
//  Created by 2 on 2020/9/15.
//  Copyright © 2020 hillyoung. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface HYURLType : NSObject

@property (copy, nonatomic) NSString *CFBundleTypeRole;
@property (copy, nonatomic) NSString *CFBundleURLName;
@property (strong, nonatomic) NSArray *CFBundleURLSchemes;

- (NSArray<NSURL *> *)availableURLs ;/// 可用的所有url
- (NSURL *)defaultURL ;/// 默认的路径

@end


@interface HYRouterProducer : NSObject
/// 默认地址：包含scheme和域名等信息
@property (strong, nonatomic) NSURL *baseURL;

+ (instancetype)shareProducer ;

- (NSURL *)absoluteURLForPath:(NSString *)path ;
/// 读取infoplist获取SDRouterProducer数组
+ (NSArray<HYRouterProducer *> *)getProducersFromInfoPlist ;

@end

NS_ASSUME_NONNULL_END
