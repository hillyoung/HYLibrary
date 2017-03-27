//
//  HYSectionDescriber.h
//  HYLibrary
//
//  Created by yanghaha on 17/3/27.
//  Copyright © 2017年 hillyoung. All rights reserved.
//

#import <Foundation/Foundation.h>

//分区对象：如tableview中的每个分区（亦有人称为“段落”）
/**
 普通分区的描述对象
 */
@interface HYSectionDescriber : NSObject

@property (copy, nonatomic) NSString *title;    //分区的标题
@property (nonatomic) id content;     //可以用来持有复杂的数据类型
@property (strong, nonatomic) NSArray *rows ;   //分区中存在的行对象
@property (nonatomic) CGFloat sectionHeaderHeight ;   //段落头的高度
@property (nonatomic) CGFloat sectionFooterHeight ;   //段落头的高度

@property (copy, nonatomic) NSString *headerIdentifier ;  //头重用标识符
@property (copy, nonatomic) NSString *footerIdentifier ;  //足重用标识符

- (instancetype)initWithTitle:(NSString *)title content:(id)content rows:(NSArray *)rows ;

@end

/**
 可折叠的分区的描述对象
 */
@interface HYFoldSectionDescriber : HYSectionDescriber

@property (nonatomic, getter=isFold) BOOL fold;

@end
