//
//  UILabel+HYUIUtils.h
//  GuoDianHeZe
//
//  Created by young on 2017/3/14.
//  Copyright © 2017年 luculent. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const short h1Font;
extern const short h2Font;
extern const short h3Font;
extern const short h4Font;
extern const short h5Font;
extern const short h6Font;

@interface UILabel (HYUIUtils)

+ (UILabel *)singleLineLabel ;

+ (UILabel *)h1Label ;
+ (UILabel *)h1BoldLabel ;
+ (UILabel *)h1LightGrayLabel ;

+ (UILabel *)h2Label ;
+ (UILabel *)h2BoldLabel ;
+ (UILabel *)h2LightGrayLabel ;

+ (UILabel *)h3Label ;
+ (UILabel *)h3BoldLabel ;
+ (UILabel *)h3LightGrayLabel ;

+ (UILabel *)h4Label ;
+ (UILabel *)h4BoldLabel ;
+ (UILabel *)h4LightGrayLabel ;

+ (UILabel *)h5Label ;
+ (UILabel *)h5BoldLabel ;
+ (UILabel *)h5LightGrayLabel ;

+ (UILabel *)h6Label ;
+ (UILabel *)h6BoldLabel ;
+ (UILabel *)h6LightGrayLabel ;

@end
