//
//  HLRiskECCEntrptor.h
//  HLDeviceDetecterKit
//
//  Created by hb28130 on 30/6/2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HLRiskECCEncryptor : NSObject
/// 单例对象
+ (instancetype)shareEncryptor ;
/// 导出公钥或私钥
/// - Parameter key: 待导出的公钥、私钥
- (NSData *)exportKeyAsDER:(SecKeyRef)key ;
/// 加密数据
/// - Parameters:
///   - data: 待加密的数据
///   - error: 错误信息
- (NSData *)encrypteData:(NSData *)data error:(NSError **)error ;
/// 解密数据
/// - Parameters:
///   - data: 加密数据
///   - error: 错误信息
- (NSData *)decryptData:(NSData *)data error:(NSError **)error ;
/// 使用ecc直接进行加密
/// - Parameters:
///   - data: 待加密的数据
///   - error: 错误信息
- (NSData *)ecc_encrypteData:(NSData *)data error:(NSError **)error ;
/// 使用ecc直接进行解密
/// - Parameters:
///   - data: 加密后的数据
///   - error: 错误信息
- (NSData *)ecc_decryptData:(NSData *)data error:(NSError **)error ;


- (NSData *)decryptData:(NSData *)data withSymmetricKey:(NSData *)symmetricKey ;

@end

NS_ASSUME_NONNULL_END
