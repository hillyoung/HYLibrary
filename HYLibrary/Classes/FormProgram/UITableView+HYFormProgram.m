//
//  UITableView+HYFormProgram.m
//  SimpleTool
//
//  Created by hillyoung on 2021/9/23.
//  Copyright © 2021 Hillyoung. All rights reserved.
//

#import "UITableView+HYFormProgram.h"


@implementation UITableView (HYFormProgram)

- (UITableViewCell<HYFormCellConfigProtocol> *)dequeueReusableCellWithDataSource:(HYFormRowDataSource *)dataSource {
    UITableViewCell<HYFormCellConfigProtocol> *cell = [self dequeueReusableCellWithIdentifier:dataSource.identifier];
    if (!cell) {
        cell = [[NSClassFromString(dataSource.identifier) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dataSource.identifier];
    }
    return cell;
}

- (UITableViewHeaderFooterView<HYFormSectionConfigProtocol> *)dequeueReusableHeaderFooterViewWithDataSource:(HYFormSectionDataSource *)dataSource {
    UITableViewHeaderFooterView<HYFormSectionConfigProtocol> *view = [self dequeueReusableHeaderFooterViewWithIdentifier:dataSource.identifier];
    if (!view) {
        view = [[NSClassFromString(dataSource.identifier) alloc] initWithReuseIdentifier:dataSource.identifier];
    }
    return view;
}

- (BOOL)triggerDataSource:(HYFormRowDataSource *)rowD {
    if ([rowD.target respondsToSelector:rowD.selector]) {
        return [rowD.target performSelector:rowD.selector withObject:rowD];
    }
    return NO;
}

@end
