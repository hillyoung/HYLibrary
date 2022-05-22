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

@end

NS_ASSUME_NONNULL_END
