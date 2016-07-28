//
//  HYNetBaseModel.m
//  MDPMS
//
//  Created by luculent on 16/7/4.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "HYNetBaseModel.h"

@implementation HYNetBaseModel

- (id)valueForKey:(NSString *)key {
    id value = [super valueForKey:key];
    
    if (!value) {
        value = @"";
    }
    
    return value;
}

- (NSString *)checkValues {
    return @"";
}

@end
