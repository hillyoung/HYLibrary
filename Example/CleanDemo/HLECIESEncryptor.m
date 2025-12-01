//
//  HYCustomEncryptor.m
//  CleanDemo
//
//  Created by hb28130 on 12/9/2025.
//  Copyright © 2025 hillyoung. All rights reserved.
//

#import "HLECIESEncryptor.h"
#import <CommonCrypto/CommonCrypto.h>


@implementation HLECIESEncryptor

+ (void)generateECCKeyPair:(SecKeyRef *)privateKeyP publicKey:(SecKeyRef *)publicKeyP {
    NSDictionary *keyAttributes = @{
        (__bridge id)kSecAttrKeyType: (__bridge id)kSecAttrKeyTypeECSECPrimeRandom,
        (__bridge id)kSecAttrKeySizeInBits: @256
    };

    CFErrorRef error = NULL;
    SecKeyRef privateKey = SecKeyCreateRandomKey((__bridge CFDictionaryRef)keyAttributes, &error);
    if (!privateKey) {
        NSLog(@"Failed to generate ECC key pair: %@", error);
        return;
    }

    SecKeyRef publicKey = SecKeyCopyPublicKey(privateKey);
    if (!publicKey) {
        NSLog(@"Failed to get public key");
        CFRelease(privateKey);
        return;
    }
    *privateKeyP = privateKey;
    *publicKeyP = publicKey;
}

+ (SecKeyRef)getPrivateKeyRefFromData:(NSData *)data {
    // 将字符串转换为 NSData
    if (!data) {
        NSLog(@"DER 字符串解码失败");
        return nil;
    }

    // 设置属性字典
    NSMutableDictionary *keyAttributes = [NSMutableDictionary dictionary];
    [keyAttributes setObject:(__bridge id)kSecAttrKeyTypeECSECPrimeRandom forKey:(__bridge id)kSecAttrKeyType];
    [keyAttributes setObject:@(256) forKey:(__bridge id)kSecAttrKeySizeInBits];
    [keyAttributes setObject:(__bridge id)kSecAttrKeyClassPrivate forKey:(__bridge id)kSecAttrKeyClass];

    // 创建 SecKeyRef
    CFErrorRef error = NULL;
    SecKeyRef privateKeyRef = SecKeyCreateWithData((__bridge CFDataRef)data, (__bridge CFDictionaryRef)keyAttributes, &error);
    if (error) {
        NSLog(@"创建 SecKeyRef 失败: %@", (__bridge NSError *)error);
        return nil;
    }

    return privateKeyRef;
}

+ (SecKeyRef)getPublicKeyRefFromData:(NSData *)data {
    // 将字符串转换为 NSData
    if (!data) {
        NSLog(@"DER 字符串解码失败");
        return nil;
    }

    // 设置属性字典
    NSMutableDictionary *keyAttributes = [NSMutableDictionary dictionary];
    [keyAttributes setObject:(__bridge id)kSecAttrKeyTypeECSECPrimeRandom forKey:(__bridge id)kSecAttrKeyType];
    [keyAttributes setObject:@(256) forKey:(__bridge id)kSecAttrKeySizeInBits];
    [keyAttributes setObject:(__bridge id)kSecAttrKeyClassPublic forKey:(__bridge id)kSecAttrKeyClass];

    // 创建 SecKeyRef
    CFErrorRef error = NULL;
    SecKeyRef publicKeyRef = SecKeyCreateWithData((__bridge CFDataRef)data, (__bridge CFDictionaryRef)keyAttributes, &error);
    if (error) {
        NSLog(@"创建 SecKeyRef 失败: %@", (__bridge NSError *)error);
        return nil;
    }
    return publicKeyRef;
}

+ (NSData *)exportKeyAsDER:(SecKeyRef)key {
    CFErrorRef error = NULL;
    CFDataRef externalRepresentation = SecKeyCopyExternalRepresentation(key, &error);
    if (error) {
        NSLog(@"Failed to export key: %@", (__bridge NSError *)error);
        return nil;
    }
    return (__bridge NSData *)externalRepresentation;
}

