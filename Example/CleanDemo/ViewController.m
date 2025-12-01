//
//  ViewController.m
//  CleanDemo
//
//  Created by hb28130 on 30/6/2025.
//  Copyright © 2025 hillyoung. All rights reserved.
//

#import "ViewController.h"
#import <HYAppInfo/HYAppInfo.h>
#import "HLRiskECCEncryptor.h"
#import <Masonry.h>
#import <Security/Security.h>
#import <CommonCrypto/CommonCrypto.h>
#import "HLECIESEncryptor.h"


@import MapKit;


@interface ViewController ()
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic) SecKeyRef publicKey;
@property (nonatomic) SecKeyRef privateKey;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    testCustomEncrypted();
}

- (void)decodeNetStr:(NSString *)netStr {
    NSData *netData = [[NSData alloc] initWithBase64EncodedString:netStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSError *error = nil;
    NSData *decryptedData = [[HLRiskECCEncryptor shareEncryptor] decryptData:netData error:&error];
    NSString *decrptedStr = [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
    NSLog(@"");
}

- (void)startTimer {
    // 创建一个定时器
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 10.0 * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(self.timer, ^{
        NSLog(@"Timer fired! %@", [NSDate date]);
    });
    dispatch_resume(self.timer);
    NSLog(@"恢复了 Timer fired! %@", [NSDate date]);
}

- (void)stopTimer {
    // 取消定时器
    if (self.timer) {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
}

//- (void)getShareKey:(SecKeyRef)privateKey publicKey:(SecKeyRef)publicKey {
//    size_t sharedSecretSize = SecKeyGetBlockSize(privateKey);
//    uint8_t sharedSecret[sharedSecretSize];
//    SecKeyCreateSharedSecret((__bridge CFTypeRef)privateKey, (__bridge CFTypeRef)publicKey, sharedSecret, &sharedSecretSize);
//
//}
//

int testCustomEncrypted() {
    NSString *privateBase64Str = @"308187020100301306072A8648CE3D020106082A8648CE3D030107046D306B02010104202476E758861A1B6E7FF62CC5CAA6420815B4B3C1A4D516AB21CE3898CC1B191CA14403420004280643A852B1E9537C9A5C88498D4A1C32FBBD0D61B711E3B56D4E7352394FBC8EBEDBBBD889703C6AD97A1126DD609B0E409C4FA161EBDB584A1851FB2EF836";
    privateBase64Str = @"04280643A852B1E9537C9A5C88498D4A1C32FBBD0D61B711E3B56D4E7352394FBC8EBEDBBBD889703C6AD97A1126DD609B0E409C4FA161EBDB584A1851FB2EF8362476E758861A1B6E7FF62CC5CAA6420815B4B3C1A4D516AB21CE3898CC1B191C";

    NSString *publicBase64Str = @"3059301306072A8648CE3D020106082A8648CE3D03010703420004280643A852B1E9537C9A5C88498D4A1C32FBBD0D61B711E3B56D4E7352394FBC8EBEDBBBD889703C6AD97A1126DD609B0E409C4FA161EBDB584A1851FB2EF836";
    publicBase64Str = @"04280643A852B1E9537C9A5C88498D4A1C32FBBD0D61B711E3B56D4E7352394FBC8EBEDBBBD889703C6AD97A1126DD609B0E409C4FA161EBDB584A1851FB2EF836";

//    NSData *publicData = [[HLRiskECCEncryptor shareEncryptor] exportKeyAsDER:publicKey];
    
//    NSData *shareKeyData = [HYCustomEncryptor generateSharedSecretWithPrivateKey:privateKey publicKey:publicKey];
//    encodedData = [HYCustomEncryptor kdf2X963FromZ:encodedData derivation:[NSData data] outLen:16+20 useSHA256:YES];

//    NSDictionary *pair = [HYCustomEncryptor deriveCipherAndMacFromZ:shareKeyData derivation:[NSData data] cipherKeyLen:16 macKeyLen:20 useSHA256:YES];
    
//    NSData *cipherKey = pair[@"cipherKey"];
//    NSData *macKey = pair[@"macKey"];
//    NSLog(@"共享密钥 %@ %@", hexStringFromData(pair[@"cipherKey"]), hexStringFromData(pair[@"macKey"]));
    
    NSString *jsonString = @"1235558";
    NSData *cipherData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *encodedData = [HYCustomEncryptor aesEncrypt:cipherData key:cipherKey];
//    NSLog(@"加密后数据 %@", encodedData.base64Encoding);
    
    NSString *encodedStr = @"BOhX2K7J3urNesgMaEYA73jaNKKq8n/hBcfvGoGnTUCSoLfTsYlHQ+gChUJQ3GWEZarRS/O4kadBAdp12l9/AMcyL0UWJ40azM5Q0Ui+dDr+2U/ADYFJXasKlCgKzgmlxUrhMow=";
    encodedStr = @"BPxOf6B/5d/L/D4m8OTD5JrLkG1f63ikIvBlGkCBl5g3EQlEwbRgo9M5ucg3KfcwEk/mgtvv4DHCXowy4fTjQLe/BWt0Kxl5d/xT2qnuNI8ZFDYZBG3xT1BcOoU37Wmap8/2lys=";
    encodedStr = @"BE0KBIXqGCvC5SUbaAdLu4mrVZWWKY1ZMcPR69SGGUlxC6AjSgCpzzOfC8jNNNBiFj3rfrlczLP0FE/3z3TJ9aVmaEbSYhxMHpjSnyqfozBa8p67vRCj7OGGdyGIJDMAJkv2yTM=";
    NSData *encodedData = [[NSData alloc] initWithBase64EncodedString:encodedStr options:0];
        
//    NSData *receivedMac = [[NSData alloc] initWithBase64EncodedData:[@"txr+WvA8kP+/JR8FDBqbCGFRwjo=" dataUsingEncoding:NSUTF8StringEncoding] options:0];
//    NSData *hmacKey = [HYCustomEncryptor hmacSha1:cipherData macKey:macKey];
//    
//    BOOL verifyed = [HYCustomEncryptor verifyHmac:cipherData macKey:macKey receivedMac:receivedMac useSha256:NO];
    

    encodedData = [HLECIESEncryptor eciesEncrypt:cipherData publicKeyData:[HLECIESEncryptor dataFromHexString:publicBase64Str]];
    
    NSData *decodedData = [HLECIESEncryptor eciesDecrypt:encodedData privateKeyData:[HLECIESEncryptor dataFromHexString:@"04280643A852B1E9537C9A5C88498D4A1C32FBBD0D61B711E3B56D4E7352394FBC8EBEDBBBD889703C6AD97A1126DD609B0E409C4FA161EBDB584A1851FB2EF8362476E758861A1B6E7FF62CC5CAA6420815B4B3C1A4D516AB21CE3898CC1B191C"]];
    NSLog(@"解密后数据 %@", [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding]);

//    NSData *decodedData = [HYCustomEncryptor aesDecrypt:[[NSData alloc] initWithBase64EncodedData:[@"ag0UY6qk2KoLcsvn9kFwEA==" dataUsingEncoding:NSUTF8StringEncoding] options:0] key:cipherKey];
//    NSLog(@"解密后数据 %@", [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding]);
    return 1;
}

@end
