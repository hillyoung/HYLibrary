//
//  HYAppDelegate.m
//  HYLibrary
//
//  Created by hillyoung on 05/22/2022.
//  Copyright (c) 2022 hillyoung. All rights reserved.
//

#import "HYAppDelegate.h"

@implementation HYAppDelegate

static const int SHIP_SHAPE_IPHONE[30][8] = {
    {0.00, 16.00, 0.00, 8.00, -5.00, -8.00, 5.00, -8.00},
    {0.84, 15.98, 0.42, 7.99, -5.41, -7.73, 4.57, -8.25},
    {1.67, 15.91, 0.84, 7.96, -5.81, -7.43, 4.14, -8.48},
    {2.50, 15.80, 1.25, 7.90, -6.19, -7.12, 3.69, -8.68},
    {3.33, 15.65, 1.66, 7.83, -6.55, -6.79, 3.23, -8.86},
    {4.14, 15.45, 2.07, 7.73, -6.90, -6.43, 2.76, -9.02},
    {4.94, 15.22, 2.47, 7.61, -7.23, -6.06, 2.28, -9.15},
    {5.73, 14.94, 2.87, 7.47, -7.53, -5.68, 1.80, -9.26},
    {6.51, 14.62, 3.25, 7.31, -7.82, -5.27, 1.31, -9.34},
    {7.26, 14.26, 3.63, 7.13, -8.09, -4.86, 0.82, -9.40},
    {8.00, 13.86, 4.00, 6.93, -8.33, -4.43, 0.33, -9.43},
    {8.71, 13.42, 4.36, 6.71, -8.55, -3.99, -0.16, -9.43},
    {9.40, 12.94, 4.70, 6.47, -8.75, -3.53, -0.66, -9.41},
    {10.07, 12.43, 5.03, 6.22, -8.92, -3.07, -1.15, -9.36},
    {10.71, 11.89, 5.35, 5.95, -9.07, -2.60, -1.64, -9.29},
    {11.31, 11.31, 5.66, 5.66, -9.19, -2.12, -2.12, -9.19},
    {11.89, 10.71, 5.95, 5.35, -9.29, -1.64, -2.60, -9.07},
    {12.43, 10.07, 6.22, 5.03, -9.36, -1.15, -3.07, -8.92},
    {12.94, 9.40, 6.47, 4.70, -9.41, -0.66, -3.53, -8.75},
    {13.42, 8.71, 6.71, 4.36, -9.43, -0.16, -3.99, -8.55},
    {13.86, 8.00, 6.93, 4.00, -9.43, 0.33, -4.43, -8.33},
    {14.26, 7.26, 7.13, 3.63, -9.40, 0.82, -4.86, -8.09},
    {14.62, 6.51, 7.31, 3.25, -9.34, 1.31, -5.27, -7.82},
    {14.94, 5.73, 7.47, 2.87, -9.26, 1.80, -5.68, -7.53},
    {15.22, 4.94, 7.61, 2.47, -9.15, 2.28, -6.06, -7.23},
    {15.45, 4.14, 7.73, 2.07, -9.02, 2.76, -6.43, -6.90},
    {15.65, 3.33, 7.83, 1.66, -8.86, 3.23, -6.79, -6.55},
    {15.80, 2.50, 7.90, 1.25, -8.68, 3.69, -7.12, -6.19},
    {15.91, 1.67, 7.96, 0.84, -8.48, 4.14, -7.43, -5.81},
    {15.98, 0.84, 7.99, 0.42, -8.25, 4.57, -7.73, -5.41}
};

