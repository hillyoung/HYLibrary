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
