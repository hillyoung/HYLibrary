//
//  HYSectionDescriber.m
//  HYLibrary
//
//  Created by yanghaha on 17/3/27.
//  Copyright © 2017年 hillyoung. All rights reserved.
//

#import "HYSectionDescriber.h"

@implementation HYSectionDescriber

- (instancetype)initWithTitle:(NSString *)title content:(id)content rows:(NSArray *)rows {
    if (self = [super init]) {
        _title = title;
        _content = content;
        _rows = rows;
        _sectionHeaderHeight = 16;
        _sectionFooterHeight = 0;
    }

    return self;
}

@end


@implementation HYFoldSectionDescriber

@end
