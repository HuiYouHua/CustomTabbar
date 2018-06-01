//
//  HYTestViewController.m
//  HYAnimationTabbar
//
//  Created by 华惠友 on 2018/5/29.
//  Copyright © 2018年 华惠友. All rights reserved.
//

#import "HYTestViewController.h"
#import "UINavigationBar+Gradient.h"
#import "UITabBar+Gradient.h"

//获取当前屏幕的宽高
#define  kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define  kScreenHeight [[UIScreen mainScreen] bounds].size.height

//动画默认时间
#define kDefaultAnimationTime 0.3

//navigationBarHeight的高度
#define   kNavigationBarHeight 64

//statusBar的高度
#define   kStatusBarHeight self.tabBarController.tabBar.frame.size.height

@interface HYTestViewController ()<UITableViewDataSource,UITableViewDelegate>{
    CGFloat _originalOffsetY; //上一次偏移量
}

@property (strong , nonatomic) UITableView * tableView;

@end

@implementation HYTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSInteger aRedValue = arc4random() % 255;
    NSInteger aGreenValue = arc4random() % 255;
    NSInteger aBlueValue = arc4random() % 255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue / 255.0f green:aGreenValue / 255.0f blue:aBlueValue / 255.0f alpha:1.0f];
    
    self.view.backgroundColor = randColor;
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"数据-%ld", (long)indexPath.row];
    NSInteger aRedValue = arc4random() % 255;
    NSInteger aGreenValue = arc4random() % 255;
    NSInteger aBlueValue = arc4random() % 255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue / 255.0f green:aGreenValue / 255.0f blue:aBlueValue / 255.0f alpha:1.0f];
    cell.contentView.backgroundColor = randColor;
    return cell;
}

#pragma mark --- UIScrollViewDelegate ---
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat bottomOffset = scrollView.contentSize.height - scrollView.contentOffset.y - scrollView.frame.size.height;
    if (scrollView.contentOffset.y > - (2*kNavigationBarHeight) && bottomOffset > 0) {
        CGFloat offsetY = scrollView.contentOffset.y - _originalOffsetY;
        [self moveNavigationBarAndStatusBarByOffsetY:offsetY];
    }
    _originalOffsetY = scrollView.contentOffset.y;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self restoreNavigationBarAndStatusBarWithContentOffset:scrollView.contentOffset];
}

#pragma mark --- offset way
// 显示navigationBar 和 tabbar
- (void)showNavigationBarAndStatusBar{
    [self setNavigationBarTransformProgress:0 navigationBarStatusType:NavigationBarStatusOfTypeShow];
    [self setStatusBarTransformProgress:0 statusBarStatusType:StatusBarStatusTypeOfShow];
}

//隐藏navigationBar 和 tabbar
- (void)hideNavigationBarAndStatusBar{
    [self setNavigationBarTransformProgress:1 navigationBarStatusType:NavigationBarStatusOfTypeHidden];
    [self setStatusBarTransformProgress:1 statusBarStatusType:StatusBarStatusTypeOfHidden];
}

//恢复或隐藏navigationBar和statusBar
- (void)restoreNavigationBarAndStatusBarWithContentOffset:(CGPoint)contentOffset {
    CGFloat navigationBarCenterHeight  = kNavigationBarHeight/2.0;
    CGFloat transformTy = self.navigationController.navigationBar.transform.ty;
    if (transformTy < 0 && transformTy > -kNavigationBarHeight) {
        if (transformTy < -navigationBarCenterHeight && contentOffset.y > -navigationBarCenterHeight) {
            [UIView animateWithDuration:kDefaultAnimationTime animations:^{
                [self hideNavigationBarAndStatusBar];
            }];
            
        }else {
            [UIView animateWithDuration:kDefaultAnimationTime animations:^{
                [self showNavigationBarAndStatusBar];
            }];
        }
    }
}

