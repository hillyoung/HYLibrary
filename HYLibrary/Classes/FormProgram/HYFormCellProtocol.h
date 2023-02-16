//
//  HYFormCellProtocol.h
//  SimpleTool
//
//  Created by hillyoung on 2021/9/23.
//  Copyright © 2021 Hillyoung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYFormDataSource.h"

#define kTitleLabelWidth 75         // 单元格标题宽度

NS_ASSUME_NONNULL_BEGIN

@protocol HYFormCellDelegate;
@protocol HYFormCellConfigProtocol
/// 设置单元格标题
extern void(^ _Nonnull setTitleForLabel)(UILabel *_Nullable, NSString *_Nullable);
/// 更新cell
/// @param datasource cell数据源
- (void)update:(HYFormRowDataSource *)datasource ;
@optional
@property (nonatomic, weak) NSObject<HYFormCellDelegate> *delegate;    /**< 触发的事件的代理对象 */
@property (nonatomic, weak) UITableView *tableView;          /**< 表视图 */

@end


@protocol HYFormCellDelegate
@optional
/// 表单对应的value变化后的回调
/// @param cell 表单单元格
/// @param value 值
- (void)cell:(UITableViewCell<HYFormCellConfigProtocol> *)cell didChangeValue:(id)value ;
/// 结束编辑单元格
/// @param cell 表单单元格
- (void)didEndEditingInCell:(UITableViewCell<HYFormCellConfigProtocol> *)cell ;
/// 点击获取验证码按钮的回调
/// @param cell 表单单元格
- (void)didTapVerifyCodeButtonIncell:(UITableViewCell *)cell ;
@end


@protocol HYFormSectionConfigProtocol <NSObject>

- (void)update:(HYFormSectionDataSource *)datasource ;


@end

NS_ASSUME_NONNULL_END