static const int SHIP_SHAPE_IPAD[30][8] = {
    {0.00, 20.00, 0.00, 10.00, -6.00, -10.00, 6.00, -10.00},
    {1.05, 19.97, 0.52, 9.99, -6.52, -9.67, 5.47, -10.30},
    {2.09, 19.89, 1.05, 9.95, -7.01, -9.32, 4.92, -10.57},
    {3.13, 19.75, 1.56, 9.88, -7.49, -8.94, 4.36, -10.82},
    {4.16, 19.56, 2.08, 9.78, -7.95, -8.53, 3.79, -11.03},
    {5.18, 19.32, 2.59, 9.66, -8.38, -8.11, 3.21, -11.21},
    {6.18, 19.02, 3.09, 9.51, -8.80, -7.66, 2.62, -11.36},
    {7.17, 18.67, 3.58, 9.34, -9.19, -7.19, 2.02, -11.49},
    {8.13, 18.27, 4.07, 9.14, -9.55, -6.70, 1.41, -11.58},
    {9.08, 17.82, 4.54, 8.91, -9.89, -6.19, 0.81, -11.63},
    {10.00, 17.32, 5.00, 8.66, -10.20, -5.66, 0.20, -11.66},
    {10.89, 16.77, 5.45, 8.39, -10.48, -5.12, -0.41, -11.65},
    {11.76, 16.18, 5.88, 8.09, -10.73, -4.56, -1.02, -11.62},
    {12.59, 15.54, 6.29, 7.77, -10.96, -4.00, -1.63, -11.55},
    {13.38, 14.86, 6.69, 7.43, -11.15, -3.42, -2.23, -11.45},
    {14.14, 14.14, 7.07, 7.07, -11.31, -2.83, -2.83, -11.31},
    {14.86, 13.38, 7.43, 6.69, -11.45, -2.23, -3.42, -11.15},
    {15.54, 12.59, 7.77, 6.29, -11.55, -1.63, -4.00, -10.96},
    {16.18, 11.76, 8.09, 5.88, -11.62, -1.02, -4.56, -10.73},
    {16.77, 10.89, 8.39, 5.45, -11.65, -0.41, -5.12, -10.48},
    {17.32, 10.00, 8.66, 5.00, -11.66, 0.20, -5.66, -10.20},
    {17.82, 9.08, 8.91, 4.54, -11.63, 0.81, -6.19, -9.89},
    {18.27, 8.13, 9.14, 4.07, -11.58, 1.41, -6.70, -9.55},
    {18.67, 7.17, 9.34, 3.58, -11.49, 2.02, -7.19, -9.19},
    {19.02, 6.18, 9.51, 3.09, -11.36, 2.62, -7.66, -8.80},
    {19.32, 5.18, 9.66, 2.59, -11.21, 3.21, -8.11, -8.38},
    {19.56, 4.16, 9.78, 2.08, -11.03, 3.79, -8.53, -7.95},
    {19.75, 3.13, 9.88, 1.56, -10.82, 4.36, -8.94, -7.49},
    {19.89, 2.09, 9.95, 1.05, -10.57, 4.92, -9.32, -7.01},
    {19.97, 1.05, 9.99, 0.52, -10.30, 5.47, -9.67, -6.52}
};

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
//    CGPoint point1 = CGPointMake(0, 16);
//    CGPoint point2 = CGPointMake(0, 8);
//    CGPoint point3 = CGPointMake(-5, -8);
//    CGPoint point4 = CGPointMake(5, -8);
//    [@[@(point1), @(point2), @(point3), @(point4)] enumerateObjectsUsingBlock:^(NSNumber *value, NSUInteger idx, BOOL * _Nonnull stop) {
//        CGPoint point = value.CGPointValue;
//        NSLog(@" 旋转后点 --- %@", NSStringFromCGPoint(CGPointApplyAffineTransform(point, CGAffineTransformMakeRotation(-M_PI/(180.0/90.0)))));
//    }];
//    
//    [self transportPoint:SHIP_SHAPE_IPHONE];
    
    
    return YES;
}

- (void)transportPoint:(void **)points {
    for(int m = 0; m<30; ++m){
        for(int n = 0; n<4; ++n){
            if(n!=0) {
                printf(", ");
            } else {
                printf("{");
            }
            CGPoint point = CGPointMake(SHIP_SHAPE_IPAD[0][2*n], SHIP_SHAPE_IPAD[0][2*n+1]);
            point = CGPointApplyAffineTransform(point, CGAffineTransformMakeRotation(-3*m*M_PI/180.0));
            printf("%.2f, %.2f", point.x, point.y);
        }
        printf("},\n");
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
