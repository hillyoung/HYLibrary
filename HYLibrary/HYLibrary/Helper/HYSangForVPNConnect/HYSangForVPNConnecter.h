//
//  HYSangForVPNConnect.h
//  JJLN
//
//  Created by luculent on 2016/11/3.
//  Copyright © 2016年 Hitoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthHelper.h"

/**
 *  由于深信服不支持bitcode，集成时需要设置bitcode为NO。
 *  依赖库：libxml2.tbd、SystemConfiguration.framework、AdSupport.framework。
 */
@interface HYSangForVPNConnecter : NSObject

@property (copy, nonatomic) NSString *host;     //深信服vpn服务器域名
@property (nonatomic) short port;               //深信服vpn服务器端口号
@property (copy, nonatomic) NSString *name;     //深信服vpn用户名
@property (copy, nonatomic) NSString *password; //深信服vpn密码
//@property (nonatomic, readonly, getter=isInitialized) BOOL initialized;     //标志vpn是否完成初始化
@property (nonatomic) VPN_STATUS status;  //VPN状态

+ (instancetype)shareConnecter ;

/**
 初始化深信服VPN，可以配合initSuccessBlock使用达到初始化后自动登录的功能
 */
- (void)initVPN:(void(^)(HYSangForVPNConnecter *connecter))initSuccessBlock initFailBlock:(void(^)(HYSangForVPNConnecter *connecter))initFailBlock ;

/**
 登录深信服VPN，可以在配合loginSuccessBlock使用，完成登录vpn后调用其他业务
 */
- (void)loginVPN:(void(^)(HYSangForVPNConnecter *connecter))loginSuccessBlock loginFailBlock:(void(^)(HYSangForVPNConnecter *connecter))loginFailBlock;

/**
 *  初始化并登陆VPN，可以在initBlock编写初始化VPN完成的相关业务
 *  可以在配合loginSuccessBlock使用，完成登录vpn后调用其他业务
 *
 *  @param initBlock         VPN初始化响应的回调
 */
- (void)loginAndInitVPN:(void(^)(HYSangForVPNConnecter *connecter, BOOL isSuccess))initBlock loginSuccessBlock:(void (^)(HYSangForVPNConnecter *))loginSuccessBlock loginFailBlock:(void (^)(HYSangForVPNConnecter *))loginFailBlock;

/**
 退出VPN登录
 */
- (void)logout:(void(^)(BOOL isSuccess))completion ;

/**
 开始关闭与VPN服务器的连接
 */
- (void)startQuit:(void(^)(BOOL isSuccess))completion;

/**
 关闭与VPN服务器的连接
 */
- (void)quit:(void(^)(BOOL isSuccess))completion ;

@end
