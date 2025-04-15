//
//  HYColorPicker.m
//  SimpleTool
//
//  Created by 杨小山 on 2022/4/17.
//  Copyright © 2022 Hillyoung. All rights reserved.
//

#import "HYColorPicker.h"
#import <Masonry.h>
@import ChromaColorPicker;

@implementation HYColorPicker

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    ChromaColorPicker *picker = [ChromaColorPicker new];
    [picker addHandleAt:[UIColor whiteColor]];
    [picker addTarget:self action:@selector(didChangeColor:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:picker];
    [picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(16);
        make.centerX.equalTo(self.contentView);
        make.width.height.equalTo(@300);
    }];
    
    ChromaBrightnessSlider *slider = [ChromaBrightnessSlider new];
    [slider addTarget:self action:@selector(didChangeBrightness:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:slider];
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(picker.mas_bottom).offset(8);
        make.width.centerX.equalTo(picker);
        make.height.equalTo(@20);
        make.bottom.equalTo(self.contentView).offset(-16);
    }];
    
    [picker connect:slider];
}

- (void)setupContentView {
    self.contentView = [UIView new];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.contentView.layer.cornerRadius = 6.0;
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.equalTo(self);
        make.bottom.equalTo(self).priority(100);
    }];
}

- (void)didChangeColor:(ChromaColorPicker *)picker {
    if ([self.delegate respondsToSelector:@selector(colorPicker:didChangeColor:)]) {
        [self.delegate colorPicker:self didChangeColor:picker.brightnessSlider.currentColor];
    }
}

- (void)didChangeBrightness:(ChromaBrightnessSlider *)slider {
    if ([self.delegate respondsToSelector:@selector(colorPicker:didChangeColor:)]) {
        [self.delegate colorPicker:self didChangeColor:slider.currentColor];
    }
}

@end
