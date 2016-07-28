//
//  NSString+Encrypt.m
//  MDPMS
//
//  Created by luculent on 16/6/23.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "NSString+Encrypt.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Encrypt)

- (NSString*)hy_md5String {
    const char *ptr = [self UTF8String];
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(ptr, (int)strlen(ptr), md5Buffer);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
}

- (NSString *)hy_stringFromISOLatin1 {
    return [self hy_stringFromEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISOLatin1)];
}

- (NSString *)hy_stringFromEncoding:(NSStringEncoding)encoding {
    NSLog(@"value->%s", [self cStringUsingEncoding:encoding]);
    return [NSString stringWithCString:[self cStringUsingEncoding:encoding] encoding:NSUTF8StringEncoding];
}

@end
