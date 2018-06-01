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

#import "UIView+Extension.h"

static const NSInteger imageTag = 100;
static const NSInteger labelTag = 101;


@interface HYTabbarController ()

@property (nonatomic, strong) NSMutableArray *viewArray;

@end

@implementation HYTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];

    _viewArray = [NSMutableArray arrayWithCapacity:1];;
    
    [self setupControllers];
    [self setUpTabbarItem];
    [self createCustomIcons];
    
}

/* 设置控制器 */
- (void)setupControllers {
    NSArray *titleArray = @[@"主页", @"鱼塘", @"消息", @"我的"];
    NSArray *imageArray = @[@"home_normal", @"fishpond_normal", @"message_normal", @"account_normal"];
    int animationArray[4] = {FumeAnimationType, BounceAnimationType, RotationAnimationType, TransitionAnimationType};
    
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (int i=0; i<titleArray.count; i++) {
        HYViewController *vc = [HYViewController new];
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

/* 创建tabbarItem上的视图 */
- (void)setUpTabbarItem {
    NSInteger count = self.tabBar.items.count;
    for (int i=0; i<count; i++) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.height.equalTo(self.tabBar);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [view addGestureRecognizer:tap];
        
        [_viewArray addObject:view];
    }
    [_viewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
}

- (void)tapClick:(UITapGestureRecognizer *)tap {
    NSInteger currentIndex = tap.view.tag;
    if (self.selectedIndex != currentIndex) {
        // 现在选中
        HYTabbarItem *item = (HYTabbarItem *)self.tabBar.items[currentIndex];
        UIView *view = _viewArray[currentIndex];
        UIImageView *imageView = (UIImageView *)[view viewWithTag:imageTag];
        UILabel *label = (UILabel *)[view viewWithTag:labelTag];
        [item playAnimation:imageView textLable:label];
        
        // 之前选中
        item = (HYTabbarItem *)self.tabBar.items[self.selectedIndex];
        view = _viewArray[self.selectedIndex];
        imageView = (UIImageView *)[view viewWithTag:imageTag];
        label = (UILabel *)[view viewWithTag:labelTag];
        [item deselectedAnimation:imageView textLable:label];
        
        self.selectedIndex = currentIndex;
    }
}

/**
 *  创建tabbar的图片和label
 */
- (void)createCustomIcons {
    [self.tabBar.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        HYTabbarItem *tabBarItem = obj;
        
        UIView *container = _viewArray[idx];
        container.tag = idx;
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:tabBarItem.image];
        imageView.tag = imageTag;
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [container addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(tabBarItem.image.size.width);
            make.height.mas_equalTo(tabBarItem.image.size.height);
            make.centerY.equalTo(container).offset(-5);
            make.centerX.equalTo(container);
        }];
        
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = labelTag;
        label.text = tabBarItem.title;
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [container addSubview:label];
        
        CGFloat width = self.tabBar.frame.size.width / self.tabBar.items.count;
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(10);
            make.centerY.equalTo(container).offset(16);
            make.centerX.equalTo(container);
        }];
        
        if (idx == 0)
        {
            [tabBarItem selectedAnimation:imageView textLable:label];
        }
        
        // 去除原有设置
        tabBarItem.title = @"";
        tabBarItem.image = nil;
    }];
}

@end
















