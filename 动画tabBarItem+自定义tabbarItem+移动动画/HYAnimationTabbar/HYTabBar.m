//
//  HYTabBar.m
//  HYAnimationTabbar
//
//  Created by 华惠友 on 2018/5/28.
//  Copyright © 2018年 华惠友. All rights reserved.
//

#import "HYTabBar.h"
#import "UIView+Extension.h"
#import "Masonry.h"
#import "HYTabbarItem.h"
static const NSInteger imageTag = 100;
static const NSInteger labelTag = 101;

@interface HYTabBar()
@property (nonatomic, strong) NSMutableArray *viewArray;

@end

@implementation HYTabBar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _viewArray = [NSMutableArray arrayWithCapacity:1];;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    

    // 其他位置按钮
    NSUInteger count = self.subviews.count;
    for (NSUInteger i = 0 , j = 0; i < count; i++) {
        UIView *view = self.subviews[i];
        Class class = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:class]) {
            view.width = self.width / 5.0;
            view.x = self.width * j / 5.0;
            j++;
            if (j == 2) {
                j++;
            }
        }
    }
    
    UIButton *publishBtn = [[UIButton alloc] init];
    [publishBtn setBackgroundImage:[UIImage imageNamed:@"post_animate_add"] forState:UIControlStateNormal];
    [publishBtn addTarget:self action:@selector(didClickPublishBtn:) forControlEvents:UIControlEventTouchUpInside];
    publishBtn.adjustsImageWhenHighlighted = NO;
    publishBtn.size = publishBtn.currentBackgroundImage.size;
    publishBtn.centerX = self.width / 2;
    publishBtn.centerY = 0;
    [self addSubview:publishBtn];
    
    UILabel *lable = [[UILabel alloc] init];
    lable.text = @"发布";
    lable.font = [UIFont systemFontOfSize:10];
    [lable sizeToFit];
    lable.centerX = publishBtn.centerX;
    lable.centerY = publishBtn.centerY + publishBtn.height  * 0.7;
    [self addSubview:lable];
    
    
    [self.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        HYTabbarItem *tabBarItem = obj;
        
        UIView *container = [UIView new];
        container.tag = idx;
        container.backgroundColor = [UIColor clearColor];
        container.y = 0;
        container.height = self.height;
        container.width = self.width / 5.0;
        if (idx>1) {
            container.x = self.width * (idx+1) / 5.0;
        } else {
            container.x = self.width * idx / 5.0;
        }
        [self addSubview:container];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [container addGestureRecognizer:tap];
        [_viewArray addObject:container];
        
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
        CGFloat width = self.frame.size.width / self.items.count;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(10);
            make.centerY.equalTo(container).offset(16);
            make.centerX.equalTo(container);
        }];
        
        if (idx == 0) {
            [tabBarItem selectedAnimation:imageView textLable:label];
        }
        
        // 去除原有设置
        tabBarItem.title = @"";
        tabBarItem.image = nil;
    }];
}

- (void)tapClick:(UITapGestureRecognizer *)tap {
    NSInteger currentIndex = tap.view.tag;
    NSUInteger selectedIndex = 0;
    for (int i=0; i<self.items.count; i++) {
        if (self.selectedItem == self.items[i]) {
            selectedIndex = i;
        }
    }
    if (selectedIndex != currentIndex) {
        // 现在选中
        HYTabbarItem *item = (HYTabbarItem *)self.items[currentIndex];
        UIView *view = _viewArray[currentIndex];
        UIImageView *imageView = (UIImageView *)[view viewWithTag:imageTag];
        UILabel *label = (UILabel *)[view viewWithTag:labelTag];
        [item playAnimation:imageView textLable:label];
        
        // 之前选中
        item = (HYTabbarItem *)self.items[selectedIndex];
        view = _viewArray[selectedIndex];
        imageView = (UIImageView *)[view viewWithTag:imageTag];
        label = (UILabel *)[view viewWithTag:labelTag];
        [item deselectedAnimation:imageView textLable:label];
        
        if (self.didClickIndex) {
            self.didClickIndex(currentIndex);
        }
    }
}

// 点击发布
- (void) didClickPublishBtn:(UIButton *) sender {
    if (self.didClickPublishBtn) {
        self.didClickPublishBtn();
    }
}

@end
