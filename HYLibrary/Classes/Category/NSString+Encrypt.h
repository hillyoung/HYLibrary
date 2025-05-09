//
//  NSString+Encrypt.h
//  MDPMS
//
//  Created by luculent on 16/6/23.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 NSSting编码扩展
 */
@interface NSString (Encrypt)


/**
 *  md5加密后的字符串
 */
- (NSString*)md5String ;

- (NSString *)stringFromISOLatin1 ;

- (NSString *)stringFromEncoding:(NSStringEncoding)encoding ;

- (NSString *)encodedBase10String ;

- (NSString *)decodedBase100String ;

@end
