//
//  HYCustomEncryptor.h
//  CleanDemo
//
//  Created by hb28130 on 12/9/2025.
//  Copyright © 2025 hillyoung. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HLECIESEncryptor : NSObject

/// 16进制字符串转data
/// - Parameter hex: 16进制字符串
+ (NSData *)dataFromHexString:(NSString *)hex ;
/// data转16进制字符串
/// - Parameter data: data数据
+ (NSString *)hexStringFromData:(NSData *)data ;

+ (NSData *)eciesEncrypt:(NSData *)plainData publicKeyData:(NSData *)publicKeyData ;

+ (NSData *)eciesDecrypt:(NSData *)data privateKeyData:(NSData *)privateKeyData ;

@end

NS_ASSUME_NONNULL_END
