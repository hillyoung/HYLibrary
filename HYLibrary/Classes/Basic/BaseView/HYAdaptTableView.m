//
//  HYAdaptTableView.m
//  SimpleTool
//
//  Created by 杨小山 on 2022/4/17.
//  Copyright © 2022 Hillyoung. All rights reserved.
//

#import "HYAdaptTableView.h"

@implementation HYAdaptTableView

- (void)setContentSize:(CGSize)contentSize {
    [self invalidateIntrinsicContentSize];
    super.contentSize = contentSize;
}

- (CGSize)intrinsicContentSize {
    return self.contentSize;
}

@end
