//
//  NSString+Encrypt.m
//  MDPMS
//
//  Created by luculent on 16/6/23.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "NSString+Encrypt.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>


@implementation NSString (Encrypt)

- (NSString*)md5String {
    const char *ptr = [self UTF8String];
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(ptr, (int)strlen(ptr), md5Buffer);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
}

- (NSString *)stringFromISOLatin1 {
    return [self stringFromEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISOLatin1)];
}

- (NSString *)stringFromEncoding:(NSStringEncoding)encoding {
    NSLog(@"value->%s", [self cStringUsingEncoding:encoding]);
    return [NSString stringWithCString:[self cStringUsingEncoding:encoding] encoding:NSUTF8StringEncoding];
}

- (NSArray *)getBase100Charset {
    static NSArray *_base100Charset;
    if (!_base100Charset) {
        _base100Charset = @[
            @"😀", @"😁", @"🤣", @"😂", @"😄", @"😅", @"😆", @"😇", @"😉", @"😊",
            @"🙂", @"🙃", @"☺️", @"😋", @"😌", @"😍", @"😘", @"😙", @"😜", @"😝",
            @"🤑", @"🤓", @"😎", @"🤗", @"🤡", @"🤠", @"😏", @"😶", @"😑", @"😒",
            @"🙄", @"🤔", @"😳", @"😞", @"😟", @"😠", @"😡", @"😔", @"😕", @"☹️",
            @"😣", @"😖", @"😫", @"😤", @"😮", @"😱", @"😨", @"😰", @"😯", @"😦",
            @"😢", @"😥", @"😪", @"😓", @"🤤", @"😭", @"😲", @"🤥", @"🤢", @"🤧",
            @"🤐", @"😷", @"🤒", @"🤕", @"😴", @"💤", @"💩", @"😈", @"👹", @"👺",
            @"💀", @"👻", @"👽", @"🤖", @"👏", @"👋", @"👍", @"👎", @"👊", @"🤞",
            @"🤝", @"✌️", @"👌", @"👀", @"💪", @"🙏", @"☝️", @"👆", @"👇", @"👈",
            @"👉", @"🖐", @"🤘", @"✍️", @"💅", @"👄", @"👅", @"👂", @"👃", @"👁"
        ];
    }
    return _base100Charset;
}

- (NSString *)encodedBase10String {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableString *encoded = [NSMutableString string];
    const uint8_t *bytes = [data bytes];
    NSUInteger length = [data length];
    
    for (NSUInteger i = 0; i < length; i += 1) {
        uint8_t value = 0;
        value = bytes[i];
        [encoded appendString:[self getBase100Charset][value / 100]];
        [encoded appendString:[self getBase100Charset][value % 100]];
    }
    return [encoded copy];
}

