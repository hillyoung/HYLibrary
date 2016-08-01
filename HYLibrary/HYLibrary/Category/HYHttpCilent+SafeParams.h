//
//  HYHttpCilent+SafeParams.h
//  HYLibrary
//
//  Created by luculent on 16/7/28.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "HYHttpCilent.h"

@interface HYHttpCilent (SafeParams)

/**
 *  返回，给制定参数加上，安全接口所需的参数
 */
+ (NSDictionary *)paramsForSafeInterfaceFromParams:(NSDictionary *)params ;

@end
