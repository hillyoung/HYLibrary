//
//  HYBaseInfoCellModel.m
//  MDPMS
//
//  Created by luculent on 16/6/25.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "HYBaseInfoCellModel.h"

#pragma mark - HYGroupDataSource ---------------------------------

@implementation HYGroupItem

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content rows:(NSArray *)rows {
    if (self = [super init]) {
        _title = title;
        _content = content;
        _rows = rows;
    }
    
    return self;
}

@end

#pragma mark - BaseInfoItem ---------------------------------


@implementation BaseInfoItem

- (instancetype)initWithTitle:(NSString *)title content:(id)content {
    if (self = [super init]) {
        _title = title;
        _content = content;
    }
    
    return self;
}

@end

#pragma mark - HYBaseInfoCellModel ---------------------------------

@implementation HYBaseInfoCellModel

- (instancetype)initWithTitle:(NSString *)title content:(id)content cellIdentifier:(NSString *)cellIdentifier {
    if (self = [super init]) {
        _title = title;
        _content = content;
        _cellIdentifier = cellIdentifier;
        _textAlignment = NSTextAlignmentRight;
    }
    
    return self;
}

@end

#pragma mark - HYBaseInfoInputCellModel ---------------------------------

@implementation HYBaseInfoInputCellModel

- (instancetype)initWithTitle:(NSString *)title
                      content:(id)content
               cellIdentifier:(NSString *)cellIdentifier
                    placehold:(NSString *)placehold
                       action:(SEL)action {
    return self = [self initWithTitle:title content:content cellIdentifier:cellIdentifier placehold:placehold action:action selectionAction:nil];
}

- (instancetype)initWithNoEditTitle:(NSString *)title
                            content:(id)content
                     cellIdentifier:(NSString *)cellIdentifier
                          placehold:(NSString *)placehold
                             action:(SEL)action {
    if (self = [self initWithTitle:title
                           content:content
                    cellIdentifier:cellIdentifier
                         placehold:placehold
                            action:action
                    selectionAction:nil]) {
        _canEdit = NO;
    }
    
    return self;
}

- (instancetype)initWithTitle:(NSString *)title content:(id)content cellIdentifier:(NSString *)cellIdentifier placehold:(NSString *)placehold action:(SEL)action selectionAction:(SEL)selectionAction {
    if (self = [super initWithTitle:title
                            content:content
                     cellIdentifier:cellIdentifier]) {
        _placehold = placehold.length? placehold:@"请填写";
        _canEdit = YES;
        _action = action;
        _selectionAction = selectionAction;
    }
    
    return self;

}

@end

#pragma mark - 元数据选取数据模型

@implementation HYBaseMetadatCellModel

- (instancetype)initWithNoEditTitle:(NSString *)title content:(id)content cellIdentifier:(NSString *)cellIdentifier placehold:(NSString *)placehold action:(SEL)action {
    if (self = [super initWithNoEditTitle:title content:content cellIdentifier:cellIdentifier placehold:placehold action:action]) {
        self.canSelection = YES;
    }
    
    return self;
}

- (instancetype)initWithTitle:(NSString *)title content:(id)content cellIdentifier:(NSString *)cellIdentifier placehold:(NSString *)placehold action:(SEL)action {
    if (self=[super initWithTitle:title content:content cellIdentifier:cellIdentifier placehold:placehold action:action]) {
        self.canSelection = YES;
    }

    return self;
}

@end

