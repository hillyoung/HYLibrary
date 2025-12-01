//
//  HLRiskECCEntrptor.m
//  HLDeviceDetecterKit
//
//  Created by hb28130 on 30/6/2025.
//

#import "HLRiskECCEncryptor.h"
#import <Security/Security.h>
#import <CommonCrypto/CommonCrypto.h>
#import <NSString+Encrypt.h>


@interface HLRiskECCEncryptor ()
@property (nonatomic) SecKeyRef privateKey;
@property (nonatomic) SecKeyRef publicKey;
@property (nonatomic, strong) NSData *symmetricKey;     /**< 共享秘钥 */
@end

@implementation HLRiskECCEncryptor


// 将十六进制字符串转换为NSData
NSData *dataFromHexString(NSString *hexString) {
    NSMutableData *data = [NSMutableData dataWithCapacity:hexString.length / 2];
    unsigned char wholeByte;
    char byteChars[3] = {'\0','\0','\0'};
    int i = 0;
    while (i < hexString.length) {
        byteChars[0] = [hexString characterAtIndex:i++];
        byteChars[1] = [hexString characterAtIndex:i++];
        wholeByte = strtol(byteChars, NULL, 16);
        [data appendBytes:&wholeByte length:1];
    }
    return data;
}
// 从SPKI十六进制字符串中提取ECC公钥
SecKeyRef ecPublicKeyFromSPKIHex(NSString *hex) {
//    NSData *data = dataFromHexString(hex);
    NSData *data = [[NSData alloc] initWithBase64EncodedString:hex options:NSDataBase64DecodingIgnoreUnknownCharacters];

    if (!data) {
        NSLog(@"十六进制解析失败");
        return NULL;
    }
    
    CFErrorRef error = NULL;
    NSMutableDictionary *keyAttributes = [NSMutableDictionary dictionary];
    [keyAttributes setObject:(__bridge id)kSecAttrKeyTypeECSECPrimeRandom forKey:(__bridge id)kSecAttrKeyType];
    [keyAttributes setObject:@(256) forKey:(__bridge id)kSecAttrKeySizeInBits];
    [keyAttributes setObject:(__bridge id)kSecAttrKeyClassPublic forKey:(__bridge id)kSecAttrKeyClass];
    SecKeyRef publicKey  = SecKeyCreateWithData((__bridge CFDataRef)data, (__bridge CFDictionaryRef)keyAttributes, &error);
    if (error) {
        NSLog(@"创建公钥失败:");
        return NULL;
    }
    
    return publicKey;
}

// 从PKCS8十六进制字符串中提取ECC私钥
SecKeyRef ecPrivateKeyFromPKCS8Hex(NSString *hex) {
    NSData *data = dataFromHexString(hex);
    if (!data) {
        NSLog(@"十六进制解析失败");
        return NULL;
    }
    
    CFErrorRef error = NULL;
    NSMutableDictionary *keyAttributes = [NSMutableDictionary dictionary];
    [keyAttributes setObject:(__bridge id)kSecAttrKeyTypeECSECPrimeRandom forKey:(__bridge id)kSecAttrKeyType];
    [keyAttributes setObject:@(256) forKey:(__bridge id)kSecAttrKeySizeInBits];
    [keyAttributes setObject:(__bridge id)kSecAttrKeyClassPrivate forKey:(__bridge id)kSecAttrKeyClass];
    SecKeyRef privateKey = SecKeyCreateWithData((__bridge CFDataRef)data, (__bridge CFDictionaryRef)keyAttributes, &error);
    if (error) {
        NSLog(@"创建私钥失败: ");
        return NULL;
    }
    
    return privateKey;
}

+ (instancetype)shareEncryptor {
    static dispatch_once_t onceToken;
    static HLRiskECCEncryptor *encryptor;
    dispatch_once(&onceToken, ^{
        encryptor = [HLRiskECCEncryptor new];
    });
    return encryptor;
}

