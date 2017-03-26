//
//  L4Proxy.h
//  Proxy
//
//  Created by tx on 12-4-1.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface L4Proxy : NSObject {
    
}

+(id)sharedInstance;

-(int)L4Proxy_ShakeHands_With_VPN:(NSString*)cDestip IPPort:(int)iPort username:(NSString*)uname password:(NSString*)pass ;
-(int)startLocalListen:(NSString*)desStr;
void  L4Proxy_SetDebug(int iDebug);
@end
