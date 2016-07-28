//
//  HYNoDataView.m
//  MDPMS
//
//  Created by luculent on 16/6/16.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "HYNoDataView.h"

@interface NoDataDrawView : UIView

//@property (strong, nonatomic) NSArray *points;
@property (nonatomic) HYNoDataViewType type;

@end

@implementation NoDataDrawView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    [self setupUI];
}

- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *bezierPath = nil;

    CGFloat width = CGRectGetWidth(rect);
    CGFloat height = width/2.-5;
    
    if (self.type == HYNoDataViewTypeData) {
        CGFloat gap = 1;
        CGFloat controlGap = (CGRectGetHeight(rect))/5.;
        CGFloat originX = gap;
        CGFloat OriginY = controlGap*4;
        //画椭圆
        bezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(gap, gap, width-2*gap, height)];

        //左侧竖线
        [bezierPath moveToPoint:CGPointMake(originX, height/2.)];
        [bezierPath addLineToPoint:CGPointMake(originX*2, OriginY)];

        //添加底部弧线
        originX = width-gap*2;
        [bezierPath addQuadCurveToPoint:CGPointMake(originX, OriginY) controlPoint:CGPointMake(width/2., CGRectGetHeight(rect))];

        //添加右侧竖线
//        [bezierPath moveToPoint:CGPointMake(width-gap*2, height)];
        originX = width-gap;
        height = width/2.;
        OriginY = height/2.;
        [bezierPath addLineToPoint:CGPointMake(originX, OriginY)];
        
        //内部第一条弧线
        originX = gap;
        [bezierPath moveToPoint:CGPointMake(originX*2, controlGap*2)];
        originX = width-originX*2;
        [bezierPath addQuadCurveToPoint:CGPointMake(originX, controlGap*2) controlPoint:CGPointMake(width/2., controlGap*3)];
        
        //内部第二条弧线
        originX = gap;
        [bezierPath moveToPoint:CGPointMake(originX*2, controlGap*3)];
        originX = width-originX*2;
        [bezierPath addQuadCurveToPoint:CGPointMake(originX, controlGap*3) controlPoint:CGPointMake(width/2, controlGap*4)];
        
        //第一个原点
        originX = width/4.*3;
        [bezierPath moveToPoint:CGPointMake(originX, controlGap*2)];
        [bezierPath addArcWithCenter:CGPointMake(originX, controlGap*2) radius:1 startAngle:0 endAngle:M_PI*2 clockwise:YES];
        
        //第二个原点
        [bezierPath moveToPoint:CGPointMake(originX, controlGap*3)];
        [bezierPath addArcWithCenter:CGPointMake(originX, controlGap*3) radius:1 startAngle:0 endAngle:M_PI*2 clockwise:YES];
        
        //第三个原点
        [bezierPath moveToPoint:CGPointMake(originX, controlGap*4)];
        [bezierPath addArcWithCenter:CGPointMake(originX, controlGap*4) radius:1 startAngle:0 endAngle:M_PI*2 clockwise:YES];
        
    } else {
        bezierPath = [UIBezierPath bezierPath];
    }
    
    [[UIColor lightGrayColor] set];

    [bezierPath stroke];
    
}

#pragma mark - Private

- (void)setupUI {
    self.backgroundColor = [UIColor clearColor];
}

- (void)updatePoints {
    

    
}

#pragma mark - Setter && Getter

- (void)setType:(HYNoDataViewType)type {
    _type = type;
}

@end

@interface HYNoDataView ()

@property (strong, nonatomic) UILabel *titleLabel ;
@property (strong, nonatomic) NoDataDrawView *drawView;

@end

@implementation HYNoDataView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title {
    if (self=[super initWithFrame:frame]) {
        
        _title = title;
        
        [self setupUI];
        [self updateLabelTitle:title];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super  awakeFromNib];
    
    [self setupUI];
}

#pragma mark - Private

- (void)updateLabelTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)setupUI {
    
    [self addSubview:self.drawView];
    [self.drawView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.mas_centerY).offset(-20);
        make.size.mas_equalTo(CGSizeMake(50, 70));
        make.centerX.equalTo(self.mas_centerX);
        
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.drawView.mas_bottom).offset(10);
        make.width.equalTo(self.mas_width);
        make.height.mas_equalTo(14);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
}



#pragma mark - Setter && Getter

- (void)setType:(HYNoDataViewType)type {
    _type = type;
    
    self.drawView.type = _type;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    [self updateLabelTitle:_title];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor lightGrayColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }

    return _titleLabel;
}

- (NoDataDrawView *)drawView {
    if (!_drawView) {
        _drawView = [[NoDataDrawView alloc] init];
    }
    
    return _drawView;
}

@end
