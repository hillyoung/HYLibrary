//
//  HYBaseHeaderFooter.m
//  MDPMS
//
//  Created by luculent on 16/6/28.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "HYBaseHeaderFooter.h"

@implementation HYBaseHeaderFooter
@synthesize titleColor = _titleColor;
@synthesize detailColor = _detailColor;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }

    return self;
}

#pragma mark - Setter && Getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
//        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = self.titleColor;
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }

    return _titleLabel;
}

- (UIButton *)detailButton {
    if (!_detailButton) {
        _detailButton = [[UIButton alloc] init];
        _detailButton.translatesAutoresizingMaskIntoConstraints = NO;
        _detailButton.backgroundColor = [UIColor clearColor];
        _detailButton.titleLabel.textAlignment = NSTextAlignmentRight;
        _detailButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_detailButton addTarget:self action:@selector(detailButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _detailButton;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    
    self.titleLabel.textColor = _titleColor;
}

- (UIColor *)titleColor {
    if (!_titleColor) {
        _titleColor = [UIColor lightGrayColor];
    }
    
    return _titleColor;
}

- (void)setDetailColor:(UIColor *)detailColor {
    _detailColor = detailColor;
    
    [self.detailButton setTitleColor:_detailColor forState:UIControlStateNormal];
}

- (UIColor *)detailColor {
    if (!_detailColor) {
        _detailColor = [UIColor lightGrayColor];
    }
    
    return _detailColor;
}

#pragma mark - Private

- (void)setupUI {
    [self addSubview:self.titleLabel];
    [self addSubview:self.detailButton];
    
    [self updateTitleLabel];
    [self updateDetailButton];
}

- (void)updateTitleLabel {

    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterY toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeading toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:16]];
    [self.titleLabel addConstraint:[NSLayoutConstraint greaterThanConstraintWithItem:self.titleLabel attribute:NSLayoutAttributeWidth toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:80]];
    [self.titleLabel addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.titleLabel attribute:NSLayoutAttributeHeight toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:16]];
}

- (void)updateDetailButton {


    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.detailButton attribute:NSLayoutAttributeCenterY toItem:self.titleLabel attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.detailButton attribute:NSLayoutAttributeTrailing toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-16]];
    [self.detailButton addConstraint:[NSLayoutConstraint greaterThanConstraintWithItem:self.detailButton attribute:NSLayoutAttributeWidth toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60]];
    [self.detailButton addConstraint:[NSLayoutConstraint equalConstraintWithItem:self.detailButton attribute:NSLayoutAttributeHeight toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:16]];
}

#pragma mark - Action

- (void)detailButtonAction {
    if (self.detailButtonTapBlock) {
        self.detailButtonTapBlock(self);
    }
}

#pragma mark - Message

- (void)updateWithTitle:(NSString *)title detailTitle:(NSString *)detailTitle {
    self.titleLabel.text = title;
    [self.detailButton setTitle:detailTitle forState:UIControlStateNormal];
}

@end
