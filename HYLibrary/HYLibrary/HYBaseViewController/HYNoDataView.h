//
//  HYNoDataView.h
//  MDPMS
//
//  Created by luculent on 16/6/16.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HYNoDataViewTypeData
} HYNoDataViewType;

@interface HYNoDataView : UIView

@property (copy, nonatomic) IBInspectable NSString *title ;

#if TARGET_INTERFACE_BUILDER
@property (nonatomic) NSUInteger type;
#else
@property (nonatomic) HYNoDataViewType type;
#endif

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title ;

@end
