//
//  HYScanningViewController.h
//  MDPMS
//
//  Created by luculent on 16/6/27.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 扫描界面的基类，实现了，扫描二维码的功能
 */
@interface HYScanningVC : UIViewController <HYScanningViewDelegate>

@property (copy, nonatomic) void(^didScanBlock)(NSString *content);

@end