- (NSString *)decodedBase100String {
    NSMutableData *decodedData = [NSMutableData data];
    NSUInteger length = [self length];
    for (NSUInteger i = 0; i < length; i += 4) {
        NSRange range1 = NSMakeRange(i, 2);
        NSRange range2 = NSMakeRange(i + 2, 2);
        NSString *char1 = [self substringWithRange:range1];
        NSString *char2 = [self substringWithRange:range2];
        
        NSInteger index1 = [[self getBase100Charset] indexOfObject:char1];
        NSInteger index2 = [[self getBase100Charset] indexOfObject:char2];
        
        if (index1 != NSNotFound && index2 != NSNotFound) {
            uint8_t value = (index1 * 100) + index2;
            [decodedData appendBytes:&value length:sizeof(value)];
        }
    }
    return [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
}

@end


@implementation NSData (Encrypt)

static SecKeyRef privateKey;
static SecKeyRef publicKey;
- (void)generateECCKeyPair {
    NSDictionary *attributes = @{
        (__bridge id)kSecAttrKeyType: (__bridge id)kSecAttrKeyTypeECSECPrimeRandom,
        (__bridge id)kSecAttrKeySizeInBits: @256,
        (__bridge id)kSecAttrLabel: @"MyECCKeyPair"
    };

    CFErrorRef error = NULL;
    privateKey = SecKeyCreateRandomKey((__bridge CFDictionaryRef)attributes, &error);
    if (!privateKey) {
        NSLog(@"Failed to generate ECC key pair: %@", error);
        return;
    }

    publicKey = SecKeyCopyPublicKey(privateKey);
    if (!publicKey) {
        NSLog(@"Failed to get public key");
        CFRelease(privateKey);
        return;
    }

    // 导出公钥和私钥为 Data
    NSData *publicKeyData = [self exportSecKey:publicKey];
    NSData *privateKeyData = [self exportSecKey:privateKey];
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    BOOL pubResult = [publicKeyData writeToFile:[path stringByAppendingString:@"/public_key.der"] atomically:YES];
    BOOL privateResult = [privateKeyData writeToFile:[path stringByAppendingString:@"/private_key.der"] atomically:YES];
}

- (NSData *)exportSecKey:(SecKeyRef)secKey {
    CFDataRef publicKeyData = SecKeyCopyExternalRepresentation(secKey, NULL);
    NSData *data = (__bridge NSData *)publicKeyData;
    CFRelease(publicKeyData);
    return data;
}

- (SecKeyRef)createPublicKey:(NSString *)key {
//    NSString *key = [publicKeyData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//    @"BNLKw4NFfI3YySS/hEYjHOrMjyecjZFRvzyq6xQBrjvnxjgt9DPLVowylcRGy06E\
//    E85cPa9QtnW7ZR/WUXoVDWw=";
    
    NSData *publicKeyData = [[NSData alloc] initWithBase64EncodedString:key options:NSDataBase64DecodingIgnoreUnknownCharacters];;
    if (!publicKeyData) {
        NSLog(@"Failed to read public key file");
        return nil;
    }
    CFDictionaryRef publicKeyParams = (__bridge CFDictionaryRef)@{
        (__bridge id)kSecAttrKeyType: (__bridge id)kSecAttrKeyTypeECSECPrimeRandom,
        (__bridge id)kSecAttrKeyClass: (__bridge id)kSecAttrKeyClassPublic
    };
    CFErrorRef error = NULL;
    SecKeyRef publicKey = SecKeyCreateWithData((__bridge CFDataRef)publicKeyData, publicKeyParams, &error);
    if (!publicKey) {
        NSLog(@"Failed to import public key: %@", error);
        return nil;
    }
    return publicKey;
}

- (SecKeyRef)importPublicKeyFromFile:(NSString *)filePath {
    NSData *publicKeyData = [NSData dataWithContentsOfFile:filePath];
    NSString *key = [publicKeyData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    @"BNLKw4NFfI3YySS/hEYjHOrMjyecjZFRvzyq6xQBrjvnxjgt9DPLVowylcRGy06E\
    E85cPa9QtnW7ZR/WUXoVDWw=";
    if (!publicKeyData) {
        NSLog(@"Failed to read public key file");
        return nil;
    }

    CFDictionaryRef publicKeyParams = (__bridge CFDictionaryRef)@{
        (__bridge id)kSecAttrKeyType: (__bridge id)kSecAttrKeyTypeECSECPrimeRandom,
        (__bridge id)kSecAttrKeyClass: (__bridge id)kSecAttrKeyClassPublic
    };

    CFErrorRef error = NULL;
    SecKeyRef publicKey = SecKeyCreateWithData((__bridge CFDataRef)publicKeyData, publicKeyParams, &error);
    if (!publicKey) {
        NSLog(@"Failed to import public key: %@", error);
        return nil;
    }
    return publicKey;
}

- (SecKeyRef)createPrivateKey:(NSString *)key {
//    NSString *key = [privateKeyData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//    @"BNLKw4NFfI3YySS/hEYjHOrMjyecjZFRvzyq6xQBrjvnxjgt9DPLVowylcRGy06E\
//    E85cPa9QtnW7ZR/WUXoVDWxdq4sai95Rkb3YAJqF4dV0KVfAqLgsfWWu86NTEbaO\
//    7w==";
    NSData *privateKeyData = [[NSData alloc] initWithBase64EncodedString:key options:NSDataBase64DecodingIgnoreUnknownCharacters];
    if (!privateKeyData) {
        NSLog(@"Failed to read private key file");
        return nil;
    }

    CFDictionaryRef privateKeyParams = (__bridge CFDictionaryRef)@{
        (__bridge id)kSecAttrKeyType: (__bridge id)kSecAttrKeyTypeECSECPrimeRandom,
        (__bridge id)kSecAttrKeyClass: (__bridge id)kSecAttrKeyClassPrivate
    };

    CFErrorRef error = NULL;
    SecKeyRef privateKey = SecKeyCreateWithData((__bridge CFDataRef)privateKeyData, privateKeyParams, &error);
    if (!privateKey) {
        NSLog(@"Failed to import private key: %@", error);
        return nil;
    }
    return privateKey;

}

- (SecKeyRef)importPrivateKeyFromFile:(NSString *)filePath {
    NSData *privateKeyData = [NSData dataWithContentsOfFile:filePath];
    NSString *key = [privateKeyData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    @"BNLKw4NFfI3YySS/hEYjHOrMjyecjZFRvzyq6xQBrjvnxjgt9DPLVowylcRGy06E\
    E85cPa9QtnW7ZR/WUXoVDWxdq4sai95Rkb3YAJqF4dV0KVfAqLgsfWWu86NTEbaO\
    7w==";
    if (!privateKeyData) {
        NSLog(@"Failed to read private key file");
        return nil;
    }

    CFDictionaryRef privateKeyParams = (__bridge CFDictionaryRef)@{
        (__bridge id)kSecAttrKeyType: (__bridge id)kSecAttrKeyTypeECSECPrimeRandom,
        (__bridge id)kSecAttrKeyClass: (__bridge id)kSecAttrKeyClassPrivate
    };

    CFErrorRef error = NULL;
    SecKeyRef privateKey = SecKeyCreateWithData((__bridge CFDataRef)privateKeyData, privateKeyParams, &error);
    if (!privateKey) {
        NSLog(@"Failed to import private key: %@", error);
        return nil;
    }
    return privateKey;
}


- (NSData *)encodedDataByEcc {
    if (publicKey == NULL) {
        NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"HYBasicVC")];
        NSString *path = [bundle pathForResource:@"public_key" ofType:@"der"];
        publicKey = [self createPublicKey:@"BNLKw4NFfI3YySS/hEYjHOrMjyecjZFRvzyq6xQBrjvnxjgt9DPLVowylcRGy06E\
    E85cPa9QtnW7ZR/WUXoVDWw="];
    }
    if (privateKey == NULL) {
        NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"HYBasicVC")];
        NSString *path = [bundle pathForResource:@"private_key" ofType:@"der"];
        privateKey = [self createPrivateKey:@"BNLKw4NFfI3YySS/hEYjHOrMjyecjZFRvzyq6xQBrjvnxjgt9DPLVowylcRGy06E\
    E85cPa9QtnW7ZR/WUXoVDWxdq4sai95Rkb3YAJqF4dV0KVfAqLgsfWWu86NTEbaO\
    7w=="];
    }
    
    CFDictionaryRef parameters = (__bridge CFDictionaryRef)@{
        (__bridge id)kSecAttrKeyType: (__bridge id)kSecAttrKeyTypeRSA,
        (__bridge id)kSecAttrKeySizeInBits: @2048,
        (__bridge id)kSecAttrLabel:@"MyKeyPair"
    };

    // 生成密钥对
    OSStatus status = SecKeyGeneratePair(parameters, &privateKey, &publicKey);
    if (status != errSecSuccess) {
        NSLog(@"Failed to generate key pair: %ld", (long)status);
    }

    // 准备加密数据
    NSString *plainText = @"Hello, World!";
    NSData *dataToEncrypt = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    size_t dataLength = [dataToEncrypt length];
    const uint8_t *dataBytes = (const uint8_t *)[dataToEncrypt bytes];

    size_t blockSize = SecKeyGetBlockSize(publicKey);
    uint8_t *encryptedData = malloc(blockSize);
    size_t encryptedDataLength = 0;

    status = SecKeyEncrypt(publicKey,
                                    kSecPaddingPKCS1,
                           (const uint8_t *)[self bytes],
                           [self length],
                                    encryptedData,
                                    &encryptedDataLength);

    if (status == errSecSuccess) {
        NSData *encryptedDataResult = [NSData dataWithBytes:encryptedData length:encryptedDataLength];
        free(encryptedData);
        return encryptedDataResult;
    } else {
        NSLog(@"Encryption failed with status: %ld", (long)status);
        free(encryptedData);
        return nil;
    }

    if (publicKey == NULL ||
        privateKey == NULL) {
        [self generateECCKeyPair];
    }
    return nil;
