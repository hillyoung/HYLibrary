//
//  HYScanningViewController.h
//  MDPMS
//
//  Created by luculent on 16/6/27.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYScanningViewController : UIViewController <HYScanningViewDelegate>

@property (copy, nonatomic) void(^didScanBlock)(NSString *content);

@end
