//
//  HYTabbarItem.h
//  HYAnimationTabbar
//
//  Created by 华惠友 on 2018/5/28.
//  Copyright © 2018年 华惠友. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYAnimationProtocol.h"

@class HYTabbarItemAnimation;

@interface HYTabbarItem : UITabBarItem<HYAnimationProtocol>

@property (nonatomic, strong) HYTabbarItemAnimation *tabbarItemAnimation;

@end