//    const uint8_t plainText[] = "Hello, World!";
//    size_t plainTextLen = strlen((const char *)plainText);
//
//    // 获取密钥块大小
//    size_t blockSize = SecKeyGetBlockSize(publicKey);
//
//    // 准备输出缓冲区
//    uint8_t cipherText[blockSize];
//    size_t cipherTextLen = blockSize;
//
//    // 执行加密
//    OSStatus status1 = SecKeyEncrypt(publicKey, kSecPaddingNone, plainText, plainTextLen, cipherText, &cipherTextLen);
//    if (status1 == errSecSuccess) {
//        NSLog(@"加密成功");
//    } else {
//        NSLog(@"加密失败，错误码: %ld", (long)status1);
//    }
//    
//    
//    size_t bufferSize = SecKeyGetBlockSize(publicKey);
//    NSMutableData *buffer = [NSMutableData dataWithLength:bufferSize];
//    size_t dataLength = [self length];
//
//    OSStatus status = SecKeyEncrypt(publicKey,
//                                    kSecPaddingNone,
//                                    [self bytes],
//                                    dataLength,
//                                    [buffer mutableBytes],
//                                    &bufferSize);
//    if (status != errSecSuccess) {
//        NSLog(@"Encryption failed with status: %ld", (long)status);
//        return nil;
//    }
//    return [NSData dataWithData:buffer];
}