+ (NSData *)generateSharedSecretWithPrivateKey:(SecKeyRef)privateKey publicKey:(SecKeyRef)publicKey {
    CFErrorRef error = NULL;
    NSDictionary *parmas = @{
        (__bridge id)kSecKeyKeyExchangeParameterRequestedSize: @32,
    };
    NSData *sharedSecret = (__bridge NSData *)SecKeyCopyKeyExchangeResult(privateKey, kSecKeyAlgorithmECDHKeyExchangeStandard, publicKey, (__bridge CFDictionaryRef)parmas, &error);
    if (!sharedSecret) {
        NSLog(@"Failed to generate shared secret: %@", error);
        return nil;
    }
    return sharedSecret;
}

+ (NSData *)kdf2X963FromZ:(NSData *)Z
               derivation:(NSData *)derivation
                   outLen:(size_t)outLen
               useSHA256:(BOOL)useSHA256 {
    if (!Z || outLen == 0) return nil;

    const BOOL sha256 = useSHA256;
    const size_t hLen = sha256 ? CC_SHA256_DIGEST_LENGTH : CC_SHA1_DIGEST_LENGTH;

    NSMutableData *out = [NSMutableData dataWithLength:outLen];
    uint8_t *pOut = (uint8_t *)out.mutableBytes;

    uint32_t counter = 1;
    size_t pos = 0;

    while (pos < outLen) {
        if (sha256) {
            CC_SHA256_CTX ctx;
            CC_SHA256_Init(&ctx);

            // 输入: Z || counter_be || derivation
            CC_SHA256_Update(&ctx, Z.bytes, (CC_LONG)Z.length);

            uint8_t ctr[4] = {
                (uint8_t)((counter >> 24) & 0xFF),
                (uint8_t)((counter >> 16) & 0xFF),
                (uint8_t)((counter >> 8)  & 0xFF),
                (uint8_t)(counter & 0xFF)
            };
            CC_SHA256_Update(&ctx, ctr, 4);

            if (derivation.length > 0) {
                CC_SHA256_Update(&ctx, derivation.bytes, (CC_LONG)derivation.length);
            }

            uint8_t dig[CC_SHA256_DIGEST_LENGTH];
            CC_SHA256_Final(dig, &ctx);

            size_t take = MIN(hLen, outLen - pos);
            memcpy(pOut + pos, dig, take);
            pos += take;
        } else {
            CC_SHA1_CTX ctx;
            CC_SHA1_Init(&ctx);

            // 输入: Z || counter_be || derivation
            CC_SHA1_Update(&ctx, Z.bytes, (CC_LONG)Z.length);

            uint8_t ctr[4] = {
                (uint8_t)((counter >> 24) & 0xFF),
                (uint8_t)((counter >> 16) & 0xFF),
                (uint8_t)((counter >> 8)  & 0xFF),
                (uint8_t)(counter & 0xFF)
            };
            CC_SHA1_Update(&ctx, ctr, 4);

            if (derivation.length > 0) {
                CC_SHA1_Update(&ctx, derivation.bytes, (CC_LONG)derivation.length);
            }

            uint8_t dig[CC_SHA1_DIGEST_LENGTH];
            CC_SHA1_Final(dig, &ctx);

            size_t take = MIN(hLen, outLen - pos);
            memcpy(pOut + pos, dig, take);
            pos += take;
        }
        counter++;
    }
    return out;
}

