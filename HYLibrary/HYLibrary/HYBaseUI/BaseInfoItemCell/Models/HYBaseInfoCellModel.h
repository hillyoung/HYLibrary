//
//  HYBaseInfoCellModel.h
//  MDPMS
//
//  Created by luculent on 16/6/25.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Date_First @"firstDate"
#define Date_Second @"secondDate"

@interface BaseInfoItem : NSObject

@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) id content;
@property (copy, nonatomic) NSString *placehold;

- (instancetype)initWithTitle:(NSString *)title content:(id)content;

@end

@interface HYBaseInfoCellModel : NSObject

@property (strong, nonatomic) id title;

/**
 *  content
 */
@property (strong, nonatomic) id content;

@property (nonatomic) float cellHeight ;

@property (copy, nonatomic) NSString *cellIdentifier;

@property (nonatomic) NSTextAlignment textAlignment ;

- (instancetype)initWithTitle:(NSString *)title
                      content:(id)content
               cellIdentifier:(NSString *)cellIdentifier ;

@end

#pragma mark - 多行输入数据模型

@interface HYBaseInfoInputCellModel : HYBaseInfoCellModel

@property (copy, nonatomic) NSString *placehold;
@property (nonatomic) BOOL canEdit;
@property (assign, nonatomic) SEL action ;
@property (assign, nonatomic) SEL selectionAction ;
@property (nonatomic) BOOL canSelection;
@property (strong, nonatomic) UIImage *accessoryImage ;
@property (nonatomic) UIKeyboardType keyboardType;

- (instancetype)initWithTitle:(NSString *)title
                      content:(id)content
               cellIdentifier:(NSString *)cellIdentifier
                    placehold:(NSString *)placehold
                       action:(SEL)action ;

- (instancetype)initWithNoEditTitle:(NSString *)title
                            content:(id)content
                     cellIdentifier:(NSString *)cellIdentifier
                          placehold:(NSString *)placehold
                             action:(SEL)action ;

- (instancetype)initWithTitle:(NSString *)title
                      content:(id)content
               cellIdentifier:(NSString *)cellIdentifier
                    placehold:(NSString *)placehold
                       action:(SEL)action
               selectionAction:(SEL)selectionAction;


@end

#pragma mark - 元数据选取数据模型

@interface HYBaseMetadatCellModel : HYBaseInfoInputCellModel

/**
 *  元数据主键
 */
@property (copy, nonatomic) NSString *content_id;

@end
