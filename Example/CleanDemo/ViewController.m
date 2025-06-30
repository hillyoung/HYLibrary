//
//  ViewController.m
//  CleanDemo
//
//  Created by hb28130 on 30/6/2025.
//  Copyright © 2025 hillyoung. All rights reserved.
//

#import "ViewController.h"
#import <HYAppInfo/HYAppInfo.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [HYAppInfo loadAppInfo:^(NSDictionary *appInfo) {
        NSLog(@" 采集列表 \n %@", appInfo);
    }];
}


@end
