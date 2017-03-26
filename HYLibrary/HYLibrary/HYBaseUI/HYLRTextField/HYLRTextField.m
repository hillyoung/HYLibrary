//
//  HYLRTitleTextField.m
//  EasyNet
//
//  Created by yanghaha on 15/12/29.
//  Copyright © 2015年 yanghaha. All rights reserved.
//

#import "HYLRTextField.h"

@interface HYLRTitleTextField ()

@property (strong, nonatomic) UILabel *label;

@end

@implementation HYLRTitleTextField

- (instancetype)init {
    self = [super init];
    if (self) {
        self.editEnable = NO;
        self.borderStyle = UITextBorderStyleNone;
    }

    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    self.editEnable = NO;
    self.borderStyle = UITextBorderStyleNone;
}

- (void)layoutSubviews {

    CGFloat height = CGRectGetHeight(self.frame);
    CGFloat width = self.itemWidth;

    self.label.font = self.font;
    self.label.frame = CGRectMake(0, 0, width, height);

    [super layoutSubviews];

    self.enabled = self.editEnable;

    if (self.style == HYLRTextFieldStyleLeft) {
        self.leftViewMode = UITextFieldViewModeAlways;
        self.leftView = self.label;
    } else {
        self.rightViewMode = UITextFieldViewModeAlways;
        self.rightView = self.label;
    }
}

#pragma mark - Setter && Getter

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.lineBreakMode = NSLineBreakByCharWrapping;
        _label.numberOfLines = 0;
    }

    return _label;
}

- (void)setTitle:(NSString *)title {
    _title = title;

    self.label.text = _title;
}

- (CGFloat)itemWidth {
    if (_itemWidth < 5) {
        _itemWidth = self.font.pointSize * self.title.length;
    }
    
    return _itemWidth;
}

- (void)setTitleAlignment:(HYLRTextFieldTitleAlignment)titleAlignment {
    _titleAlignment = titleAlignment;

    if (_titleAlignment == HYLRTextFieldTitleAlignmentLeft) {
        self.label.textAlignment = NSTextAlignmentLeft;
    } else if (_titleAlignment == HYLRTextFieldTitleAlignmentCenter) {
        self.label.textAlignment = NSTextAlignmentCenter;
    } else if (_titleAlignment == HYLRTextFieldTitleAlignmentRight) {
        self.label.textAlignment = NSTextAlignmentRight;
    }
}

- (void)setEditEnable:(BOOL)editEnable {
    _editEnable = editEnable;
    self.enabled = _editEnable;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;

    self.label.textColor = _titleColor;
}

- (void)setStyle:(HYLRTextFieldStyle)style {
    _style = style;

    if (_style == HYLRTextFieldStyleLeft) {
        self.leftViewMode = UITextFieldViewModeAlways;
        self.leftView = self.label;
    } else {
        self.rightViewMode = UITextFieldViewModeAlways;
        self.rightView = self.label;
    }
}

#pragma mark - Private



@end

@interface HYLRImageTextField ()

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation HYLRImageTextField

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.editEnable = NO;
        self.borderStyle = UITextBorderStyleNone;
    }
    
    return self;
}

- (void)layoutSubviews {
    self.imageView.frame = CGRectMake(0, 0, self.itemWidth, CGRectGetHeight(self.frame));

    [super layoutSubviews];

    if (self.style == HYLRTextFieldStyleLeft) {
        self.leftViewMode = UITextFieldViewModeAlways;
        self.leftView = self.imageView;
    } else {
        self.rightViewMode = UITextFieldViewModeAlways;
        self.rightView = self.imageView;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.editEnable = NO;
    self.borderStyle = UITextBorderStyleNone;
}

#pragma mark - Setter && Getter

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }

    return _imageView;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = _image;
}

- (void)setEditEnable:(BOOL)editEnable {
    _editEnable = editEnable;
    self.enabled = _editEnable;
}

- (void)setImageContentType:(NSUInteger)imageContentType {
    self.imageView.contentMode = imageContentType;
}


@end