// 通过偏移量移动NavigationBar和StatusBar
- (void)moveNavigationBarAndStatusBarByOffsetY:(CGFloat)offsetY {
    CGFloat transformTy = self.navigationController.navigationBar.transform.ty;
    CGFloat tabbarTransformTy = self.tabBarController.tabBar.transform.ty;
    
    // offset 向上滚动
    if (offsetY > 0) {
        if (fabs(transformTy) >= kNavigationBarHeight) {
            //当NavigationBar的transfrom.ty大于NavigationBar高度，导航栏离开可视范围，设置NavigationBar隐藏
            [self setNavigationBarTransformProgress:1 navigationBarStatusType:NavigationBarStatusOfTypeHidden];
        } else {
            //当NavigationBar的transfrom.ty小于NavigationBar高度，导航栏在可视范围内，设置NavigationBar偏移位置和背景透明度
            [self setNavigationBarTransformProgress:offsetY navigationBarStatusType:NavigationBarStatusOfTypeNormal];
        }
        
        if (fabs(tabbarTransformTy) >= kStatusBarHeight) {
            //当StatusTabBar的transfrom.ty大于StatusTabBar高度，导航栏离开可视范围，设置StatusTabBar隐藏
            [self setStatusBarTransformProgress:1 statusBarStatusType:StatusBarStatusTypeOfHidden];
        } else {
            //当当StatusTabBar的transfrom.ty小于StatusTabBar高度，导航栏在可视范围内，设置StatusTabBar偏移位置和背景透明度
            [self setStatusBarTransformProgress:offsetY statusBarStatusType:StatusBarStatusTypeOfNormal];
        }
        // offset 向下滚动
    } else if(offsetY < 0){
        if (transformTy < 0 && fabs(transformTy) <= kNavigationBarHeight) {
            //当NavigationBar的transfrom.ty小于NavigationBar高度，导航栏进入可视范围内，设置NavigationBar偏移位置和背景透明度
            [self setNavigationBarTransformProgress:offsetY navigationBarStatusType:NavigationBarStatusOfTypeNormal];
        } else {
            //当NavigationBar的transfrom.ty超过NavigationBar原来位置，设置NavigationBar显示
            [self setNavigationBarTransformProgress:0 navigationBarStatusType:NavigationBarStatusOfTypeShow];
        }
        
        if (tabbarTransformTy <= kStatusBarHeight && tabbarTransformTy > 0) {
            //当StatusTabBar的transfrom.ty小于StatusTabBar高度，导航栏进入可视范围内，设置StatusTabBar偏移位置和背景透明度
            [self setStatusBarTransformProgress:offsetY statusBarStatusType:StatusBarStatusTypeOfNormal];
        } else {
            //当StatusTabBar的transfrom.ty超过StatusTabBar原来位置，设置StatusTabBar显示
            [self setStatusBarTransformProgress:0 statusBarStatusType:StatusBarStatusTypeOfShow];
        }
    }
    
}

// 根据传入的类型和渐变程度,改变StatusBar的颜色和位置
- (void)setStatusBarTransformProgress:(CGFloat)progress statusBarStatusType:(StatusBarStatusType)statusBarStatusType{
    CGFloat transfromTy = self.tabBarController.tabBar.transform.ty;
    if (statusBarStatusType == StatusBarStatusTypeOfHidden) {
        if (transfromTy != kStatusBarHeight) {
            [self.tabBarController.tabBar fj_moveByTranslationY:kStatusBarHeight * progress];
            [self.tabBarController.tabBar fj_setImageViewAlpha:progress];
        }
    }else if(statusBarStatusType == StatusBarStatusTypeOfNormal) {
        [self.tabBarController.tabBar fj_setTranslationY:-progress];
        CGFloat alpha = 1 - fabs(self.tabBarController.tabBar.transform.ty)/kStatusBarHeight;
        [self.tabBarController.tabBar fj_setImageViewAlpha:alpha];
    }else if(statusBarStatusType == StatusBarStatusTypeOfShow) {
        if (transfromTy != 0) {
            [self.tabBarController.tabBar fj_moveByTranslationY: -kStatusBarHeight * progress];
            [self.tabBarController.tabBar fj_setImageViewAlpha:(1-progress)];
        }
    }
}

// 根据传入的类型和渐变程度,改变NavigationBar的颜色和位置
- (void)setNavigationBarTransformProgress:(CGFloat)progress navigationBarStatusType:(NavigationBarStatusType)navigationBarStatusType{
    CGFloat transfromTy = self.navigationController.navigationBar.transform.ty;
    if (navigationBarStatusType == NavigationBarStatusOfTypeHidden) {
        if(transfromTy != -kNavigationBarHeight){
            [self.navigationController.navigationBar fj_moveByTranslationY:-kNavigationBarHeight * progress];
            [self.navigationController.navigationBar fj_setImageViewAlpha:progress];
        }
    }else if(navigationBarStatusType == NavigationBarStatusOfTypeNormal) {
        [self.navigationController.navigationBar fj_setTranslationY: - progress];
        CGFloat alpha = 1 - fabs(self.navigationController.navigationBar.transform.ty)/kNavigationBarHeight;
        [self.navigationController.navigationBar fj_setImageViewAlpha:alpha];
    }else if(navigationBarStatusType == NavigationBarStatusOfTypeShow) {
        if(transfromTy != 0){
            [self.navigationController.navigationBar fj_moveByTranslationY:-kNavigationBarHeight * progress];
            [self.navigationController.navigationBar fj_setImageViewAlpha:(1-progress)];
        }
    }
}

   

@end










