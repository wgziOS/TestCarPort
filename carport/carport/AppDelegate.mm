//
//  AppDelegate.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/2.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import "AppDelegate.h"
#import "XMGTabBarController.h"
#import "YQSlideMenuController.h"
#import "LeftMenuController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    

    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    
    XMGTabBarController *contentViewController = [[XMGTabBarController alloc] init];
    LeftMenuController  *leftMenuViewController = [[LeftMenuController alloc] init];
    YQSlideMenuController *sideMenuController = [[YQSlideMenuController alloc] initWithContentViewController:contentViewController
                                                                                      leftMenuViewController:leftMenuViewController];
    sideMenuController.scaleContent = NO;
    
    self.window.rootViewController = sideMenuController;
    //地图
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"GNqXqxkQuMXPegdSKCVnDLQi1TeBgr4Q"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    // 显示窗口
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
