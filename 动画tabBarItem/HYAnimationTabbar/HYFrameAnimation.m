//
//  HYFrameAnimation.m
//  HYAnimationTabbar
//
//  Created by 华惠友 on 2018/5/28.
//  Copyright © 2018年 华惠友. All rights reserved.
//

#import "HYFrameAnimation.h"

@interface HYFrameAnimation(){
    NSMutableArray *_contents;
    NSMutableArray *_reversContens;
    
    UIImage *_selectedImage;
}

@end

@implementation HYFrameAnimation

- (void)awakeFromNib
{
    if (!_contents)
    {
        _contents = [NSMutableArray array];
    }
    
    if (!_reversContens)
    {
        _reversContens = [NSMutableArray array];
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Images" ofType:@"plist"];
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSArray *imagesName = dict[@"images"];
    _selectedImage = [UIImage imageNamed:[imagesName lastObject]];
    
    [imagesName enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSString *imageName = obj;
        UIImage *image = [UIImage imageNamed:imageName];
        if (image)
        {
            [_contents addObject:(__bridge id)image.CGImage];
            [_reversContens insertObject:(__bridge id)image.CGImage atIndex:0];
        }
    }];
}

- (void)deselectedAnimation:(UIImageView *)icon textLable:(UILabel *)textLabel {
    [self playFrameAnimation:icon values:_reversContens];
    icon.tintColor = self.defaultColor;
    textLabel.textColor = self.defaultColor;
}

- (void)playAnimation:(UIImageView *)icon textLable:(UILabel *)textLabel {
    [self playFrameAnimation:icon values:_contents];

    icon.tintColor = self.iconSelectedColor;
    textLabel.textColor = self.textSelectedColor;
}

- (void)selectedAnimation:(UIImageView *)icon textLable:(UILabel *)textLabel {
    icon.image = _selectedImage;
    icon.tintColor = self.iconSelectedColor;
    textLabel.textColor = self.textSelectedColor;
}

- (void)playFrameAnimation:(UIImageView *)icon values:(NSArray *)values
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    
    animation.values = values;
    animation.duration = self.duration;
    animation.calculationMode = kCAAnimationCubic;
    
    [icon.layer addAnimation:animation forKey:@"playFrameAnimation"];
}


@end
