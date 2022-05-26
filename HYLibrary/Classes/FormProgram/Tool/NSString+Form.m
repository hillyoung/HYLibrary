//
//  NSString+Form.m
//  SimpleTool
//
//  Created by 杨小山 on 2022/3/7.
//  Copyright © 2022 Hillyoung. All rights reserved.
//

#import "NSString+Form.h"

@implementation NSString (Form)

- (NSDictionary *)queryDictionary {
    NSArray *queryArray = [self componentsSeparatedByString:@"&"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:queryArray.count];
    [queryArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *keyValues = [obj componentsSeparatedByString:@"="];
        [dict setValue:keyValues.lastObject forKey:keyValues.firstObject];
    }];
    return [dict copy];
}

@end