- (NSData *)decodedDataByEcc {
    if (publicKey == NULL) {
        NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"HYBasicVC")];
        NSString *path = [bundle pathForResource:@"public_key" ofType:@"der"];
        publicKey = [self importPublicKeyFromFile:path];
    }
    if (privateKey == NULL) {
        NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"HYBasicVC")];
        NSString *path = [bundle pathForResource:@"private_key" ofType:@"der"];
        privateKey = [self importPrivateKeyFromFile:path];
    }
    if (publicKey == NULL ||
        privateKey == NULL) {
        [self generateECCKeyPair];
    }
    
    size_t bufferSize = [self length];
    NSMutableData *buffer = [NSMutableData dataWithLength:bufferSize];
    OSStatus status = SecKeyDecrypt(privateKey,
                                    kSecPaddingPKCS1,
                                    [self bytes],
                                    bufferSize,
                                    [buffer mutableBytes],
                                    &bufferSize);
    if (status != errSecSuccess) {
        NSLog(@"Decryption failed with status: %ld", (long)status);
        return nil;
    }
    return [NSData dataWithData:buffer];
}

- (void)encryptData:(NSData *)data {
    // 生成 ECC 密钥对
    [self generateECCKeyPair];

    // 假设对方的公钥
    SecKeyRef peerPublicKey = [self publicKeyFromPEMString:@"PEM_STRING"];

    // 通过密钥交换生成共享密钥
    SecKeyRef sharedSecret = [self sharedSecretWithPrivateKey:privateKey publicKey:peerPublicKey];

    // 从共享密钥派生对称密钥
    NSString *aesKey = [self deriveSymmetricKeyFromSharedSecret:sharedSecret];

    // 使用对称密钥进行 AES 加密
    NSData *encryptedData = [self AES256EncryptWithKey:aesKey data:data];

    NSLog(@"Encrypted Data: %@", encryptedData);
}

- (SecKeyRef)sharedSecretWithPrivateKey:(SecKeyRef)privateKey publicKey:(SecKeyRef)publicKey {
    // 这里需要实现 ECC 密钥交换算法，生成共享密钥
    // 示例代码省略了具体的实现
    return NULL;
}

- (NSData *)generateSharedSecretWithPrivateKey:(SecKeyRef)privateKey publicKey:(SecKeyRef)publicKey {
    // 定义密钥交换参数
    CFErrorRef error = NULL;
    CFDictionaryRef publicKeyParams = (__bridge CFDictionaryRef)@{
    };
    NSData *sharedSecret = (__bridge NSData *)SecKeyCopyKeyExchangeResult(privateKey, kSecKeyAlgorithmECDHKeyExchangeStandard, publicKey, publicKeyParams, &error);
    if (!sharedSecret) {
        NSLog(@"Failed to generate shared secret: %@", error);
        return nil;
    }
    return sharedSecret;
}

- (NSString *)deriveSymmetricKeyFromSharedSecret:(SecKeyRef)sharedSecret {
    // 使用 HKDF 从共享密钥派生对称密钥
    // 示例代码省略了具体的实现
    return @"DerivedSymmetricKey";
}

- (SecKeyRef)publicKeyFromPEMString:(NSString *)pemString {
    // 从 PEM 字符串加载公钥
    // 示例代码省略了具体的实现
    return NULL;
}

- (NSData *)AES256EncryptWithKey:(NSString *)key data:(NSData *)data {
    char keyPtr[kCCKeySizeAES256 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];

    NSUInteger dataLength = data.length;
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;

    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL,
                                          data.bytes, dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);

    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }

    free(buffer);
    return nil;
}

- (NSData *)AES256DecryptWithKey:(NSString *)key data:(NSData *)data {
    char keyPtr[kCCKeySizeAES256 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];

    NSUInteger dataLength = data.length;
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;

    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL,
                                          data.bytes, dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);

    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }

    free(buffer);
    return nil;
}


@end