- (instancetype)init {
    if (self = [super init]) {
        SecKeyRef privateKey = [self getPrivateKeyRefFromDERString:@"BKmkeVz2AEXr7KQq88Eaxuvu5o6CmSlxEfD4U8zFZpAx6SsF8cgYyz9trNrd7BSCnMPcz7Re2xhebQ2BrkJa5We57474rcD0QDdFNVRzbtB2Db4z5FTPfBUVAQ2pm3p3wg=="];
        SecKeyRef publicKey = [self getPublicKeyRefFromDERString:@"BKmkeVz2AEXr7KQq88Eaxuvu5o6CmSlxEfD4U8zFZpAx6SsF8cgYyz9trNrd7BSCnMPcz7Re2xhebQ2BrkJa5Wc="];
        if (privateKey && privateKey) {
            _symmetricKey = [self generateSharedSecretWithPrivateKey:privateKey publicKey:publicKey];
//            CFRelease(privateKey);
//            CFRelease(publicKey);
        }
//        else {
            [self generateECCKeyPair];
//        }
//        self.privateKey = [self getPrivateKeyRefFromHexString:@"308187020100301306072a8648ce3d020106082a8648ce3d030107046d306b02010104201a2f096620b52ac660ffd838d2daa874584319cb4a8b01943d2c2cb32a83b6c0a14403420004070b994a85037db3e8f7edac264f54b3ac150d13a4d07eae7b541422548590e991fd419136c08b41912dd7365ef26b98bd0c947a0ae086f6a6151cc3a9977e26" error:nil];
        self.publicKey = [self getPublicKeyRefFromDERString:@"BCgGQ6hSselTfJpciEmNShwy+70NYbcR47VtTnNSOU+8jr7bu9iJcDxq2XoRJt1gmw5AnE+hYevbWEoYUfsu+DY="];
        self.privateKey = [self getPrivateKeyRefFromDERString:@"BCgGQ6hSselTfJpciEmNShwy+70NYbcR47VtTnNSOU+8jr7bu9iJcDxq2XoRJt1gmw5AnE+hYevbWEoYUfsu+DYkdudYhhobbn/2LMXKpkIIFbSzwaTVFqshzjiYzBsZHA=="];
        NSData *encodedData = [[NSData alloc] initWithBase64EncodedString:@"BGw6CUmi4dxV5iYCBOLBoDbg3eIu3h2gKVuj8nxmf7Gedt2Z/sihsYAnv+7YRfiWNNwEO1KchLiuK+Q652otFX/+zbRvyDuPGiQ3DKiJHTLI77wABJxuRWjEinww8z05qIPvHu7uPsr8r6BgwW6kRQtZ2MxFKUtwfAD5gqpYz0rMnILWy6kqzIYdvgb+ZWcYBVhrL4mLjTt91wIhZQ2auLE1KPz/ba3C" options:NSDataBase64DecodingIgnoreUnknownCharacters];
//        NSData *data = [self test1_decryptData:encodedData withPrivateKey:self.privateKey];
//        data = [self ecc_decryptData:encodedData error:nil];
//        NSString *decodeStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        BOOL isSupport = SecKeyIsAlgorithmSupported(self.privateKey, kSecKeyOperationTypeDecrypt, kSecKeyAlgorithmECIESEncryptionCofactorX963SHA256AESGCM);
//        [self exampleUsage];
        NSLog(@"");
//        self.privateKey = ecPrivateKeyFromPKCS8Hex(@"308193020100301306072a8648ce3d020106082a8648ce3d0301070479307702010104202476e758861a1b6e7ff62cc5caa6420815b4b3c1a4d516ab21ce3898cc1b191ca00a06082a8648ce3d030107a14403420004280643a852b1e9537c9a5c88498d4a1c32fbbd0d61b711e3b56d4e7352394fbc8ebedbbbd889703c6ad97a1126dd609b0e409c4fa161ebdb584a1851fb2ef836");
//        self.publicKey = ecPublicKeyFromSPKIHex(@"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA13228e0c118a701a9e18a3a9a565d84168ce2f5b119457ece367764a3fb9ecd115d0f9568b15e6062d72a9455699b09bb530908d2e310e9568cccc195c6553ba");
    }
    return self;
}

