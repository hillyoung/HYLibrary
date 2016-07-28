//
//  NSString+Encrypt.h
//  MDPMS
//
//  Created by luculent on 16/6/23.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encrypt)


/**
 *  md5加密后的字符串
 */
- (NSString*)hy_md5String ;

- (NSString *)hy_stringFromISOLatin1 ;

- (NSString *)hy_stringFromEncoding:(NSStringEncoding)encoding ;

@end
