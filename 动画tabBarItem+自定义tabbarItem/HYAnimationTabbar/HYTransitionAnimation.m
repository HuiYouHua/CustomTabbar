//
//  HYTransitionAnimation.m
//  HYAnimationTabbar
//
//  Created by 华惠友 on 2018/5/28.
//  Copyright © 2018年 华惠友. All rights reserved.
//

#import "HYTransitionAnimation.h"

@implementation HYTransitionAnimation

- (void)deselectedAnimation:(UIImageView *)icon textLable:(UILabel *)textLabel {
    
    icon.image = [icon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    icon.tintColor = self.defaultColor;
    textLabel.textColor = self.defaultColor;
}

- (void)playAnimation:(UIImageView *)icon textLable:(UILabel *)textLabel {
    [self playTransitionAnimation:icon];
    
    icon.image = [icon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    icon.tintColor = self.iconSelectedColor;
    textLabel.textColor = self.textSelectedColor;
}

- (void)selectedAnimation:(UIImageView *)icon textLable:(UILabel *)textLabel {
    icon.image = [icon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    icon.tintColor = self.iconSelectedColor;
    textLabel.textColor = self.textSelectedColor;
}

- (void)playTransitionAnimation:(UIImageView *)icon
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.y"];
    
    animation.values = @[@(0), @(M_PI_2), @(M_PI), @(M_PI * 2)];
    animation.duration = self.duration;
    animation.calculationMode = kCAAnimationCubic;
    
    [icon.layer addAnimation:animation forKey:@"playTransitionAnimation"];
    
    return;
    
    [UIView transitionWithView:icon duration:self.duration options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        NSLog(@"12");
    } completion:^(BOOL finished) {
        
    }];
}

@end
