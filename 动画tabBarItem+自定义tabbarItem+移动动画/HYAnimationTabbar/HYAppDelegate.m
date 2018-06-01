//
//  HYAppDelegate.m
//  HYAnimationTabbar
//
//  Created by 华惠友 on 2018/5/28.
//  Copyright © 2018年 华惠友. All rights reserved.
//

#import "HYAppDelegate.h"

#import "HYTabbarController.h"

@interface HYAppDelegate ()

@end

@implementation HYAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    HYTabbarController *tabVc = [HYTabbarController new];
    self.window.rootViewController = tabVc;
    [self.window makeKeyAndVisible];
    return YES;
}
@end
