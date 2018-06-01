//
//  UINavigationBar+Gradient.h
//  tabBarText
//
//  Created by apple on 2016/11/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NavigationBarStatusType) {
    NavigationBarStatusOfTypeNormal = 0,
    NavigationBarStatusOfTypeHidden,
    NavigationBarStatusOfTypeShow,
};

@interface UINavigationBar (Gradient)
// 设置背景图透明度
- (void)fj_setImageViewAlpha:(CGFloat)alpha;
// 根据translationY在原来位置上偏移
- (void)fj_setTranslationY:(CGFloat)translationY;
// 设置偏移translationY
- (void)fj_moveByTranslationY:(CGFloat)translationY;
@end
