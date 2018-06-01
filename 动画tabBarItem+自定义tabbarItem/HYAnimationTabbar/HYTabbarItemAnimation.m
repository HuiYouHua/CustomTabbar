//
//  HYTabbarItemAnimation.m
//  HYAnimationTabbar
//
//  Created by 华惠友 on 2018/5/28.
//  Copyright © 2018年 华惠友. All rights reserved.
//

#import "HYTabbarItemAnimation.h"

@implementation HYTabbarItemAnimation

- (instancetype)init {
    self = [super init];
    if (self) {
        _duration = 0.3f;
        _defaultColor = [UIColor blackColor];
        _iconSelectedColor = [UIColor orangeColor];
        _textSelectedColor = [UIColor orangeColor];
    }
    return self;
}

- (void)deselectedAnimation:(UIImageView *)icon textLable:(UILabel *)textLabel {
    
}

- (void)playAnimation:(UIImageView *)icon textLable:(UILabel *)textLabel {
    
}

- (void)selectedAnimation:(UIImageView *)icon textLable:(UILabel *)textLabel {
    
}

@end
