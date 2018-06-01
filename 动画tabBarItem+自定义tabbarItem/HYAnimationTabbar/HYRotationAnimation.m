//
//  HYRotationAnimation.m
//  HYAnimationTabbar
//
//  Created by 华惠友 on 2018/5/28.
//  Copyright © 2018年 华惠友. All rights reserved.
//

#import "HYRotationAnimation.h"

@implementation HYRotationAnimation

- (void)deselectedAnimation:(UIImageView *)icon textLable:(UILabel *)textLabel {
    
    icon.image = [icon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    icon.tintColor = self.defaultColor;
    textLabel.textColor = self.defaultColor;
}

- (void)playAnimation:(UIImageView *)icon textLable:(UILabel *)textLabel {
    [self playRotaionAnimation:icon];
    
    icon.image = [icon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    icon.tintColor = self.iconSelectedColor;
    textLabel.textColor = self.textSelectedColor;
}

- (void)selectedAnimation:(UIImageView *)icon textLable:(UILabel *)textLabel {
    icon.image = [icon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    icon.tintColor = self.iconSelectedColor;
    textLabel.textColor = self.textSelectedColor;
}

- (void)playRotaionAnimation:(UIImageView *)icon
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    
    animation.values = @[@(0), @(M_PI_2), @(M_PI), @(M_PI * 2)];
    animation.duration = self.duration;
    animation.calculationMode = kCAAnimationCubic;
    
    [icon.layer addAnimation:animation forKey:@"playRotaionAnimation"];
}
@end