- (SecKeyRef)getPrivateKeyRefFromDERString:(NSString *)derString {
    // 将字符串转换为 NSData
    NSData *derData = [[NSData alloc] initWithBase64EncodedString:derString options:NSDataBase64DecodingIgnoreUnknownCharacters];
    if (!derData) {
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
    SecKeyRef privateKeyRef = SecKeyCreateWithData((__bridge CFDataRef)derData, (__bridge CFDictionaryRef)keyAttributes, &error);
    if (error) {
        NSLog(@"创建 SecKeyRef 失败: %@", (__bridge NSError *)error);
        return nil;
    }

    return privateKeyRef;
}

- (SecKeyRef)getPublicKeyRefFromDERString:(NSString *)derString {
    // 将字符串转换为 NSData
    NSData *derData = [[NSData alloc] initWithBase64EncodedString:derString options:0];
    if (!derData) {
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
    SecKeyRef publicKeyRef = SecKeyCreateWithData((__bridge CFDataRef)derData, (__bridge CFDictionaryRef)keyAttributes, &error);
    if (error) {
        NSLog(@"创建 SecKeyRef 失败: %@", (__bridge NSError *)error);
        return nil;
    }
    return publicKeyRef;
}

- (SecKeyRef)getPublicKeyRefFromHexString:(NSString *)hexString {
    // 将字符串转换为 NSData
    if ([hexString hasPrefix:@"3059301306072a8648ce3d020106082a8648ce3d030107034200"]) {
        // 将X.509转换成iOS能识别X9.63
        hexString = [hexString stringByReplacingOccurrencesOfString:@"3059301306072a8648ce3d020106082a8648ce3d030107034200" withString:@""];
    }
    NSData *derData = [self hexStringToDataHighPerformance:hexString];
    if (!derData) {
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
    SecKeyRef publicKeyRef = SecKeyCreateWithData((__bridge CFDataRef)derData, (__bridge CFDictionaryRef)keyAttributes, &error);
    if (error) {
        NSLog(@"创建 SecKeyRef 失败: %@", (__bridge NSError *)error);
        return nil;
    }
    return publicKeyRef;
}

- (SecKeyRef)getPrivateKeyRefFromHexString:(NSString *)hexString error:(NSError **)error {
    NSData *keyData = [self hexStringToDataHighPerformance:hexString];
        if (!keyData) {
            if (error) *error = [NSError errorWithDomain:@"HYEccEncryptor" code:-1 userInfo:@{NSLocalizedDescriptionKey: @"私钥十六进制解析失败"}];
            return NULL;
        }
        CFErrorRef cfErr = NULL;
        NSDictionary *options = @{(__bridge id)kSecAttrKeyType: (__bridge id)kSecAttrKeyTypeECSECPrimeRandom,
                                   (__bridge id)kSecAttrKeyClass: (__bridge id)kSecAttrKeyClassPrivate,
//                                   (__bridge id)kSecAttrKeySizeInBits: @256,
//                                  (__bridge  id)kSecAttrLabel: @"MyECCPrivateKey"
        };
        SecKeyRef pri = SecKeyCreateWithData((__bridge CFDataRef)keyData,
                                             (__bridge CFDictionaryRef)options,
                                             &cfErr);
    if (cfErr) {
        return nil;
        }
        return pri;
}

// 加载PKCS#8格式的私钥
- (SecKeyRef)loadPrivateKeyWithPKCS8Data:(NSData *)pkcs8Data password:(NSString *)password {
    CFDataRef pkcs8DataRef = (__bridge CFDataRef)pkcs8Data;
    CFStringRef passwordRef = (__bridge CFStringRef)password;
    CFDictionaryRef options = (__bridge CFDictionaryRef)([NSDictionary dictionaryWithObjectsAndKeys:CFBridgingRelease(passwordRef), (id)kSecImportExportPassphrase, nil]);
    CFArrayRef items = NULL;
    OSStatus status = SecPKCS12Import(pkcs8DataRef, options, &items);
    if (status != errSecSuccess) {
        NSLog(@"Failed to import PKCS#12 data with status: %ld", (long)status);
        return nil;
    }
    CFDictionaryRef identityDict = CFArrayGetValueAtIndex(items, 0);
    SecIdentityRef identityRef = (SecIdentityRef)CFDictionaryGetValue(identityDict, kSecImportItemIdentity);
    SecKeyRef privateKeyRef = NULL;
    status = SecIdentityCopyPrivateKey(identityRef, &privateKeyRef);
    if (status != errSecSuccess) {
        NSLog(@"Failed to get private key with status: %ld", (long)status);
        CFRelease(items);
        return nil;
    }
    CFRelease(items);
    return privateKeyRef;
}

// ECC解密
- (NSData *)decryptData:(NSData *)data withPrivateKey:(SecKeyRef)privateKey {
    size_t outputLength = [data length];
    NSMutableData *decryptedData = [NSMutableData dataWithLength:outputLength];
    OSStatus status = SecKeyDecrypt(privateKey, kSecPaddingNone, [data bytes], [data length], [decryptedData mutableBytes], &outputLength);
    if (status != errSecSuccess) {
        NSLog(@"Decryption failed with status: %ld", (long)status);
        return nil;
    }
    [decryptedData setLength:outputLength];
    return decryptedData;
}


- (void)generateECCKeyPair {
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
#if DEBUG
    NSData *privateData = [self exportKeyAsDER:privateKey];

    NSString *privateStr = [privateData base64EncodedStringWithOptions:0];

    NSData *publicData = [self exportKeyAsDER:publicKey];
//    publicData = [self HYCompressUncompressedECPointP256:publicData error:nil];
    NSString *hexStr = [self dataToHexStringCoreFoundation:publicData];
    NSString *publicStr = [publicData base64EncodedStringWithOptions:0];
#endif
    self.symmetricKey = [self generateSharedSecretWithPrivateKey:privateKey publicKey:publicKey];
}

- (NSData *)publicKeyToX509:(SecKeyRef)publicKey {
    CFErrorRef error = NULL;
    NSData *derData = (__bridge_transfer NSData *)SecKeyCopyExternalRepresentation(publicKey, &error);
    if (!derData) {
        NSLog(@"Error copying public key representation: %@", error);
        return nil;
    }

    const unsigned char x509Header[] = {
        0x30, 0x82, 0x01, 0x22,
        0x30, 0x0D,
        0x06, 0x09,
        0x2A, 0x86, 0x48, 0x86, 0xF7, 0x0D, 0x01, 0x01, 0x01,
        0x05, 0x00,
        0x03, 0x82, 0x01, 0x0F,
        0x00
    };
    NSMutableData *x509Data = [NSMutableData dataWithBytes:x509Header length:sizeof(x509Header)];
    [x509Data appendData:derData];
    return x509Data;
}

typedef NS_ENUM(NSUInteger, HYECPointFormat) {
    HYECPointFormatUncompressed = 0x04,
    HYECPointFormatCompressedEvenY = 0x02,
    HYECPointFormatCompressedOddY  = 0x03,
};

- (NSData *)HYCompressUncompressedECPointP256:(NSData *)uncompressedPoint error:(NSError **)error {
    if (uncompressedPoint.length != 65) {
            if (error) {
                *error = [NSError errorWithDomain:@"HYEC"
                                             code:-1
                                         userInfo:@{NSLocalizedDescriptionKey: @"需要 65 字节未压缩点(0x04 + 32B X + 32B Y)"}];
            }
            return nil;
        }
        const uint8_t *bytes = (const uint8_t *)uncompressedPoint.bytes;
        if (bytes[0] != HYECPointFormatUncompressed) {
            if (error) {
                *error = [NSError errorWithDomain:@"HYEC"
                                             code:-2
                                         userInfo:@{NSLocalizedDescriptionKey: @"首字节必须为 0x04（未压缩点）"}];
            }
            return nil;
        }
        // X: [1,33)  Y: [33,65)
        NSData *x = [uncompressedPoint subdataWithRange:NSMakeRange(1, 32)];
        uint8_t yLast = bytes[64];
        uint8_t prefix = (yLast & 0x01) ? HYECPointFormatCompressedOddY : HYECPointFormatCompressedEvenY;

        NSMutableData *compressed = [NSMutableData dataWithCapacity:33];
        [compressed appendBytes:&prefix length:1];
        [compressed appendData:x];
        return compressed;
}

- (NSData *)generateSharedSecretWithPrivateKey:(SecKeyRef)privateKey publicKey:(SecKeyRef)publicKey {
    CFErrorRef error = NULL;
    NSDictionary *parmas = @{
        (__bridge id)kSecKeyKeyExchangeParameterRequestedSize: @32,
    };
    NSData *sharedSecret = (__bridge NSData *)SecKeyCopyKeyExchangeResult(privateKey, kSecKeyAlgorithmECDHKeyExchangeCofactorX963SHA256, publicKey, (__bridge CFDictionaryRef)parmas, &error);
    if (!sharedSecret) {
        NSLog(@"Failed to generate shared secret: %@", error);
        return nil;
    }
    NSString *sharedSecretStr = [sharedSecret base64EncodedStringWithOptions:0];

    return sharedSecret;
}
/// 导出公钥或私钥
/// - Parameter key: 待导出的公钥、私钥
- (NSData *)exportKeyAsDER:(SecKeyRef)key {
    CFErrorRef error = NULL;
    CFDataRef externalRepresentation = SecKeyCopyExternalRepresentation(key, &error);
    if (error) {
        NSLog(@"Failed to export key: %@", (__bridge NSError *)error);
        return nil;
    }
    return (__bridge NSData *)externalRepresentation;
}
#pragma mark 共享秘钥加解密
/// 使用共享秘钥加密数据
/// - Parameters:
///   - data: 待加密的数据
///   - symmetricKey: 共享秘钥
- (NSData *)encryptData:(NSData *)data withSymmetricKey:(NSData *)symmetricKey {
    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    NSMutableData *buffer = [NSMutableData dataWithLength:bufferSize];
    size_t numBytesEncrypted = 0;

    CCCryptorStatus status = CCCrypt(kCCEncrypt,
                                     kCCAlgorithmAES,
                                     kCCOptionPKCS7Padding,
                                     symmetricKey.bytes,
                                     symmetricKey.length,
                                     NULL,
                                     data.bytes,
                                     data.length,
                                     buffer.mutableBytes,
                                     buffer.length,
                                     &numBytesEncrypted);
    if (status != kCCSuccess) {
        NSLog(@"Encryption failed with status: %ld", (long)status);
        return nil;
    }
    return [NSData dataWithBytes:buffer.mutableBytes length:numBytesEncrypted];
}
/// 通过共享秘钥解密数据
/// - Parameters:
///   - data: 待解密的数据
///   - symmetricKey: 共享秘钥
- (NSData *)decryptData:(NSData *)data withSymmetricKey:(NSData *)symmetricKey {
    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    NSMutableData *buffer = [NSMutableData dataWithLength:bufferSize];
    size_t numBytesDecrypted = 0;

    CCCryptorStatus status = CCCrypt(kCCDecrypt,
                                     kCCAlgorithmAES,
                                     kCCOptionPKCS7Padding,
                                     symmetricKey.bytes,
                                     symmetricKey.length,
                                     NULL,
                                     data.bytes,
                                     data.length,
                                     buffer.mutableBytes,
                                     buffer.length,
                                     &numBytesDecrypted);
    if (status != kCCSuccess) {
        NSLog(@"Decryption failed with status: %ld", (long)status);
        return nil;
    }
    return [NSData dataWithBytes:buffer.mutableBytes length:numBytesDecrypted];
}

#pragma mark 公钥、私钥加解密

- (NSData *)encryptData:(NSData *)data withPublicKey:(NSData *)publicKeyData {
    CFErrorRef error = NULL;
    SecKeyRef publicKey = SecKeyCreateWithData((__bridge CFDataRef)publicKeyData, (__bridge CFDictionaryRef)@{
        (__bridge id)kSecAttrKeyType: (__bridge id)kSecAttrKeyTypeECSECPrimeRandom
    }, &error);
    if (!publicKey) {
        NSLog(@"Failed to create public key: %@", error);
        return nil;
    }

    NSData *encryptedData = (__bridge NSData *)SecKeyCreateEncryptedData(publicKey, kSecPaddingPKCS1, (__bridge CFDataRef)data, &error);
    if (!encryptedData) {
        NSLog(@"Failed to encrypt data: %@", error);
        return nil;
    }

    CFRelease(publicKey);
    return encryptedData;
}


- (NSData *)encrypteData:(NSData *)data error:(NSError *__autoreleasing  _Nullable *)error {
    if (!self.symmetricKey) {
        *error = [NSError errorWithDomain:@"com.hellobike.risk.encrypt" code:-1 userInfo:@{
            NSLocalizedDescriptionKey: @"没有共享公钥"
        }];
        return nil;
    }
    NSData *encryptedData = [self encryptData:data withSymmetricKey:self.symmetricKey];
    if (!encryptedData) {
        *error = [NSError errorWithDomain:@"com.hellobike.risk.encrypt" code:-1 userInfo:@{
            NSLocalizedDescriptionKey: @"加密失败"
        }];
        return nil;
    }
    return encryptedData;
}

- (NSData *)decryptData:(NSData *)data error:(NSError *__autoreleasing  _Nullable *)error {
    if (!self.symmetricKey) {
        *error = [NSError errorWithDomain:@"com.hellobike.risk.encrypt" code:-1 userInfo:@{
            NSLocalizedDescriptionKey: @"没有共享公钥"
        }];
        return nil;
    }
    NSData *decodedData = [self decryptData:data withSymmetricKey:self.symmetricKey];
    if (!decodedData) {
        *error = [NSError errorWithDomain:@"com.hellobike.risk.encrypt" code:-1 userInfo:@{
            NSLocalizedDescriptionKey: @"解密失败"
        }];
        return nil;
    }
    return decodedData;
}

- (NSData *)ecc_encrypteData:(NSData *)data error:(NSError *__autoreleasing  _Nullable *)error {
    if (!self.publicKey || !data) {
        NSLog(@"参数不能为空");
        return nil;
    }
    
    // 2. 使用ECIES加密（对应Cipher.getInstance(ECC_TRANSFORMATION, PROVIDER)）
    CFErrorRef cfError = NULL;
    NSData *encryptedData = (__bridge NSData *)SecKeyCreateEncryptedData(self.publicKey,
                                                                         kSecKeyAlgorithmECIESEncryptionStandardX963SHA1AESGCM,  // 对应ECIES
                                                                         (__bridge CFDataRef)data,
        &cfError
    );
    // 3. 错误处理
    if (!encryptedData) {
        NSLog(@"ECIES加密失败: %@", error);
        CFRelease(error);
        return nil;
    }
    
    return encryptedData;
//    if (!self.publicKey || !data) {
//        NSLog(@"公钥或数据为空");
//        return nil;
//    }
//    
//    // 获取密钥块大小
//    size_t blockSize = SecKeyGetBlockSize(self.publicKey);
//    // 准备输出缓冲区
//    uint8_t *encryptedData = malloc(blockSize);
//    size_t encryptedDataLength = blockSize;
//    // 执行加密
//    OSStatus status = SecKeyEncrypt(self.publicKey,
//                                   kSecPaddingPKCS1,  // 使用PKCS1填充
//                                   [data bytes],
//                                   [data length],
//                                   encryptedData,
//                                   &encryptedDataLength);
//    
//    CFErrorRef cfError = NULL;
//    NSData *encryptedData11 = (__bridge NSData *)SecKeyCreateEncryptedData(
//        self.publicKey,
//        kSecKeyAlgorithmECIESEncryptionStandardX963SHA1AESGCM,  // ECIES算法
//        (__bridge CFDataRef)data,
//        &cfError
//    );
//    
//    if (status == errSecSuccess) {
//        NSData *result = [NSData dataWithBytes:encryptedData length:encryptedDataLength];
//        free(encryptedData);
//        return result;
//    } else {
//        NSLog(@"加密失败，错误码: %ld", (long)status);
//        free(encryptedData);
//        return nil;
//    }
}

- (NSData *)ecc_decryptData:(NSData *)data error:(NSError *__autoreleasing  _Nullable *)error {
    if (!self.privateKey || !data) {
        NSLog(@"私钥或加密数据为空");
        return nil;
    }
    
    CFErrorRef cfError = NULL;
    NSData *decodedData = (__bridge NSData *)SecKeyCreateDecryptedData(self.privateKey, kSecKeyAlgorithmECIESEncryptionStandardX963SHA1AESGCM, (__bridge  CFDataRef)data, &cfError);
//
//    
//    size_t blockSize = SecKeyGetBlockSize(self.privateKey);
//    NSMutableData *buffer = [NSMutableData dataWithLength:blockSize];
//    size_t bufferSize = blockSize;
//    
//    OSStatus status = SecKeyDecrypt(self.privateKey,
//                                    kSecPaddingPKCS1SHA256,  // 使用PKCS1填充
//                                    [data bytes],
//                                    [data length],
//                                   [buffer mutableBytes],
//                                   &bufferSize);
//
    return decodedData;;
//    if (status == errSecSuccess) {
//        return [NSData dataWithBytes:[buffer bytes] length:bufferSize];
//    } else {
//        NSLog(@"解密失败，错误码: %ld", (long)status);
//        return nil;
//    }
}

// ECIES 解密：用私钥 + 对端临时公钥 → ECDH → AES-GCM 解密
- (NSData *)test1_encryptData:(NSData *)data withPublicKey:(SecKeyRef)publicKey {
    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    uint8_t *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;

    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES, kCCOptionPKCS7Padding,
                                          [self getAESKeyFromPublicKey:publicKey].bytes, kCCKeySizeAES256,
                                          NULL, [data bytes], [data length],
                                          buffer, bufferSize, &numBytesEncrypted);

    if (cryptStatus == kCCSuccess) {
        NSData *encryptedData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted freeWhenDone:YES];
        return encryptedData;
    } else {
        free(buffer);
        NSLog(@"Encryption failed with status: %ld", (long)cryptStatus);
        return nil;
    }
}

- (NSData *)getAESKeyFromPublicKey:(SecKeyRef)publicKey {
    // Derive AES key from ECC public key (simplified for example)
    // In practice, you should use a proper key derivation function (KDF)
    NSData *publicKeyData = (__bridge NSData *)SecKeyCopyExternalRepresentation(publicKey, NULL);
    NSData *aesKey = [publicKeyData subdataWithRange:NSMakeRange(0, kCCKeySizeAES256)];
    return aesKey;
}


- (NSData *)test1_decryptData:(NSData *)encryptedData withPrivateKey:(SecKeyRef)privateKey {
    size_t bufferSize = [encryptedData length];
    uint8_t *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    
    NSUInteger keyLength = 65;
    NSData *keyData = [encryptedData subdataWithRange:NSMakeRange(0, keyLength)];
    NSData *contentData = [encryptedData subdataWithRange:NSMakeRange(keyLength, encryptedData.length - keyLength)];
    
    // 设置属性字典
    NSMutableDictionary *keyAttributes = [NSMutableDictionary dictionary];
    [keyAttributes setObject:(__bridge id)kSecAttrKeyTypeECSECPrimeRandom forKey:(__bridge id)kSecAttrKeyType];
    [keyAttributes setObject:@(256) forKey:(__bridge id)kSecAttrKeySizeInBits];
    [keyAttributes setObject:(__bridge id)kSecAttrKeyClassPublic forKey:(__bridge id)kSecAttrKeyClass];

    // 创建 SecKeyRef
    CFErrorRef error = NULL;
    SecKeyRef publicKeyRef = SecKeyCreateWithData((__bridge CFDataRef)keyData, (__bridge CFDictionaryRef)keyAttributes, &error);
    NSData *shareKey = [self generateSharedSecretWithPrivateKey:privateKey publicKey:publicKeyRef];
    
//    BOOL isSupport = SecKeyIsAlgorithmSupported(publicKeyRef, kSecKeyOperationTypeDecrypt, kSecKeyAlgorithmECIESEncryptionCofactorX963SHA256AESGCM);

    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES, kCCOptionPKCS7Padding,
                                          shareKey.bytes, shareKey.length,
                                          NULL, contentData.bytes, contentData.length,
                                          buffer, bufferSize, &numBytesDecrypted);

    if (cryptStatus == kCCSuccess) {
        NSData *decryptedData = [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted freeWhenDone:YES];
        return decryptedData;
    } else {
        free(buffer);
        NSLog(@"Decryption failed with status: %ld", (long)cryptStatus);
        return nil;
    }
}

