//
//  MainViewController.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/5.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import "MainViewController.h"
#import "LeftMenuController.h"
#import "MyLocationViewController.h"
#import "NearbyCarportViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
@interface MainViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    BMKLocationService* _locService;
    NSUserDefaults * userDefault;
    int count;
}
@property (nonatomic ,strong) BMKMapView* mapView;
@property (nonatomic ,strong) NSString * userLongitude;//用户经度
@property (nonatomic ,strong) NSString * userLatitude;//纬度
@end

@implementation MainViewController
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时
    _locService.delegate = self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self beginAppearanceTransition: YES animated: animated];
    //左按钮
    UIView * leftButtonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    UIButton * leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [leftButton setImage:[UIImage imageNamed:@"cwlb_01"] forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [leftButtonView addSubview:leftButton];
    UIBarButtonItem *leftCunstomButtonView = [[UIBarButtonItem alloc]initWithCustomView:leftButtonView];
    self.navigationItem.leftBarButtonItem = leftCunstomButtonView;
    //右按钮
    UIView * rightButtonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 25)];
    UIButton * rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 25)];
//    rightButton.tag = 0;
    [rightButton setImage:[UIImage imageNamed:@"cwlb_02"] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightButtonView addSubview:rightButton];
    UIBarButtonItem *rightCunstomButtonView = [[UIBarButtonItem alloc]initWithCustomView:rightButtonView];
    self.navigationItem.rightBarButtonItem = rightCunstomButtonView;
    

    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil
    _locService.delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.view = self.mapView;
    
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    
    [self startLocation];
    [self setMapZoomLevel:0.08f];
    count = 1;
}

#pragma mark - 定位
-(void)startLocation
{
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
}
#pragma mark - 实现相关delegate 处理位置信息更新
#pragma mark - 处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //NSLog(@"heading is %@",userLocation.heading);
}
#pragma mark - 处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{

    self.userLongitude = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
    self.userLatitude = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
    
    userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:self.userLongitude forKey:@"userLongitude"];
    [userDefault setObject:self.userLatitude forKey:@"userLatitude"];
    [userDefault synchronize];
    
    //展示定位
    [_mapView updateLocationData:userLocation];
    if (count == 1) {
        [self setCenter];
        count++;
    }
    
}
#pragma mark - SetCenter
-(void)setCenter
{
    
    _mapView.centerCoordinate = CLLocationCoordinate2DMake([self.userLatitude doubleValue], [self.userLongitude doubleValue]);
}
#pragma mark - SetMapZoomLevel
-(void)setMapZoomLevel:(double)level
{
    double zoomLevel = level;
    [_mapView setRegion:BMKCoordinateRegionMake(_mapView.centerCoordinate, BMKCoordinateSpanMake(zoomLevel,zoomLevel))];
}
#pragma mark you按钮方法
-(void)rightButtonClick:(id)sender
{

}
#pragma mark 左按钮方法
-(void)leftButtonClick:(id)sender
{
    
    LGViewController * LGVC = [[LGViewController alloc]init];
    [self.navigationController pushViewController:LGVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
