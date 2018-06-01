//
//  HYTabbarItem.m
//  HYAnimationTabbar
//
//  Created by 华惠友 on 2018/5/28.
//  Copyright © 2018年 华惠友. All rights reserved.
//

#import "HYTabbarItem.h"
#import "HYTabbarItemAnimation.h"

@implementation HYTabbarItem

- (void)deselectedAnimation:(UIImageView *)icon textLable:(UILabel *)textLabel {
    [self.tabbarItemAnimation deselectedAnimation:icon textLable:textLabel];
}

- (void)playAnimation:(UIImageView *)icon textLable:(UILabel *)textLabel {
    [self.tabbarItemAnimation playAnimation:icon textLable:textLabel];
}

- (void)selectedAnimation:(UIImageView *)icon textLable:(UILabel *)textLabel {
    [self.tabbarItemAnimation selectedAnimation:icon textLable:textLabel];
}


@end
