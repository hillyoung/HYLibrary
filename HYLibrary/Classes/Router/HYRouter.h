//
//  SDRouter.h
//  SimpleTool
//
//  Created by 2 on 2020/9/15.
//  Copyright © 2020 hillyoung. All rights reserved.
//

#import <MGJRouter/MGJRouter.h>
#import "HYRouterProducer.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYRouter : MGJRouter

+ (void)getMemberOfClass:(Class)aClass completion:(void(^)(NSArray<Class> *classes))completion ;

+ (void)openPath:(NSString *)path withUserInfo:(NSDictionary *)userInfo completion:(void (^)(id _Nonnull))completion ;

/// 加载path对应的路由
/// @param path 路径
/// @param userInfo 参数
/// @param completion 通过path找到对应的对象
+ (void)loadPath:(NSString *)path withUserInfo:(NSDictionary *)userInfo completion:(void (^)(UIViewController *_Nonnull object))completion ;

+ (id)objectForPath:(NSString *)path withUserInfo:(NSDictionary *)userInfo ;

@end

NS_ASSUME_NONNULL_END
