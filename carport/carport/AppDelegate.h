//
//  AppDelegate.h
//  carport
//
//  Created by 吴桂钊 on 2016/12/2.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

//#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
//#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
 
    BMKMapManager* _mapManager;
}

@property (strong, nonatomic) UIWindow *window;


@end