- (NSData *)getAESKeyFromPrivateKey:(SecKeyRef)privateKey {
    // Derive AES key from ECC private key (simplified for example)
    // In practice, you should use a proper key derivation function (KDF)
    NSData *privateKeyData = (__bridge NSData *)SecKeyCopyExternalRepresentation(privateKey, NULL);
    NSData *aesKey = [privateKeyData subdataWithRange:NSMakeRange(0, kCCKeySizeAES256)];
    return aesKey;
}


- (NSString *)dataToHexStringCoreFoundation:(NSData *)data {
    NSUInteger dataLength = [data length];
    NSMutableString *hexString = [[NSMutableString alloc] initWithCapacity:dataLength * 2];
    // 遍历数据并将每个字节转换为十六进制字符串
    const unsigned char *dataBuffer = [data bytes];
    for (NSUInteger i = 0; i < dataLength; i++) {
        [hexString appendFormat:@"%02x", dataBuffer[i]];
    }
    return hexString;
    
//    if (!data || data.length == 0) {
//        return @"";
//    }
//    
//    const uint8_t *bytes = (const uint8_t *)data.bytes;
//    NSUInteger length = data.length;
//    
//    CFStringRef hexString = CFStringCreateWithBytes(
//        kCFAllocatorDefault,
//        bytes,
//        length,
//        kCFStringEncodingUTF8,
//        false
//    );
//    
//    // 这里需要手动转换，因为CFStringCreateWithBytes不是直接转十六进制
//    // 实际实现中还是推荐使用上面的方法
//    
//    if (hexString) {
//        NSString *result = (__bridge NSString *)hexString;
//        CFRelease(hexString);
//        return result;
//    }
//    
//    return @"";
}

