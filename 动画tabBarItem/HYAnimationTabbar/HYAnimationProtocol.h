//
//  HYAnimationProtocol.h
//  HYAnimationTabbar
//
//  Created by 华惠友 on 2018/5/28.
//  Copyright © 2018年 华惠友. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol HYAnimationProtocol <NSObject>

/* 选中状态 */
- (void)selectedAnimation:(UIImageView *)icon textLable:(UILabel *)textLabel;

/* 由未选中状态变为选中 */
- (void)playAnimation:(UIImageView *)icon textLable:(UILabel *)textLabel;

/* 由选中状态变为未选中 */
- (void)deselectedAnimation:(UIImageView *)icon textLable:(UILabel *)textLabel;

@end
