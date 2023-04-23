//
//  HYNavigationManager.h
//  SimpleTool
//
//  Created by 2 on 2020/10/16.
//  Copyright © 2020 Hillyoung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


NS_ASSUME_NONNULL_BEGIN

/// 可用导航实体类
@interface HYNavigateItem : NSObject
/// 地图类型
@property (nonatomic, copy) NSString *title;
/// 触发的动作
@property (nonatomic, copy) void(^actionBlock)(void);
/// 构造导航实体类
- (instancetype)initWithTitle:(NSString *)title ;

@end

@interface HYNavigationManager : NSObject

+ (NSArray<HYNavigateItem *> *)getInstalledMapAppWithEndLocation:(CLLocationCoordinate2D)endLocation name:(NSString *)name ;

/// 获取可以使用的第三方地图
/// - Parameters:
///   - endLocation: 目的地经纬度
///   - name: 目的地名称
///   - content: 目的地描述
+ (NSArray<HYNavigateItem *> *)getInstalledMapAppWithLocationEndLocation:(CLLocationCoordinate2D)endLocation name:(NSString *)name content:(NSString *)content ;

@end

NS_ASSUME_NONNULL_END
