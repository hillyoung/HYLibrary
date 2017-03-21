//
//  HYSangForVPNConnect.h
//  JJLN
//
//  Created by luculent on 2016/11/3.
//  Copyright © 2016年 Hitoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYSangForVPNConnecter : NSObject

@property (copy, nonatomic) NSString *host;     //深信服vpn服务器域名
@property (nonatomic) short port;               //深信服vpn服务器端口号
@property (copy, nonatomic) NSString *name;     //深信服vpn用户名
@property (copy, nonatomic) NSString *password; //深信服vpn密码
@property (nonatomic, readonly, getter=isInitialized) BOOL initialized;     //标志vpn是否完成初始化

+ (instancetype)shareConnecter ;
/**
 初始化深信服VPN，可以配合initSuccessBlock使用达到初始化后自动登录的功能
 */
- (void)initVPN:(void(^)(HYSangForVPNConnecter *connecter))initSuccessBlock initFailBlock:(void(^)(HYSangForVPNConnecter *connecter))initFailBlock ;

/**
 登录深信服VPN，可以在配合loginSuccessBlock使用，完成登录vpn后调用其他业务
 */
- (void)loginVPN:(void(^)(HYSangForVPNConnecter *connecter))loginSuccessBlock loginFailBlock:(void(^)(HYSangForVPNConnecter *connecter))loginFailBlock;

@end
