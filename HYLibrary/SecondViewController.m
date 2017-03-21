//
//  SecondViewController.m
//  HYLibrary
//
//  Created by luculent on 16/7/29.
//  Copyright © 2016年 hillyoung. All rights reserved.
//

#import "SecondViewController.h"
#import "TestStickyViewController.h"

@implementation SecondViewController

- (IBAction)toucheDismiss:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
    TestStickyViewController *VC = [[TestStickyViewController alloc] init];
    [self presentViewController:VC animated:YES completion:nil];
}

@end
