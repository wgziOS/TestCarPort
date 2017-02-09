//
//  XMGTabBarController.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/5.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import "XMGTabBarController.h"
#import "XMGTabBar.h"
#import "XMGNavigationController.h"

#import "MainViewController.h"
#import "CarOwnerViewController.h"
#import "MeViewController.h"
#import "PublishCarPortViewController.h"

@interface XMGTabBarController() <YQContentViewControllerDelegate,YQContentViewControllerDelegate>
@end

@implementation XMGTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [UINavigationBar appearance];
    
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.086 green:0.51 blue:0.91 alpha:1.0f];

   
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // 添加子控制器
    [self setupChildVc:[[MainViewController alloc] init] title:@"首页" image:@"cdl-sy-icon" selectedImage:@"cdl-sy-dj-icon"];
    
//    [self setupChildVc:[[FindCarPortViewController alloc] init] title:@"找车位" image:@"dbdh_02" selectedImage:@"dbdh_06"];
    
    [self setupChildVc:[[NearbyCarportViewController alloc] init] title:@"查找车位" image:@"cdl-czcw-icon" selectedImage:@"cdl-czcw-dj-icon"];
    
    [self setupChildVc:[[PublishCarPortViewController alloc] init] title:@"车位登记" image:@"cdl-cwdj-cion" selectedImage:@"cdl-cwdj-dj-icon"];
    
    [self setupChildVc:[[MeViewController alloc] init] title:@"我的中心" image:@"cdl-wdzx-cion" selectedImage:@"cdl-wdzx-dj-icon"];
    
    // 更换tabBar
    [self setValue:[[XMGTabBar alloc] init] forKeyPath:@"tabBar"];
}

- (UINavigationController *)yq_navigationController {
    return self.selectedViewController;
}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{

    // 设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
   
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    XMGNavigationController *nav = [[XMGNavigationController alloc] initWithRootViewController:vc];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"dhl-top-@3x"] forBarMetrics:UIBarMetricsDefault];

//    [nav.navigationBar setBarTintColor:[UIColor colorWithRed:0.30 green:0.686 blue:0.988 alpha:1.0]];
    
    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                               NSFontAttributeName:[UIFont boldSystemFontOfSize:18]
                                               }];
    [self addChildViewController:nav];
}
@end
