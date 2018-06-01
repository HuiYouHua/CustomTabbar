//
//  HYTabbarController.m
//  HYAnimationTabbar
//
//  Created by 华惠友 on 2018/5/28.
//  Copyright © 2018年 华惠友. All rights reserved.
//

#import "HYTabbarController.h"

#import "HYNavigationController.h"
#import "HYViewController.h"
#import "HYTabbarItem.h"

#import "HYAnimationType.h"
#import "HYAnimationFactory.h"
#import "Masonry.h"

#import "HYTabBar.h"
#import "UIView+Extension.h"

#import "HYTestViewController.h"

@interface HYTabbarController ()



@property(nonatomic,strong)UIView *zheZhaoView;
@property(nonatomic,strong)NSMutableArray *btnArr;

@property(nonatomic,strong)UIButton *closeBtn;
@end

@implementation HYTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    [self setupControllers];
    
    HYTabBar *customTabBar = [[HYTabBar alloc] init];
    [self setValue:customTabBar forKey:@"tabBar"];
    
    __weak typeof(self) weakSelf = self;
    [customTabBar setDidClickPublishBtn:^{
        weakSelf.zheZhaoView = [[UIView alloc] init];
        
        weakSelf.zheZhaoView.backgroundColor = [UIColor blackColor];
        weakSelf.zheZhaoView.alpha = 0.8;
        weakSelf.zheZhaoView.frame = [UIScreen mainScreen].bounds;
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:weakSelf.zheZhaoView];
        
        self.closeBtn = [[UIButton alloc] init];
        [self.closeBtn setBackgroundImage:[UIImage imageNamed:@"post_animate_add"] forState:UIControlStateNormal];
        self.closeBtn.size = self.closeBtn.currentBackgroundImage.size;
        self.closeBtn.centerX = weakSelf.view.width / 2;
        self.closeBtn.centerY = weakSelf.view.height - weakSelf.tabBar.size.height;
        [self.closeBtn addTarget:self action:@selector(didClickCloseBtn) forControlEvents:UIControlEventTouchUpInside];
        
        [weakSelf.zheZhaoView addSubview:self.closeBtn];
        
        UITapGestureRecognizer *tapView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickView)];
        [weakSelf.zheZhaoView addGestureRecognizer:tapView];
        
    }];
    
    [customTabBar setDidClickIndex:^(NSInteger index) {
        self.selectedIndex = index;
    }];
}

- (void) didClickView {
    [self.zheZhaoView removeFromSuperview];
}

- (void) didClickCloseBtn {
    [self.zheZhaoView removeFromSuperview];
}

/* 设置控制器 */
- (void)setupControllers {
    NSArray *titleArray = @[@"主页", @"鱼塘", @"消息", @"我的"];
    NSArray *imageArray = @[@"home_normal", @"fishpond_normal", @"message_normal", @"account_normal"];
    int animationArray[4] = {FumeAnimationType, BounceAnimationType, RotationAnimationType, TransitionAnimationType};
    
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (int i=0; i<titleArray.count; i++) {
        UIViewController *vc = nil;
        if (i == 0) {
            vc = [HYTestViewController new];
        } else {
            vc = [HYViewController new];
        }
        HYNavigationController *nav = [self setupOneController:vc title:titleArray[i] imageName:imageArray[i] animationType:animationArray[i]];
        [viewControllers addObject:nav];
    }
    self.viewControllers = viewControllers;
    
}

- (HYNavigationController *)setupOneController:(UIViewController *)vc title:(NSString *)title imageName:(NSString *)imageName animationType:(HYAnimationType)animationType {
    HYNavigationController *nav = [[HYNavigationController alloc] initWithRootViewController:vc];
    HYTabbarItem *item = [[HYTabbarItem alloc] init];
    item.tabbarItemAnimation = [HYAnimationFactory animationWithType:animationType];
    item.title = title;
    item.image = [UIImage imageNamed:imageName];
    vc.tabBarItem = item;
    vc.title = title;
    return nav;
}


@end
















