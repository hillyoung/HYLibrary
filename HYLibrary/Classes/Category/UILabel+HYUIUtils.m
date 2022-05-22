//
//  UILabel+HYUIUtils.m
//  GuoDianHeZe
//
//  Created by young on 2017/3/14.
//  Copyright © 2017年 luculent. All rights reserved.
//

#import "UILabel+HYUIUtils.h"

const short h1Font = 32;
const short h2Font = 24;
const short h3Font = 18;
const short h4Font = 16;
const short h5Font = 14;
const short h6Font = 12;

@implementation UILabel (HYUIUtils)

+ (UILabel *)singleLineLabel {
    UILabel *label = [UILabel new];
    label.numberOfLines = 1;
    return label;
}

+ (UILabel *)h1Label {
    UILabel *label = [UILabel singleLineLabel];
    label.font = [UIFont systemFontOfSize:h1Font];
    return label;
}

+ (UILabel *)h1BoldLabel {
    UILabel *label = [UILabel singleLineLabel];
    label.font = [UIFont boldSystemFontOfSize:h1Font];
    return label;
}

+ (UILabel *)h1LightGrayLabel {
    UILabel *label = [UILabel singleLineLabel];
    label.font = [UIFont systemFontOfSize:h1Font];
    label.textColor = [UIColor lightGrayColor];
    return label;
}

+ (UILabel *)h2Label {
    UILabel *label = [UILabel singleLineLabel];
    label.font = [UIFont systemFontOfSize:h2Font];
    return label;
}

+ (UILabel *)h2BoldLabel {
    UILabel *label = [UILabel singleLineLabel];
    label.font = [UIFont boldSystemFontOfSize:h2Font];
    return label;
}

+ (UILabel *)h2LightGrayLabel {
    UILabel *label = [UILabel singleLineLabel];
    label.font = [UIFont systemFontOfSize:h2Font];
    label.textColor = [UIColor lightGrayColor];
    return label;
}

+ (UILabel *)h3Label {
    UILabel *label = [UILabel singleLineLabel];
    label.font = [UIFont systemFontOfSize:h3Font];
    return label;
}

+ (UILabel *)h3BoldLabel {
    UILabel *label = [UILabel singleLineLabel];
    label.font = [UIFont boldSystemFontOfSize:h3Font];
    return label;
}

+ (UILabel *)h3LightGrayLabel {
    UILabel *label = [UILabel singleLineLabel];
    label.font = [UIFont systemFontOfSize:h3Font];
    label.textColor = [UIColor lightGrayColor];
    return label;
}

+ (UILabel *)h4Label {
    UILabel *label = [UILabel singleLineLabel];
    label.font = [UIFont systemFontOfSize:h4Font];
    return label;
}

+ (UILabel *)h4BoldLabel {
    UILabel *label = [UILabel singleLineLabel];
    label.font = [UIFont boldSystemFontOfSize:h4Font];
    return label;
}

+ (UILabel *)h4LightGrayLabel {
    UILabel *label = [UILabel singleLineLabel];
    label.font = [UIFont systemFontOfSize:h4Font];
    label.textColor = [UIColor lightGrayColor];
    return label;
}

+ (UILabel *)h5Label {
    UILabel *label = [UILabel singleLineLabel];
    label.font = [UIFont systemFontOfSize:h5Font];
    return label;
}

+ (UILabel *)h5BoldLabel {
    UILabel *label = [UILabel singleLineLabel];
    label.font = [UIFont boldSystemFontOfSize:h5Font];
    return label;
}

+ (UILabel *)h5LightGrayLabel {
    UILabel *label = [UILabel singleLineLabel];
    label.font = [UIFont systemFontOfSize:h5Font];
    label.textColor = [UIColor lightGrayColor];
    return label;
}

+ (UILabel *)h6Label {
    UILabel *label = [UILabel singleLineLabel];
    label.font = [UIFont systemFontOfSize:h6Font];
    return label;
}

+ (UILabel *)h6BoldLabel {
    UILabel *label = [UILabel singleLineLabel];
    label.font = [UIFont boldSystemFontOfSize:h6Font];
    return label;
}

+ (UILabel *)h6LightGrayLabel {
    UILabel *label = [UILabel singleLineLabel];
    label.font = [UIFont systemFontOfSize:h6Font];
    label.textColor = [UIColor lightGrayColor];
    return label;
}

@end
