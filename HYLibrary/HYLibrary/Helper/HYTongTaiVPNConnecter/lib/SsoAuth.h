//
//  SsoAuth.h
//  Mvpn
//
//  Created by tx on 14-3-27.
//  Copyright (c) 2014年 tx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SsoAuth : NSObject<NSURLConnectionDelegate>{
    
}

+(id)sharedInstance;

- (BOOL)checkSessionValidate;
- (NSString*)ssoAuthByCert:(NSString*)password withAppID:(NSString *)appID withServerAddress:(NSString *)serverAddress;
- (NSString*)ssoAuthBySession:(NSString*)appID withServerAddress:(NSString *)serverAddress;
- (void)ssoLogout;

@end
