//
//  HYRefreshViewController.m
//  MDPMS
//
//  Created by luculent on 16/6/25.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "HYRefreshVC.h"
#import <objc/runtime.h>

NSUInteger startPage = 1;

@implementation HYRefreshVC
@synthesize groups = _groups;

#pragma mark - Setter && Getter

const char *HYRefreshViewController_group_key;
- (void)setGroups:(NSArray<HYSectionDescriber *> *)groups {
    objc_setAssociatedObject(self, HYRefreshViewController_group_key, groups, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray<HYSectionDescriber *> *)groups {
    NSArray *array = objc_getAssociatedObject(self, HYRefreshViewController_group_key);
    
    if (!array) {
        array = [NSArray array];
        objc_setAssociatedObject(self, HYRefreshViewController_group_key, array, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    return array;
}

const char *HYRefreshViewController_dataList_key;
- (void)setDataList:(NSMutableArray *)dataList {
    objc_setAssociatedObject(self, HYRefreshViewController_dataList_key, dataList, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)dataList {
    NSMutableArray *array = objc_getAssociatedObject(self, HYRefreshViewController_dataList_key);
    
    if (!array) {
        array = [NSMutableArray array];
        objc_setAssociatedObject(self, HYRefreshViewController_dataList_key, array, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return array;
}

- (void)headerRefresheAction {
    self.page = startPage;
    [self loadData:YES];
}

- (void)footerRefresheAction {
    [self loadData:NO];
}

/**
 基类默认未做任何实现
 */
- (void)loadData:(BOOL)shouldCover {

}

@end