//// 十六进制字符串转NSData
//- (NSData *)hexStringToData:(NSString *)hexString {
//    // 移除可能的空格和换行符
//    NSString *cleanHex = [[hexString stringByReplacingOccurrencesOfString:@" " withString:@""]
//                         stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//    
//    // 确保长度为偶数
//    if (cleanHex.length % 2 != 0) {
//        cleanHex = [@"0" stringByAppendingString:cleanHex];
//    }
//    
//    NSMutableData *data = [NSMutableData data];
//    for (NSUInteger i = 0; i < cleanHex.length; i += 2) {
//        NSString *hexByte = [cleanHex substringWithRange:NSMakeRange(i, 2)];
//        NSScanner *scanner = [NSScanner scannerWithString:hexByte];
//        unsigned int byteValue;
//        if ([scanner scanHexInt:&byteValue]) {
//            uint8_t byte = (uint8_t)byteValue;
//            [data appendBytes:&byte length:1];
//        } else {
//            NSLog(@"无效的十六进制字符: %@", hexByte);
//            return nil;
//        }
//    }
//    return data;
//}

- (NSData *)hexStringToDataHighPerformance:(NSString *)hexString {
    if (!hexString || hexString.length == 0) {
        return nil;
    }
    
    // 清理字符串
    NSString *cleanHex = [self cleanHexString:hexString];
    if (!cleanHex) {
        return nil;
    }
    
    NSUInteger length = cleanHex.length / 2;
    uint8_t *bytes = malloc(length);
    if (!bytes) {
        return nil;
    }
    
    const char *hexChars = [cleanHex UTF8String];
    for (NSUInteger i = 0; i < length; i++) {
        char high = hexChars[i * 2];
        char low = hexChars[i * 2 + 1];
        
        uint8_t byte = 0;
        
        // 转换高位
        if (high >= '0' && high <= '9') {
            byte |= (high - '0') << 4;
        } else if (high >= 'A' && high <= 'F') {
            byte |= (high - 'A' + 10) << 4;
        } else if (high >= 'a' && high <= 'f') {
            byte |= (high - 'a' + 10) << 4;
        } else {
            free(bytes);
            return nil;
        }
        
        // 转换低位
        if (low >= '0' && low <= '9') {
            byte |= (low - '0');
        } else if (low >= 'A' && low <= 'F') {
            byte |= (low - 'A' + 10);
        } else if (low >= 'a' && low <= 'f') {
            byte |= (low - 'a' + 10);
        } else {
            free(bytes);
            return nil;
        }
        
        bytes[i] = byte;
    }
    
    NSData *data = [NSData dataWithBytesNoCopy:bytes length:length];
    return data;
}

