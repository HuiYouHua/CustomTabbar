//
//  HYTabBar.h
//  HYAnimationTabbar
//
//  Created by 华惠友 on 2018/5/28.
//  Copyright © 2018年 华惠友. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYTabBar : UITabBar
@property (nonatomic,copy) void(^didClickPublishBtn)(void);
@property (nonatomic,copy) void(^didClickIndex)(NSInteger index);
@end
