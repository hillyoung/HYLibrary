//
//  HYFormCellDataSource.h
//  SimpleTool
//
//  Created by hillyoung on 2021/9/23.
//  Copyright © 2021 Hillyoung. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HYFormCellDelegate;
@interface HYFormRowDataSource : NSObject

@property (nonatomic) float height;       /**< 表头、表尾高度：默认是UITableViewAutomaticDimension */
@property (nonatomic, copy) NSString *imageName;        /**< 图片名称 */
@property (nonatomic, copy) NSString *title;   /**< 单元格标题 */
@property (nonatomic, copy) NSString *identifier;   /**< cell样式的标识 */
@property (nonatomic, copy) NSString *label;     /**< 单元格对应的值名称 */
@property (nonatomic) BOOL secreted;    /**< 是否需要加密 */
@property (nonatomic, copy) NSString *placeholder;     /**< 输入框提示语 */
@property (nonatomic) NSInteger keyboardType;      /**< 键盘类型 */

@property (nonatomic, copy) NSString *field;     /**< form表单中对应参数名 */
@property (nonatomic)   id  value;      /**< 单元格对应的值*/
@property (nonatomic) BOOL required;        /**< 是否必填 */

@property (nonatomic, weak) id target;  /**< 响应事件的对象 */
@property (nonatomic) SEL selector;     /**< 单元格点击事件名 */
@property (nonatomic) SEL customSelector;     /**< 自定义点击事件名 */

@property (nonatomic) BOOL selected;        /**< 是否选中：默认NO */
@property (nonatomic, weak) NSObject<HYFormCellDelegate> *delegate;        /**< 代理对象 */

/// 数据源中的值是否有效
- (BOOL)isValueValid ;
/// 通过参数名获取对应的单元格数据源
/// @param field 参数名
/// @param dataSources 数据源集合
+ (HYFormRowDataSource *)findDataSourceWithField:(NSString *)field inDataSources:(NSArray<HYFormRowDataSource *> *)dataSources ;
/// 校验数据源中是否有required为YES，value为空的单元格数据源：返回找到第一个满足条件的数据源
/// @param dataSources 数据源集合
+ (HYFormRowDataSource *)checkDataSourceRequiredInDataSources:(NSArray<HYFormRowDataSource *> *)dataSources ;

@end



@interface HYFormSectionDataSource : NSObject

@property (nonatomic, copy) NSString *identifier;       /**< 标识符 */
@property (nonatomic, copy) NSString *title;        /**< 标题 */
@property (nonatomic, strong) NSMutableArray<HYFormRowDataSource *> *rows;     /**< 分组下所有的行 */
@property (nonatomic) float height;       /**< 表头、表尾高度：默认是UITableViewAutomaticDimension */
@property (nonatomic) BOOL folded;       /**< 是否折叠 */
@property (nonatomic) id userInfo;       /**< 用户自定义消息 */
/// 添加行
- (HYFormSectionDataSource *(^)(HYFormRowDataSource *))addRow ;
/// 获取指定位置的行数据源
/// @param indexPath 指定位置
/// @param dataSources 数据源
+ (HYFormRowDataSource *)findRowDataSourceAtIndexPath:(NSIndexPath *)indexPath inSectionDataSources:(NSArray<HYFormSectionDataSource *> *)dataSources ;

@end

NS_ASSUME_NONNULL_END
