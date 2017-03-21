//
//  HYSangForVPNConnect.m
//  JJLN
//
//  Created by luculent on 2016/11/3.
//  Copyright © 2016年 Hitoo. All rights reserved.
//

#import "HYSangForVPNConnecter.h"
#import "AuthHelper.h"

@interface HYSangForVPNConnecter () <SangforSDKDelegate>

@property (strong, nonatomic) AuthHelper *helper;
@property (nonatomic) BOOL initialized;     //标志vpn是否完成初始化
/**
 初始化成功后的回调
 */
@property (copy, nonatomic) void (^initSuccessBlock)(HYSangForVPNConnecter *connecter);
/**
 登录成功后的回调
 */
@property (copy, nonatomic) void (^loginSuccessBlock)(HYSangForVPNConnecter *connecter);
/**
 初始化成功后的回调
 */
@property (copy, nonatomic) void (^initFailBlock)(HYSangForVPNConnecter *connecter);
/**
 登录成功后的回调
 */
@property (copy, nonatomic) void (^loginFailBlock)(HYSangForVPNConnecter *connecter);


@end

@implementation HYSangForVPNConnecter

+ (instancetype)shareConnecter {
    
    static HYSangForVPNConnecter *defaultConnecter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultConnecter = [[HYSangForVPNConnecter alloc] init];
    });
    
    return defaultConnecter;
}

- (instancetype)init {
    
    if (self = [super init]) {
        _host = @"vpn.cpiyn.com.cn";
        _port = 443;
        _name = @"";
        _password = @"";
    }
    
    return self;
}

#pragma mark - Message

- (void)initVPN:(void (^)(HYSangForVPNConnecter *))initSuccessBlock initFailBlock:(void (^)(HYSangForVPNConnecter *))initFailBlock{
    self.initSuccessBlock = initSuccessBlock;
    self.initFailBlock = initFailBlock;
    self.helper = [[AuthHelper alloc] initWithHostAndPort:self.host port:self.port delegate:self];
}

- (void)loginVPN:(void (^)(HYSangForVPNConnecter *))loginSuccessBlock loginFailBlock:(void (^)(HYSangForVPNConnecter *))loginFailBlock{
    self.loginSuccessBlock = loginSuccessBlock;
    self.loginFailBlock = loginFailBlock;
    if (!self.initialized) {
        NSLog(@"vpn，初始化未完成，请等待vpn初始化完成");
        return;
    }
    
    if (!self.name.length) {
        NSLog(@"请先设置用户名");
        return;
    }
    
    [self.helper setAuthParam:@PORPERTY_NamePasswordAuth_NAME param:self.name];
    [self.helper setAuthParam:@PORPERTY_NamePasswordAuth_PASSWORD param:self.password];
    //开始用户名密码认证
    [self.helper loginVpn:SSL_AUTH_TYPE_PASSWORD];
}

#pragma mark - VPN连接

//- (void)connectVPN:(NSString *)host port:(short)port {
//    self.helper = [[AuthHelper alloc] initWithHostAndPort:host port:port delegate:self];
//}

//- (void)loginVPN:(NSString *)name password:(NSString *)password {
//
////    self.hub = [HYGlobalCommon showTitle:@"VPN连接中,请稍候..." view:self.window animated:YES];
//    [self.helper setAuthParam:@PORPERTY_NamePasswordAuth_NAME param:name];
//    [self.helper setAuthParam:@PORPERTY_NamePasswordAuth_PASSWORD param:password];
//    //开始用户名密码认证
//    [self.helper loginVpn:SSL_AUTH_TYPE_PASSWORD];
//}

- (void) onCallBack:(const VPN_RESULT_NO)vpnErrno authType:(const int)authType
{
    switch (vpnErrno)
    {
        case RESULT_VPN_INIT_FAIL:
            NSLog(@"Vpn Init failed!");
            if (self.initFailBlock) {
                self.initFailBlock(self);
            }
            break;
            
        case RESULT_VPN_AUTH_FAIL:
            [self.helper clearAuthParam:@SET_RND_CODE_STR];
            [self.helper queryVpnStatus];
            if (self.loginFailBlock) {
                self.loginFailBlock(self);
            }
            NSLog(@"Vpn auth failed!");
            break;
            
        case RESULT_VPN_INIT_SUCCESS:
            NSLog(@"Vpn init success!");
            //            [self loginVPN:(NSString *)userId password:(NSString *)password];
            self.initialized = YES;
            if (self.initSuccessBlock) {
                self.initSuccessBlock(self);
            }
            
            break;
        case RESULT_VPN_AUTH_SUCCESS:
            NSLog(@"next type is %d",authType);
            [self startOtherAuth:authType];
            if (self.loginSuccessBlock) {
                self.loginSuccessBlock(self);
            }
            
            break;
        case RESULT_VPN_AUTH_LOGOUT:
            NSLog(@"Vpn logout success!");
            break;
        case RESULT_VPN_OTHER:
            if (VPN_OTHER_RELOGIN_FAIL == (VPN_RESULT_OTHER_NO)authType) {
                NSLog(@"Vpn relogin failed, maybe network error");
            }
            break;
            
        case RESULT_VPN_NONE:
            break;
            
        default:
            break;
    }
}

- (void) startOtherAuth:(const int)authType
{
    NSArray *paths = nil;
    switch (authType)
    {
        case SSL_AUTH_TYPE_CERTIFICATE:
            paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                        NSUserDomainMask, YES);
            
            if (nil != paths && [paths count] > 0)
            {
            }
            NSLog(@"Start Cert Auth!!!");
            break;
            
        case SSL_AUTH_TYPE_PASSWORD:
            NSLog(@"Start Password Name Auth!!!");
            [self.helper setAuthParam:@PORPERTY_NamePasswordAuth_NAME param:self.name];
            [self.helper setAuthParam:@PORPERTY_NamePasswordAuth_PASSWORD param:self.password];
            
            break;
        case SSL_AUTH_TYPE_NONE:
            NSLog(@"Vpn Auth success!");
            //session共享登录--主程序：登录成功之后读取session，然后将它保存到keychain
            //            char buffer[64];
            //            int sessionLen = ssl_get_sessionid(buffer, 64);
            //            NSData *data = [NSData dataWithBytes:buffer length:sessionLen];
            //            KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"Account Number" accessGroup:@"YYE5WQ4M88.com.sangfor.AppDirect"];
            //            [wrapper setObject:data forKey:(id)kSecValueData];
            
            return;
        case SSL_AUTH_TYPE_SMS:
        {
            //            NSString *emsCode = @"765012";
            //            [helper setAuthParam:@SMS_AUTH_CODE param:emsCode];
            //            NSString *phoneNumber = [helper getSmsPhoneNumber];
            //            NSString *countdown = [helper getSmsCountDown];
            //            NSLog(@"phone number is %@",phoneNumber);
            //            NSLog(@"coundown  is %@",countdown);
            
            break;
        }
        case SSL_AUTH_TYPE_RADIUS:
        {
            //            NSString *challenge = @"123321";             //radius挑战认证答案
            //            [self.helper setAuthParam:@CHALLENGE_AUTH_REPLY param:challenge];
            //            NSLog(@"radius challenge code is %@",challenge);
            
            break;
        }
        case SSL_AUTH_TYPE_TOKEN:
        {
            NSString *token = @"123321";             //令牌认证码
            [self.helper setAuthParam:@"Token.Auth.Code" param:token];
            NSLog(@"Token code is %@",token);
            
            break;
        }
        default:
            NSLog(@"Other failed!!!");
            return;
    }
    [self.helper loginVpn:authType];
}

@end
