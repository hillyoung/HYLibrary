//
//  NSString+Form.h
//  SimpleTool
//
//  Created by 杨小山 on 2022/3/7.
//  Copyright © 2022 Hillyoung. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NSString_Not_Nil(str) (str && ![str isKindOfClass:NSNull.class]) ? str:@""

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Form)

/// 参数字典
- (NSDictionary *)queryDictionary ;

@end

NS_ASSUME_NONNULL_END
