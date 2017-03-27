//
//  HYRowDescriber.h
//  HYLibrary
//
//  Created by yanghaha on 17/3/27.
//  Copyright © 2017年 hillyoung. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HYRowDescriberNetTransferDelegate <NSObject>

@required

/**
 根据键值对，更新rowDescriber对象
 @params dict 数据传输时的键值对
 */
- (void)updateRowDescriberWithDict:(NSDictionary *)dict ;

/**
 进行传输的键值对 key:value;
 */
- (NSDictionary *)netParams ;

@end

/**
 基础的单元格行对象的描述对象
 */
@interface HYRowDescriber : NSObject <HYRowDescriberNetTransferDelegate>

/**
 可作为特殊控制的标识
 */
@property (strong, nonatomic) NSString *tag;

/**
 单元格重用的标识符
 */
@property (strong, nonatomic) NSString *identifier;

/**
 每行的标题
 */
@property (strong, nonatomic) NSString *title;

/**
 从网络获取显示内容的key
 */
@property (strong, nonatomic) NSString *textKey;

/**
 页面显示的内容
 */
@property (strong, nonatomic) NSString *text;

/**
 accessory的图片
 */
@property (strong, nonatomic) UIImage *accessoryImage;

/**
 是否高度自适应
 */
@property (nonatomic) BOOL autoFit;

/**
 单元格高度
 */
@property (nonatomic) float height;

/**
 是否可以触发事件
 */
@property (nonatomic) BOOL enable;

/**
 点击行触发的事件
 */
@property (nonatomic) SEL action;

/**
 点击行右侧的图标触发的事件
 */
@property (nonatomic) SEL accessoryAction;

/**
 初始化方法
 */
- (instancetype)initWithIdentifier:(NSString *)identifier
                             title:(NSString *)title
                           textKey:(NSString *)textKey
                              text:(NSString *)text;

@end


/**
 带有占位符显示的单元格对象的描述对象
 */
@interface HYFieldRowDescriber : HYRowDescriber

/**
 占位符
 */
@property (strong, nonatomic) NSString *placehold;

/**
 文本对齐方式
 */
@property (nonatomic) NSTextAlignment *textAligment;

/**
 键盘类型
 */
@property (nonatomic) UIKeyboardType keyboardType;

@end


/**
 元数据选择的单元格对象的描述对象
 */
@interface HYMetadataRowDescriber : HYFieldRowDescriber

/**
 元数据进行网络传输中value对应的key
 */
@property (strong, nonatomic) NSString *valueKey;

/**
 元数据进行网络传输的value
 */
@property (strong, nonatomic) NSString *value;

@end

