//
//  UITableView+HYFormProgram.h
//  SimpleTool
//
//  Created by hillyoung on 2021/9/23.
//  Copyright © 2021 Hillyoung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYFormCellProtocol.h"
#import "HYFormDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (HYFormProgram)

/// 通过数据源定位到可重用的单元格：如果缓冲池中没有，则构造一个cell
/// @param rowD 单元格数据源
- (UITableViewCell<HYFormCellConfigProtocol> *)dequeueReusableCellWithDataSource:(HYFormRowDataSource *)rowD ;

/// 通过数据源定位到可重用的单元格表头、表尾：如果缓冲池中没有，则构造一个表头、表尾
/// @param dataSource 单元格表头、表尾数据源
- (UITableViewHeaderFooterView<HYFormSectionConfigProtocol> *)dequeueReusableHeaderFooterViewWithDataSource:(HYFormSectionDataSource *)dataSource ;

/// 触发数据源对应的点击事件selector
/// @param rowD 单元格数据源
- (BOOL)triggerDataSource:(HYFormRowDataSource *)rowD ;


@end

NS_ASSUME_NONNULL_END
