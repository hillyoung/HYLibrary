//
//  LKVPNConnect.h
//  MDPMS
//
//  Created by luculent on 16/9/26.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import <Foundation/Foundation.h>

#define VPN_CONNECTED @"VPN_CONNECTED"

typedef enum : NSUInteger {
    LKVPNConnectStatusUnconnected,
    LKVPNConnectStatusConnected,
    LKVPNConnectStatusNoLocalPort,
} LKVPNConnectStatus;

@interface HYTongTaiVPNConnecter : NSObject

@property (copy, nonatomic, readonly) NSString *targetIP;       //实际访问的ip
@property (nonatomic, readonly) int targetPort;             //实际访问端口号
@property (copy, nonatomic, readonly) NSString *localIP;    //本地ip
@property (nonatomic, readonly) int localPort;      //本地端口号
@property (nonatomic) LKVPNConnectStatus status;        //标志vpn的连接状态

/**
 *  获取本地服务的地址
 */
- (NSString *)localHost;

+ (instancetype)defalutConnect;

- (BOOL)setTargetIP:(NSString *)targetIP targetPort:(int)targetPort;

/**
 *  链接vpn
 * result为CODE_FAILED_LOCAL_PORT表示，获取本地端口号失败
 */
- (void)connectVPNTargetIP:(NSString *)targetIP targetPort:(int)targetPort completion:(void(^)(LKVPNConnectStatus status))completion ;


@end
