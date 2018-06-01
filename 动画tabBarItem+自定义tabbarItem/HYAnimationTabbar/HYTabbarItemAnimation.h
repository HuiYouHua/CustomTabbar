//
//  HYTabbarItemAnimation.h
//  HYAnimationTabbar
//
//  Created by 华惠友 on 2018/5/28.
//  Copyright © 2018年 华惠友. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYAnimationProtocol.h"


@interface HYTabbarItemAnimation : NSObject<HYAnimationProtocol>

/* 动画时间 */
@property (nonatomic, assign) CGFloat duration;

/* 默认颜色 */
@property (nonatomic, strong) UIColor *defaultColor;

/* icon选中颜色 */
@property (nonatomic, strong) UIColor *iconSelectedColor;

/* 文字选中颜色 */
@property (nonatomic, strong) UIColor *textSelectedColor;

@end
