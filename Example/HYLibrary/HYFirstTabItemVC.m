//
//  HYFirstTabItemVC.m
//  HYLibrary_Example
//
//  Created by 杨小山 on 2024/1/16.
//  Copyright © 2024 hillyoung. All rights reserved.
//

#import "HYFirstTabItemVC.h"
#import <objc/runtime.h>
#import <HYAppInfo.h>


@interface NSBundle (Collect)

- (NSDictionary *)tmpInfoDictionary ;

@end

@implementation NSBundle (Collect)

- (NSDictionary *)tmpInfoDictionary {
    return @{
        @"key":@"测试"
    };
}

@end


@interface HYFirstTabItemVC ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation HYFirstTabItemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    UIButton *btn = [UIButton new];
    btn.frame = CGRectMake(100, 100, 100, 50);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"测试" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 350, 200, 200)];
    self.imageView.backgroundColor = [UIColor blackColor];
    self.imageView.contentMode = UIViewContentModeCenter;
    [self.view addSubview:self.imageView];
    
    
    [HYAppInfo loadAppInfo:^(NSDictionary *appInfo) {
        NSLog(@" 本地安装的应用列表 %@", appInfo);
    }];
    
    NSMutableArray *encodedArr = [NSMutableArray array];
    [@[@"ecapskroWnoitacilppASL", @"ecapskroWtluafed", @"snigulPdellatsni", @"eldnuBgniniatnoc", @"reifitnedIeldnub", @"emaNmeti"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [encodedArr addObject:[obj encodedBase10String]];
    }];
    NSMutableArray *decodedArr = [NSMutableArray array];
    [encodedArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [decodedArr addObject:[obj decodedBase100String]];
    }];
    
    NSString *base100 = [@"abcedf" encodedBase10String];
    NSLog(@"表情包  %@", base100);
    NSString *decodeBase100 = [base100 decodedBase100String];
    NSLog(@"解密表情包 %@", decodeBase100);
    
    
//    [HYFirstTabItemVC methodSwizzleWithOrigTarget:NSBundle.class OrigSel:@selector(infoDictionary) newSel:@selector(tmpInfoDictionary)];
}

- (void)buttonAction {
    NSLog(@"");
    
    
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    
    [self customImage];
}


- (void)customImage {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100, 100), YES, 2.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextAddRect(ctx, CGRectMake(0, 0, 50, 50));
    CGContextMoveToPoint(ctx, 0, 50);
    CGContextAddLineToPoint(ctx, 100, 50);
    CGContextSetLineWidth(ctx, 1.0);
//    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
//    CGContextFillPath(ctx);
    CGContextStrokePath(ctx);
    
    
    CGContextSetLineWidth(ctx, 0.3);
    CGContextMoveToPoint(ctx, 0, 60);
    CGContextAddLineToPoint(ctx, 100, 60);
    CGContextStrokePath(ctx);


    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.imageView.image = image;
}

+(void) methodSwizzleWithOrigTarget:(Class)origTarget OrigSel:(SEL)origSel newSel:(SEL)newSel
{
   //类对象（实例方法存储在类对象中）
    Class origClass = origTarget;
    if ([origTarget isKindOfClass:[origTarget class]]) {//成立则origTarget为实例对象
        origClass = object_getClass(origTarget);
    }
    //方法
    Method origMethod = class_getInstanceMethod(origClass, origSel);
    Method newMethod = class_getInstanceMethod(origClass, newSel);
    if (!origMethod) {//原方法没实现
        class_addMethod(origClass, origSel, imp_implementationWithBlock(^(id self, SEL _cmd){}), "v16@0:8");
        origMethod = class_getInstanceMethod(origClass, origSel);
    }
    
    //imp
    IMP origIMP = method_getImplementation(origMethod);
    IMP newIMP = method_getImplementation(newMethod);
    
    //方法添加成功代表target中不包含原方法，可能是其父类包含(交换父类方法可能有意想不到的问题)
    if(class_addMethod(origClass, origSel, origIMP, method_getTypeEncoding(origMethod))){
        //直接替换新添加的方法
        class_replaceMethod(origClass, origSel, newIMP, method_getTypeEncoding(newMethod));
    }else{
        method_setImplementation(origMethod, newIMP);
        method_setImplementation(newMethod, origIMP);
    }
}

@end
