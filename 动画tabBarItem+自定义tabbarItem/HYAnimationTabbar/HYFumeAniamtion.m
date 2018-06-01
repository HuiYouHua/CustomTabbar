//
//  HYFumeAniamtion.m
//  HYAnimationTabbar
//
//  Created by 华惠友 on 2018/5/28.
//  Copyright © 2018年 华惠友. All rights reserved.
//

#import "HYFumeAniamtion.h"

@implementation HYFumeAniamtion

- (void)deselectedAnimation:(UIImageView *)icon textLable:(UILabel *)textLabel {
    [self playIconAnimation:icon values:@[@(icon.center.y + 5), @(icon.center.y)]];
    [self playDeselectLabelAnimation:textLabel];
    
    icon.image = [icon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    icon.tintColor = self.defaultColor;
    textLabel.textColor = self.defaultColor;
}

- (void)playAnimation:(UIImageView *)icon textLable:(UILabel *)textLabel {
    [self playIconAnimation:icon values:@[@(icon.center.y), @(icon.center.y + 5), @(icon.center.y)]];
    
    [self playLabelAnimation:textLabel];
    
    icon.image = [icon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    icon.tintColor = self.iconSelectedColor;
    textLabel.textColor = self.textSelectedColor;
}

- (void)selectedAnimation:(UIImageView *)icon textLable:(UILabel *)textLabel {
    // 设置初始选中状态
    [self playIconAnimation:icon values:@[@(icon.center.y), @(icon.center.y + 5), @(icon.center.y)]];
    
    icon.image = [icon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    icon.tintColor = self.iconSelectedColor;
    textLabel.textColor = self.textSelectedColor;
}

- (void)playAnimation:(UIImageView *)icon {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@(1), @[@(1.5)], @[@(0.9)], @[@(0.5)], @[@(0.1)], @[@(1)]];
    animation.duration = self.duration;
    animation.calculationMode = kCAAnimationCubic;
    [icon.layer addAnimation:animation forKey:@"bounceAnimation"];
}

- (void)playIconAnimation:(UIImageView *)icon values:(NSArray *)values
{
    CAKeyframeAnimation *animation = [self createAnimation:@"position.y" duration:self.duration values:values];
    
    [icon.layer addAnimation:animation forKey:@"moveIconAnimation"];
}

- (void)playLabelAnimation:(UILabel *)label
{
    CAKeyframeAnimation *postionAnimation = [self createAnimation:@"position.y" duration:self.duration values:@[@(label.center.y), @(label.center.y - 60)]];
    
    CAKeyframeAnimation *scaleAnimation = [self createAnimation:@"transform.scale" duration:self.duration values:@[@(1), @(2)]];
    
    CAKeyframeAnimation *opacityAnimation = [self createAnimation:@"opacity" duration:self.duration values:@[@(1), @(0)]];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[postionAnimation, scaleAnimation, opacityAnimation];
    
    [label.layer addAnimation:animationGroup forKey:@"playLabelAnimation"];
}

- (void)playDeselectLabelAnimation:(UILabel *)label
{
    CAKeyframeAnimation *postionAnimation = [self createAnimation:@"position.y" duration:self.duration values:@[@(label.center.y + 15), @(label.center.y)]];
    
    CAKeyframeAnimation *opacityAnimation = [self createAnimation:@"opacity" duration:self.duration values:@[@(0), @(1)]];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[postionAnimation, opacityAnimation];
    
    [label.layer addAnimation:animationGroup forKey:@"playDeselectLabelAnimation"];
}

- (CAKeyframeAnimation *)createAnimation:(NSString *)keyPath duration:(CGFloat)duration values:(NSArray *)values
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    
    animation.values = values;
    animation.duration = duration;
    animation.calculationMode = kCAAnimationCubic;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = YES;
    
    return animation;
}

@end
