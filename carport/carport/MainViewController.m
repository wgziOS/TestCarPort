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
#import "MainCell.h"
#import <SDCycleScrollView.h>
@interface MainViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
{
    BMKLocationService* _locService;
    NSUserDefaults * userDefault;
    int count;
    UILabel * cityLabel;
}
@property (nonatomic ,strong) BMKMapView* mapView;
@property (nonatomic ,strong) NSString * userLongitude;//用户经度
@property (nonatomic ,strong) NSString * userLatitude;//纬度
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (strong, nonatomic) SDCycleScrollView * scrollView;
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
    UIView * leftButtonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 25)];
    UIButton * leftButton = [[UIButton alloc]initWithFrame:CGRectMake(27, 0, 25, 25)];
    [leftButton setImage:[UIImage imageNamed:@"dw"] forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 25)];
    cityLabel.text = @"厦门";
    cityLabel.textColor = [UIColor whiteColor];
    cityLabel.font = [UIFont systemFontOfSize:13.0f];
    [leftButtonView addSubview:cityLabel];
    [leftButtonView addSubview:leftButton];
    UIBarButtonItem *leftCunstomButtonView = [[UIBarButtonItem alloc]initWithCustomView:leftButtonView];
    self.navigationItem.leftBarButtonItem = leftCunstomButtonView;
   

    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil
    _locService.delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:kMainCell bundle:nil] forCellReuseIdentifier:kMainCell];
    
    [self addTableHeadView];
}
//轮播
-(void) addTableHeadView{
//    _scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _scrollView  = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220) imageNamesGroup:@[]];
    
//    _scrollView.imageURLStringsGroup = _slideImgArray;
    _scrollView.pageControlDotSize = CGSizeMake(8.0, 8.0);
    _scrollView.autoScrollTimeInterval = 2.0;
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [_headView addSubview:_scrollView];
}
#pragma mark - tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainCell * cell = [tableView dequeueReusableCellWithIdentifier:kMainCell];

    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
#pragma mark -租车按钮方法
- (IBAction)ZCBtnClick:(id)sender {
}
#pragma mark -租车位按钮方法
- (IBAction)ZCWBtnClick:(id)sender {
}
#pragma mark 左按钮方法
-(void)leftButtonClick:(id)sender
{
//    LGViewController * LGVC = [[LGViewController alloc]init];
//    [self.navigationController pushViewController:LGVC animated:YES];
}



#pragma mark -———————————————— 加载mapView 老版本首页
-(void)MapView{
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
