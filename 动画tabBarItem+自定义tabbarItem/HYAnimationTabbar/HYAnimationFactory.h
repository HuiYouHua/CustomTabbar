//
//  HYAnimationFactory.h
//  HYAnimationTabbar
//
//  Created by 华惠友 on 2018/5/28.
//  Copyright © 2018年 华惠友. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYAnimationType.h"

@class HYTabbarItemAnimation;
@interface HYAnimationFactory : NSObject

+ (HYTabbarItemAnimation *)animationWithType:(HYAnimationType)animationType;

@end
