//
//  HYAnimationFactory.m
//  HYAnimationTabbar
//
//  Created by 华惠友 on 2018/5/28.
//  Copyright © 2018年 华惠友. All rights reserved.
//

#import "HYAnimationFactory.h"

#import "HYFumeAniamtion.h"
#import "HYBounceAnimation.h"
#import "HYRotationAnimation.h"
#import "HYFrameAnimation.h"
#import "HYTransitionAnimation.h"

@implementation HYAnimationFactory

+ (HYTabbarItemAnimation *)animationWithType:(HYAnimationType)animationType {
    switch (animationType) {
        case FumeAnimationType:
            return [HYFumeAniamtion new];
            break;
            
        case BounceAnimationType:
            return [HYBounceAnimation new];
            break;
            
        case RotationAnimationType:
            return [HYRotationAnimation new];
            break;
            
        case FrameAnimationType:
            return [HYFrameAnimation new];
            break;
            
        case TransitionAnimationType:
            return [HYTransitionAnimation new];
            break;
            
        default:
            break;
    }
}

@end
