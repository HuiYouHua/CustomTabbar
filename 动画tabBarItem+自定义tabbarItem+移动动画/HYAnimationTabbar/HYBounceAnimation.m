//
//  HYBounceAnimation.m
//  HYAnimationTabbar
//
//  Created by 华惠友 on 2018/5/28.
//  Copyright © 2018年 华惠友. All rights reserved.
//

#import "HYBounceAnimation.h"

@implementation HYBounceAnimation

- (void)deselectedAnimation:(UIImageView *)icon textLable:(UILabel *)textLabel {
    
    icon.image = [icon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    icon.tintColor = self.defaultColor;
    textLabel.textColor = self.defaultColor;
}

- (void)playAnimation:(UIImageView *)icon textLable:(UILabel *)textLabel {
    [self playBounceAnimation:icon];
    
    icon.image = [icon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    icon.tintColor = self.iconSelectedColor;
    textLabel.textColor = self.textSelectedColor;
}

- (void)selectedAnimation:(UIImageView *)icon textLable:(UILabel *)textLabel {
    icon.image = [icon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    icon.tintColor = self.defaultColor;
    textLabel.textColor = self.defaultColor;
}

- (void)playBounceAnimation:(UIImageView *)icon
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.values = @[@(1), @(1.5), @(0.9), @(0.5), @(0.1), @(1)];
    animation.duration = self.duration;
    animation.calculationMode = kCAAnimationCubic;
    
    [icon.layer addAnimation:animation forKey:@"playBounceAnimation"];
}

@end