+ (NSDictionary *)deriveCipherAndMacFromZ:(NSData *)Z
                               derivation:(NSData *)derivation
                            cipherKeyLen:(size_t)cipherKeyLen
                               macKeyLen:(size_t)macKeyLen
                              useSHA256:(BOOL)useSHA256 {
    if (!Z || cipherKeyLen == 0 || macKeyLen == 0) return nil;

    const size_t total = cipherKeyLen + macKeyLen;
    NSData *km = [self kdf2X963FromZ:Z
                          derivation:(derivation ?: [NSData data])
                              outLen:total
                          useSHA256:useSHA256];
    if (!km || km.length < total) return nil;

    NSData *cipherKey = [km subdataWithRange:NSMakeRange(0, cipherKeyLen)];
    NSData *macKey    = [km subdataWithRange:NSMakeRange(cipherKeyLen, macKeyLen)];
    return @{ @"cipherKey": cipherKey, @"macKey": macKey };
}

+ (NSData *)dataFromHexString:(NSString *)hex {
    if (!hex) return nil;
    NSMutableData *data = [NSMutableData dataWithCapacity:(hex.length/2)];
    for (NSUInteger i = 0; i + 1 < hex.length; i += 2) {
        unsigned int byte;
        NSString *pair = [hex substringWithRange:NSMakeRange(i, 2)];
        NSScanner *scanner = [NSScanner scannerWithString:pair];
        [scanner scanHexInt:&byte];
        uint8_t b = (uint8_t)byte;
        [data appendBytes:&b length:1];
    }
    return data;
}

+ (NSString *)hexStringFromData:(NSData *)data {
    if (!data) return nil;
    const unsigned char *bytes = data.bytes;
    NSMutableString *hex = [NSMutableString stringWithCapacity:data.length * 2];
    for (NSUInteger i = 0; i < data.length; i++) {
        [hex appendFormat:@"%02x", bytes[i]];
    }
    return hex;
}


+ (NSData *)hmacSha1:(NSData *)data macKey:(NSData *)macKey {
    if (!data || !macKey) {
        NSLog(@"HMAC-SHA1 参数无效");
        return nil;
    }
    
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1,
           macKey.bytes, macKey.length,
           data.bytes, data.length,
           digest);
    
    return [NSData dataWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
}

+ (NSData *)hmacSha256:(NSData *)data macKey:(NSData *)macKey {
    if (!data || !macKey) {
        NSLog(@"HMAC-SHA256 参数无效");
        return nil;
    }
    
    unsigned char digest[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256,
           macKey.bytes, macKey.length,
           data.bytes, data.length,
           digest);
    
    return [NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
}

+ (BOOL)verifyHmac:(NSData *)data
            macKey:(NSData *)macKey
       receivedMac:(NSData *)receivedMac
        useSha256:(BOOL)useSha256 {
    if (!data || !macKey || !receivedMac) {
        NSLog(@"HMAC 验证参数无效");
        return NO;
    }
    
    // 计算期望的 MAC
    NSData *expectedMac = useSha256 ?
        [self hmacSha256:data macKey:macKey] :
        [self hmacSha1:data macKey:macKey];
    
    if (!expectedMac) {
        NSLog(@"计算期望 MAC 失败");
        return NO;
    }
    
    // 安全比较
    return [self secureCompare:expectedMac with:receivedMac];
}

+ (BOOL)secureCompare:(NSData *)a with:(NSData *)b {
    if (!a || !b) {
        return NO;
    }
    
    if (a.length != b.length) {
        return NO;
    }
    
    // 使用 MessageDigest.isEqual 的等价实现
    // 常量时间比较，防止时序攻击
    const uint8_t *bytesA = (const uint8_t *)a.bytes;
    const uint8_t *bytesB = (const uint8_t *)b.bytes;
    
    uint8_t result = 0;
    for (NSUInteger i = 0; i < a.length; i++) {
        result |= bytesA[i] ^ bytesB[i];
    }
    
    return result == 0;
}
// AES 加密
+ (NSData *)aesEncrypt:(NSData *)plainData key:(NSData *)key {
    size_t bufferSize = plainData.length + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);

    NSData *iv = [NSMutableData dataWithLength:16];
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES, kCCOptionPKCS7Padding,
                                          key.bytes, key.length, iv.bytes,
                                          plainData.bytes, plainData.length,
                                          buffer, bufferSize, &numBytesEncrypted);

    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted freeWhenDone:YES];
    }
    free(buffer);
    return nil;
}

