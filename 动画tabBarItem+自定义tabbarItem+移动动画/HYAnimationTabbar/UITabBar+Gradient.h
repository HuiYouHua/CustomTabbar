//
//  UITabBar+Gradient.h
//  tabBarText
//
//  Created by apple on 2016/11/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, StatusBarStatusType) {
    StatusBarStatusTypeOfNormal = 0,
    StatusBarStatusTypeOfHidden,
    StatusBarStatusTypeOfShow,
};

@interface UITabBar (Gradient)
- (void)fj_setImageViewAlpha:(CGFloat)alpha;

- (void)fj_setTranslationY:(CGFloat)translationY;

- (void)fj_moveByTranslationY:(CGFloat)translationY;

@end
