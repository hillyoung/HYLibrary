//
//  HYBaseInfoInputCell.h
//  MDPMS
//
//  Created by luculent on 16/6/25.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYBaseInfoInputCell : UITableViewCell {
    @protected
    CGFloat _gapToTop;
    CGFloat _gapToBottom;
}

/**
 *  标题的颜色
 */
@property (strong, nonatomic) UIColor *titleColor ;

@property (strong, nonatomic, readonly) HYLRTitleTextField *infoTextField;

/**
 *  accessory
 */
@property (strong, nonatomic) UIImageView *accessoryImageView;

/**
 *  设置编辑完成的点击回调
 */
@property (copy, nonatomic) void(^changeCharactersBlock)(HYBaseInfoInputCell *cell, NSString *text);

/**
 *  设置accessory图片的点击回调
 */
@property (copy, nonatomic) void(^accessoryTapBlock)(HYBaseInfoInputCell *cell);

@property (nonatomic) CGFloat gapToTop ;
/**
 *  设置infoTextField垂直方向的距离底部的距离
 */
@property (nonatomic) CGFloat gapToBottom ;

- (void)updateWithTitle:(NSString *)title
                content:(NSString *)content
              placehold:(NSString *)placehold
         accessoryImage:(UIImage *)accessoryImage ;

- (void)setAccessoryImageViewHidden:(BOOL)hidden ;

@end

@interface HYImageItemModel : NSObject

@property (strong, nonatomic) id image;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *originUrlStr; //原图地址
@property (nonatomic) BOOL isVideo ;

- (instancetype)initWithImage:(UIImage *)image name:(NSString *)name ;

- (instancetype)initWithImage:(UIImage *)image
                         name:(NSString *)name
                 originUrlStr:(NSString *)originUrlStr ;

@end

/**
 *  添加图片的cell
 */
@interface HYAddImageCell : HYBaseInfoInputCell

@property (nonatomic) CGSize itemSize ;
@property (copy, nonatomic) void(^deleteImageBlock)(HYAddImageCell *cell, NSUInteger index) ;
@property (copy, nonatomic) void(^toucheImageBlock)(HYAddImageCell *cell, NSUInteger index) ;
@property (nonatomic) BOOL edit;

- (void)updateWithImages:(NSArray<HYImageItemModel *> *)images ;

@end

/**
 *  多行输入cell
 */
@interface HYBaseInfoMultiInputCell : HYBaseInfoInputCell {
//@protected
//    CGFloat _gapToTop;
//    CGFloat _gapToBottom;
}

/**
 *  标题的字体大小
 */
@property (strong, nonatomic) UIFont *titleFont ;

/**
 *  输入框高度
 */
@property (nonatomic) CGFloat textViewHeight ;

@property (strong, nonatomic, readonly) HYPlaceholdTextView *inputTextView ;

- (void)updateWithTitle:(NSString *)title
                content:(NSString *)content
              placehold:(NSString *)placehold ;

@end

/**
 *  左侧为图片，右侧为内容的cell
 */
@interface HYBaseImageTitleCell : UITableViewCell

@property (strong, nonatomic, readonly) HYLRImageTextField *infoTextField;

/**
 *  设置accessory图片的点击回调
 */
@property (copy, nonatomic) void(^accessoryTapBlock)(HYBaseImageTitleCell *cell);

@property (nonatomic) CGFloat gapToTop ;
/**
 *  设置infoTextField垂直方向的距离底部的距离
 */
@property (nonatomic) CGFloat gapToBottom ;

- (void)updateWithImage:(UIImage *)image
                content:(NSString *)content
              placehold:(NSString *)placehold
         accessoryImage:(UIImage *)accessoryImage ;

@end

/**
 *  两个时间的选取
 */
@interface HYDoubleDateCell : UITableViewCell

@property (nonatomic) CGFloat gapToTop ;

@property (strong, nonatomic, readonly) UILabel *titleLabel ;
@property (strong, nonatomic, readonly) HYLRImageTextField *leftDateTextField;
@property (strong, nonatomic, readonly) HYLRImageTextField *rightDateTextField;

@property (copy, nonatomic) void(^firstDateBlock)(HYDoubleDateCell *cell) ;
@property (copy, nonatomic) void(^secondDateBlock)(HYDoubleDateCell *cell) ;

/**
 *  Description
 *
 *  @param title       <#title description#>
 *  @param fristDate   <#fristDate description#>
 *  @param firstImage  第一张时间标示图片
 *  @param secondDate  <#secondDate description#>
 *  @param secondImage 第二张时间标示图片
 */
- (void)updateWithTitle:(NSString *)title
              firstDate:(NSString *)firstDate
             firstImage:(UIImage *)firstImage
             secondDate:(NSString *)secondDate
            secondImage:(UIImage *)secondImage;

@end