- (NSString *)cleanHexString:(NSString *)hexString {
    // 移除所有可能的分隔符
    NSCharacterSet *separators = [NSCharacterSet characterSetWithCharactersInString:@" \n\r\t-:"];
    NSString *cleanHex = [[hexString componentsSeparatedByCharactersInSet:separators]
                         componentsJoinedByString:@""];
    
    // 确保长度为偶数
    if (cleanHex.length % 2 != 0) {
        cleanHex = [@"0" stringByAppendingString:cleanHex];
    }
    
    return cleanHex;
}

static NSData * _Nullable HYDataFromHexString(NSString *hex) {
    if (hex.length == 0) return [NSData data];
    NSMutableData *data = [NSMutableData dataWithCapacity:hex.length/2];
    unsigned char whole_byte;
    char byte_chars[3] = {0, 0, 0};
    for (NSUInteger i = 0; i < hex.length/2; i++) {
        byte_chars[0] = [hex characterAtIndex:i*2];
        byte_chars[1] = [hex characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    return data;
}

+ (nullable SecKeyRef)publicKeyFromHex:(NSString *)publicKeyHex error:(NSError **)error {
    NSData *keyData = HYDataFromHexString(publicKeyHex);
    if (!keyData) {
        if (error) *error = [NSError errorWithDomain:@"HYEccEncryptor" code:-1 userInfo:@{NSLocalizedDescriptionKey: @"公钥十六进制解析失败"}];
        return NULL;
    }
    CFErrorRef cfErr = NULL;
    // 尝试以 X.509 (SPKI) 导入
    NSDictionary *options = @{(__bridge id)kSecAttrKeyType: (__bridge id)kSecAttrKeyTypeECSECPrimeRandom,
                               (__bridge id)kSecAttrKeyClass: (__bridge id)kSecAttrKeyClassPublic,
                               (__bridge id)kSecAttrKeySizeInBits: @256};
    SecKeyRef pub = SecKeyCreateWithData((__bridge CFDataRef)keyData,
                                         (__bridge CFDictionaryRef)options,
                                         &cfErr);
    if (!pub) {
        if (error) *error = CFBridgingRelease(cfErr);
        return NULL;
    }
    return pub;
}

- (SecKeyRef)extractPublicKeyFromX509Hex:(NSString *)hexString {
    NSData *certificateData = HYDataFromHexString(hexString);
    SecCertificateRef certificate = SecCertificateCreateWithData(NULL, (__bridge CFDataRef)certificateData);
    if (!certificate) {
        NSLog(@"Failed to create certificate");
        return nil;
    }
    
    SecKeyRef publicKey = SecCertificateCopyKey(certificate);
    CFRelease(certificate);
    if (!publicKey) {
        NSLog(@"Failed to extract public key");
        return nil;
    }
    
    CFErrorRef error = NULL;
    NSData *publicKeyData = (__bridge_transfer NSData *)SecKeyCopyExternalRepresentation(publicKey, &error);
    CFRelease(publicKey);
    if (!publicKeyData) {
        NSLog(@"Failed to convert public key to X9.63 format");
        return nil;
    }
    
    return publicKey;

}

- (void)exampleUsage {
    // Generate ECC key pair
    [self generateECCKeyPair];

    // Load public and private keys from Keychain
    SecKeyRef publicKey = self.publicKey;
    SecKeyRef privateKey = self.privateKey;

    // Data to encrypt
    NSString *dataToEncrypt = @"{\n    \"userId\": \"10086\",\n    \"userName\": \"KotlinTest\",\n    \"data\": \"敏感信息\"\n}";
    NSData *data = [dataToEncrypt dataUsingEncoding:NSUTF8StringEncoding];

    // Encrypt data
    NSData *encryptedData = [self encryptData1:data withPublicKey:publicKey];
    NSLog(@"Encrypted data: %@", encryptedData);

    // Decrypt data
    NSData *decryptedData = [self decryptData1:encryptedData withPrivateKey:privateKey];
    NSLog(@"Decrypted data: %@", [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding]);
}

- (NSData *)encryptData1:(NSData *)data withPublicKey:(SecKeyRef)publicKey {
    SecKeyAlgorithm algorithm = kSecKeyAlgorithmECIESEncryptionCofactorVariableIVX963SHA256AESGCM;
    if (!SecKeyIsAlgorithmSupported(publicKey, kSecKeyOperationTypeEncrypt, algorithm)) {
        NSLog(@"Algorithm not supported");
        return nil;
    }

    CFErrorRef error;
    NSData *encryptedData = (__bridge_transfer NSData *)SecKeyCreateEncryptedData(publicKey, algorithm, data.bytes, &error);
    if (!encryptedData) {
        NSLog(@"Encryption failed: %@");
        return nil;
    }
    return encryptedData;
}

- (NSData *)decryptData1:(NSData *)encryptedData withPrivateKey:(SecKeyRef)privateKey {
    SecKeyAlgorithm algorithm = kSecKeyAlgorithmECIESEncryptionCofactorVariableIVX963SHA256AESGCM;
    if (!SecKeyIsAlgorithmSupported(privateKey, kSecKeyOperationTypeDecrypt, algorithm)) {
        NSLog(@"Algorithm not supported");
        return nil;
    }

    CFErrorRef error;
    NSData *decryptedData = (__bridge_transfer NSData *)SecKeyCreateDecryptedData(privateKey, algorithm, encryptedData.bytes, &error);
    if (!decryptedData) {
        NSLog(@"Decryption failed: %@");
        return nil;
    }
    return decryptedData;
}

@end