// AES 解密
+ (NSData *)aesDecrypt:(NSData *)data key:(NSData *)key {
    size_t bufferSize = data.length + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);

    size_t numBytesDecrypted = 0;
    
    NSData *iv = [NSMutableData dataWithLength:16];
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES, kCCOptionPKCS7Padding,
                                          key.bytes, key.length, iv.bytes,
                                          data.bytes, data.length,
                                          buffer, bufferSize, &numBytesDecrypted);

    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted freeWhenDone:YES];
    }

    free(buffer);
    return nil;
}

+ (NSData *)eciesEncrypt:(NSData *)plainData publicKeyData:(NSData *)publicKeyData {
    
    NSMutableData *resultData;
    @try {
        SecKeyRef tmpPrivateKey, tmpPublicKey;
        [self generateECCKeyPair:&tmpPrivateKey publicKey:&tmpPublicKey];
        SecKeyRef publicKey = [self getPublicKeyRefFromData:publicKeyData];
        // 共享密钥
        NSData *shareKeyData = [HLECIESEncryptor generateSharedSecretWithPrivateKey:tmpPrivateKey publicKey:publicKey];
        NSDictionary *pair = [HLECIESEncryptor deriveCipherAndMacFromZ:shareKeyData derivation:[NSData data] cipherKeyLen:16 macKeyLen:16 useSHA256:YES];
        NSData *cipherKey = pair[@"cipherKey"];
        NSData *macKey = pair[@"macKey"];
        
        NSData *encodedData = [self aesEncrypt:plainData key:cipherKey];
        // 生成mac
        NSData *hmacKey = [self hmacSha1:encodedData macKey:macKey];

        resultData = [NSMutableData data];
        NSData *tmpPublicKeyData = [self exportKeyAsDER:tmpPublicKey];
        [resultData appendData:tmpPublicKeyData];   // 拼接公钥
        [resultData appendData:encodedData];        // 密文
        [resultData appendData:hmacKey];            // mac
    } @catch (NSException *exception) {
        
    } @finally {
        return resultData;
    }
}

+ (NSData *)eciesDecrypt:(NSData *)data privateKeyData:(NSData *)privateKeyData {
    
    NSInteger publicKeyLength = 65;
    NSUInteger macLength = 20;
    if (data.length < publicKeyLength + macLength) {
        return nil;
    }
    
    // 分离各部分
    NSData *publicKeyData = [data subdataWithRange:NSMakeRange(0, publicKeyLength)];
    NSData *receivedMac = [data subdataWithRange:NSMakeRange(data.length - macLength, macLength)];
    NSData *cipherData = [data subdataWithRange:NSMakeRange(publicKeyLength,
                                                            data.length - publicKeyLength - macLength)];
    
    SecKeyRef privateKey = [self getPrivateKeyRefFromData:privateKeyData];
    SecKeyRef publicKey = [self getPublicKeyRefFromData:publicKeyData];
    // 验证临时公钥格式 (简单检查)
    if (publicKey == nil) {
        return nil;
    }
    NSData *shareKeyData = [HLECIESEncryptor generateSharedSecretWithPrivateKey:privateKey publicKey:publicKey];
    // 共享密钥
    NSDictionary *pair = [HLECIESEncryptor deriveCipherAndMacFromZ:shareKeyData derivation:[NSData data] cipherKeyLen:16 macKeyLen:16 useSHA256:YES];
    NSData *cipherKey = pair[@"cipherKey"];
    NSData *macKey = pair[@"macKey"];

    if ([self verifyHmac:cipherData macKey:macKey receivedMac:receivedMac useSha256:NO]) {
        NSData *decodedData = [HLECIESEncryptor aesDecrypt:cipherData key:cipherKey];
        return decodedData;
    }
    return nil;
}

@end
