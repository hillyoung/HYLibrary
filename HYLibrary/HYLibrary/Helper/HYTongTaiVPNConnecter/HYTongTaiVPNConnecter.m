//
//  LKVPNConnect.m
//  MDPMS
//
//  Created by luculent on 16/9/26.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "HYTongTaiVPNConnecter.h"
#import "L4Proxy.h"
#import <UIKit/UIKit.h>

//表示获取本地端口是白
#define CODE_FAILED_LOCAL_PORT -10000

@interface HYTongTaiVPNConnecter ()

@property (copy, nonatomic) NSString *targetIP;
@property (nonatomic) int targetPort;
@property (copy, nonatomic) NSString *localIP;
@property (nonatomic) int localPort;

@end

@implementation HYTongTaiVPNConnecter

- (instancetype)init {
    if (self = [super init]) {
        _localIP = @"127.0.0.1";
    }
    
    return self;
}

+ (instancetype)defalutConnect {
    static HYTongTaiVPNConnecter *defaultConnect = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultConnect = [[HYTongTaiVPNConnecter alloc] init];
    });
    
    return defaultConnect;
}

#pragma mark - Private

- (BOOL)reloadLocalPort {
    self.localPort = [[L4Proxy sharedInstance] startLocalListen:[self.targetIP stringByAppendingFormat:@":%d", self.targetPort]];
    return self.localPort > 0;
}

#pragma mark - Message

- (NSString *)localHost {
    return [@"http://" stringByAppendingFormat:@"%@:%d", self.localIP, self.localPort];
}


- (BOOL)setTargetIP:(NSString *)targetIP targetPort:(int)targetPort {
    
    NSAssert(targetIP.length, @"传入vpn的目的ip地址错误");
    NSAssert(targetPort > 0, @"传入vpn的目的端口号错误");

    self.targetIP = targetIP;
    self.targetPort = targetPort;
    return [self reloadLocalPort];
}

- (void)connectVPNTargetIP:(NSString *)targetIP targetPort:(int)targetPort completion:(void(^)(LKVPNConnectStatus status))completion {
    
    NSAssert(targetIP.length, @"传入vpn的目的ip地址错误");
    NSAssert(targetPort > 0, @"传入vpn的目的端口号错误");
    
    self.targetIP = targetIP;
    self.targetPort = targetPort;

    NSString *vpnIp = @"mvpn.zdtmdny.com";
    int vpnPort = 443;
    
    __block int result = -1;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        result = [[L4Proxy sharedInstance] L4Proxy_ShakeHands_With_VPN:vpnIp IPPort:vpnPort username:nil password:nil];
        
        if (result == 0) {
            self.status = LKVPNConnectStatusConnected;
            if (![self reloadLocalPort]) {
                self.status = LKVPNConnectStatusNoLocalPort;
            }
        } else {
            self.status = LKVPNConnectStatusUnconnected;
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(self.status);
            }
        });
    });
}

@end
