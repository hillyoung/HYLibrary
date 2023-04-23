//
//  HYNavigationManager.m
//  SimpleTool
//
//  Created by 2 on 2020/10/16.
//  Copyright © 2020 Hillyoung. All rights reserved.
//

#import "HYNavigationManager.h"
#import <MapKit/MapKit.h>

@implementation HYNavigateItem

- (instancetype)initWithTitle:(NSString *)title {
    if (self = [super init]) {
        _title = title;
    }
    return self;
}

@end


@implementation HYNavigationManager

+ (NSArray<HYNavigateItem *> *)getInstalledMapAppWithEndLocation:(CLLocationCoordinate2D)endLocation name:(NSString *)name {
    NSMutableArray *maps = [NSMutableArray array];
    
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"] ? :@"";    // 获取app的名称
    NSArray *urlTypes = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleURLTypes"];  // 获取app中所有的Url Type
    NSDictionary *info = urlTypes.firstObject; // 获取第一个Url Type信息
    NSArray *urlSchemes = [info objectForKey:@"CFBundleURLSchemes"]; // 获取所有的Url Scheme
    NSString *urlScheme = urlSchemes.firstObject ? :@"";    // 获取第一个Url Scheme
    
    // 苹果地图
    HYNavigateItem *item = [[HYNavigateItem alloc] initWithTitle:@"苹果地图"];
    item.actionBlock = ^{
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:endLocation addressDictionary:nil]];
        toLocation.name = name;
        [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                       launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
                                       MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
    };
    [maps addObject:item];
    
    void(^actionBlock)(NSString *urlString) = ^(NSString *urlString) {
        NSString *encodedUrl = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *url = [NSURL URLWithString:encodedUrl ? :@""];
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:url];
        }
    };

    // 百度地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        item = [[HYNavigateItem alloc] initWithTitle:@"百度地图"];
        [item setActionBlock:^{
            actionBlock([NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name:%@&mode=driving&coord_type=gcj02",endLocation.latitude,endLocation.longitude, name]);
        }];
        [maps addObject:item];
    }
    
    // 高德地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        item = [[HYNavigateItem alloc] initWithTitle:@"高德地图"];
        [item setActionBlock:^{
            actionBlock([NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&poiname=%@&dev=0&style=2", appName, urlScheme,endLocation.latitude,endLocation.longitude, name]);
        }];
        [maps addObject:item];
    }
    
    // 谷歌地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
        item = [[HYNavigateItem alloc] initWithTitle:@"谷歌地图"];
        [item setActionBlock:^{
            actionBlock([NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving", appName, urlScheme,endLocation.latitude, endLocation.longitude]);
        }];
        [maps addObject:item];
    }
    
    // 腾讯地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]) {
        item = [[HYNavigateItem alloc] initWithTitle:@"腾讯地图"];
        [item setActionBlock:^{
            actionBlock([NSString stringWithFormat:@"qqmap://map/routeplan?from=我的位置&type=drive&tocoord=%f,%f&to=%@&coord_type=1&policy=0",endLocation.latitude, endLocation.longitude, name]);
        }];
        [maps addObject:item];
    }
    
    return maps;
}

+ (NSArray<HYNavigateItem *> *)getInstalledMapAppWithLocationEndLocation:(CLLocationCoordinate2D)endLocation name:(NSString *)name content:(NSString *)content {
    NSMutableArray *maps = [NSMutableArray array];
    
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"] ? :@"";    // 获取app的名称
    NSArray *urlTypes = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleURLTypes"];  // 获取app中所有的Url Type
    NSDictionary *info = urlTypes.firstObject; // 获取第一个Url Type信息
    NSArray *urlSchemes = [info objectForKey:@"CFBundleURLSchemes"]; // 获取所有的Url Scheme
    NSString *urlScheme = urlSchemes.firstObject ? :@"";    // 获取第一个Url Scheme
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    
    // 苹果地图
    HYNavigateItem *item = [[HYNavigateItem alloc] initWithTitle:@"苹果地图"];
    item.actionBlock = ^{
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:endLocation addressDictionary:nil]];
        toLocation.name = name;
        [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                       launchOptions:@{}];
    };
    [maps addObject:item];
    
    void(^actionBlock)(NSString *urlString) = ^(NSString *urlString) {
        NSString *encodedUrl = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *url = [NSURL URLWithString:encodedUrl ? :@""];
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:url];
        }
    };

    // 百度地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        item = [[HYNavigateItem alloc] initWithTitle:@"百度地图"];
        [item setActionBlock:^{
            actionBlock([NSString stringWithFormat:@"baidumap://map/marker?location=%f,%f&title=%@&content=%@&src=%@", endLocation.latitude, endLocation.longitude, name, content, bundleIdentifier]);
        }];
        [maps addObject:item];
    }
    
    // 高德地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        item = [[HYNavigateItem alloc] initWithTitle:@"高德地图"];
        [item setActionBlock:^{
            actionBlock([NSString stringWithFormat:@"iosamap://viewMap?sourceApplication=%@&poiname=%@&lat=%f&lon=%f", bundleIdentifier, name, endLocation.latitude, endLocation.longitude]);
        }];
        [maps addObject:item];
    }
    
    // 谷歌地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
        item = [[HYNavigateItem alloc] initWithTitle:@"谷歌地图"];
        [item setActionBlock:^{
            actionBlock([NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving", appName, urlScheme,endLocation.latitude, endLocation.longitude]);
        }];
        [maps addObject:item];
    }
    
    // 腾讯地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]) {
        item = [[HYNavigateItem alloc] initWithTitle:@"腾讯地图"];
        [item setActionBlock:^{
            actionBlock([NSString stringWithFormat:@"qqmap://map/marker?marker=coord:%f,%f;title:%@;addr:%@&referer=%@", endLocation.latitude, endLocation.longitude, name, [content stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]],  bundleIdentifier]);
        }];
        [maps addObject:item];
    }
    return maps;
}

@end
