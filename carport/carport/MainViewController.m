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
#import "TuijianCell.h"
#import "RentCarModel.h"
#import <SDCycleScrollView.h>
#import "RentCarDetailViewController.h"
#import "WantRentCarViewController.h"
#import "NearbyCarportViewController.h"
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
@property (strong,nonatomic) NSArray * dataArray;
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
    [_tableView registerNib:[UINib nibWithNibName:kTuijianCell bundle:nil] forCellReuseIdentifier:kTuijianCell];
    [self addTableHeadView];
    
    [self postRecommend];
}

#pragma mark - 获取数据 API_RECOMMENDED_CAR_URL
- (void)postRecommend
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    userDefault = [NSUserDefaults standardUserDefaults];
    [params setObject:[userDefault valueForKey:@"Token"] forKey:@"Token"];
    __weak __typeof(self)weakSelf = self;
     NSLog(@"首页token=%@",[userDefault valueForKey:@"Token"]);
    [MHNetworkManager postReqeustWithURL:API_RECOMMENDED_CAR_URL params:params successBlock:^(NSDictionary *returnData) {
        
        if([returnData isKindOfClass:[NSArray class]])
        {
            
            NSMutableArray * modelArr = [NSMutableArray array];
            for (NSDictionary * dict in returnData)
            {
                RentCarModel * nearbyModel = [[RentCarModel alloc]initWithInfoDic:dict];
                [modelArr addObject:nearbyModel];
            }
            weakSelf.dataArray = modelArr;
            modelArr = nil;
            
            if (weakSelf.dataArray.count == 0) {
                [Calculate_frame showWithText:[NSString stringWithFormat:@"暂无数据"]];
            }
            [self updateView];
            
        }else if([returnData isKindOfClass:[NSDictionary class]])
        {
            
            [Calculate_frame showWithText:[returnData objectForKey:@"message"]];
            NSString * str = [NSString stringWithFormat:@"%@",[returnData objectForKey:@"states"]];
            
            switch ([str intValue]) {
                case 0:
                    //过期
                    //                    [weakSelf getTokenAgain];
                    [weakSelf goLogin];
                    break;
                case -1:
                    //先登录
                    [weakSelf goLogin];
                    break;
                    
                default:
                    break;
            }
        }
//        [self endRefresh];
        
    } failureBlock:^(NSError *error) {
        [Calculate_frame showWithText:@"网络请求失败"];
    } showHUD:YES];
    
}
/**
 * 更新视图.
 */
- (void) updateView
{
    [self.tableView reloadData];
}
#pragma mark - tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    TuijianCell * cell = [tableView dequeueReusableCellWithIdentifier:kTuijianCell];
    RentCarModel * model = [RentCarModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
    
    cell.titleLabel.text = model.VehicleInformation.car_size;
    cell.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.VehicleInformation.non_holiday_prie];

    if (model.listImg.count!=0) {
        ListImgModel * imgModel = [ListImgModel mj_objectWithKeyValues:model.listImg[0]];
        
        NSString * imgUrl =[NSString stringWithFormat:@"http://parking.86gg.cn%@",imgModel.imgurl];
        
        NSURL * url = [NSURL URLWithString:imgUrl];
        [cell.imgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"jztp"]];
    }

    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RentCarModel * model = [RentCarModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
    RentCarDetailViewController * RVC = [[RentCarDetailViewController alloc]init];
    RVC.model = model;
    //    NSLog(@"00000%@",model.VehicleInformation.starttime);
    [self.navigationController pushViewController:RVC animated:YES];
}
-(void)goLogin
{
    LGViewController *LGVC = [[LGViewController alloc]init];
    [self.navigationController pushViewController:LGVC animated:YES];
}
#pragma mark -租车按钮方法
- (IBAction)ZCBtnClick:(id)sender {
    WantRentCarViewController * WVC = [[WantRentCarViewController alloc]init];
    WVC.title = @"我要租车";
    [self.navigationController pushViewController:WVC animated:YES];
}
#pragma mark -租车位按钮方法
- (IBAction)ZCWBtnClick:(id)sender {
    NearbyCarportViewController * NVC = [[NearbyCarportViewController alloc]init];
     NVC.title = @"找车位";
    [self.navigationController pushViewController:NVC animated:YES];
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
#pragma mark - 轮播
-(void) addTableHeadView{
    
    _scrollView  = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220) imageNamesGroup:@[@"banner1.jpg",@"banner2.jpg",@"banner3.jpg",@"banner4.jpg"]];
    _scrollView.pageControlDotSize = CGSizeMake(8.0, 8.0);
    _scrollView.autoScrollTimeInterval = 2.0;
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [_headView addSubview:_scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
