//
//  NSDictionary+Form.m
//  SimpleTool
//
//  Created by hillyoung on 2022/2/22.
//  Copyright © 2022 Hillyoung. All rights reserved.
//

#import "NSDictionary+Form.h"
#import "HYLibrary_Private.h"


@implementation NSDictionary (Form)

- (NSString *)query {
    NSMutableArray *pairs = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *value;
        if ([obj isKindOfClass:NSString.class]) {
            value = obj;
        } else if ([obj isKindOfClass:NSNumber.class]) {
            value = [obj stringValue];
        } else {
            value = [obj yy_modelToJSONString];
        }
        [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
    }];
    return [pairs componentsJoinedByString:@"&"];
}

@end
