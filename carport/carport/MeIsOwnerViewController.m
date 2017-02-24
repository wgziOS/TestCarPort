//
//  MeIsOwnerViewController.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/21.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//我的车位

#import "MeIsOwnerViewController.h"
#import "MeIsOwnerTableViewCell.h"
#import "NearbyModel.h"
#import "MJExtension.h"
#import "FilterHTML.h"
#import "PublishCarPortViewController.h"
@interface MeIsOwnerViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSUserDefaults * userDefault;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray * listArray;
@property (assign, nonatomic) NSInteger page;
@end

@implementation MeIsOwnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"我的车位";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:kMeIsOwnerTableViewCell bundle:nil] forCellReuseIdentifier:kMeIsOwnerTableViewCell];
    
    [self postPakingSpaceListWithPage:1];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page--;
        if (_page <= 0) {
            _page = 0;
            [Calculate_frame showWithText:@"已经是第一页"];
            [self endRefresh];
        }else{
            [self updateData];
        }
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self updateData];
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self beginAppearanceTransition: YES animated: animated];
    
    //右按钮
    UIView * rightButtonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 25)];
    UIButton * rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 25)];
    //    rightButton.tag = 0;
    [rightButton setImage:[UIImage imageNamed:@"fb"] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightButton addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightButtonView addSubview:rightButton];
    UIBarButtonItem *rightCunstomButtonView = [[UIBarButtonItem alloc]initWithCustomView:rightButtonView];
    self.navigationItem.rightBarButtonItem = rightCunstomButtonView;
    
}
#pragma mark - 右按钮
-(void)rightBtnClick:(id)sender
{
    PublishCarPortViewController * PVC = [[PublishCarPortViewController alloc]init];
    PVC.navigationItem.title = @"发布车位信息";
    [self.navigationController pushViewController:PVC animated:YES];
}
/**
 * 更新视图.
 */
- (void) updateView
{
    [self.tableView reloadData];
}

/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 210;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MeIsOwnerTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kMeIsOwnerTableViewCell];
    NearbyModel *nearbyModel = [NearbyModel mj_objectWithKeyValues:self.listArray[indexPath.row]];
    
    NSString * imgUrl =[NSString stringWithFormat:@"http://parking.86gg.cn%@",nearbyModel.ParkingSpace.navigation_imgurl];
//    NSString * imgUrl =[NSString stringWithFormat:@"http://192.168.123.73:8090%@",nearbyModel.ParkingSpace.navigation_imgurl];
    
    NSURL * urlStr = [NSURL URLWithString:imgUrl];
    [cell.imgView sd_setImageWithURL:urlStr placeholderImage:[UIImage imageNamed:@"picture-wait@3x"]];
    
    
    cell.addressLabel.text = nearbyModel.ParkingSpace.user_address;
    cell.titleLabel.text = nearbyModel.ParkingSpace.title;
    cell.pricelabel.text = nearbyModel.ParkingSpace.park_price;
    cell.plantNumberLabel.text = nearbyModel.ParkingSpace.plate_number;
    

    cell.changeBtnBlock = ^(){
        
        PublishCarPortViewController * PVC = [[PublishCarPortViewController alloc]init];
        PVC.id = nearbyModel.ParkingSpace.id;
        [self.navigationController pushViewController:PVC animated:YES];
    };
    cell.delectBtnBlock = ^(){
        
        [self postDelectParkingSpaceWithSpaceId:nearbyModel.ParkingSpace.id];
        
    };
    
    return cell;
}
#pragma mark - 下架车位数据请求
- (void)postDelectParkingSpaceWithSpaceId:(NSString *)spaceId
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:spaceId forKey:@"Spaceid"];
    __weak __typeof(self)weakSelf = self;
    userDefault = [NSUserDefaults standardUserDefaults];
    [params setObject:[userDefault valueForKey:@"Token"] forKey:@"Token"];
    NSLog(@"%@",params);
    [MHNetworkManager postReqeustWithURL:API_OWNER_PARKING_SPACE_DELETE_URL params:params successBlock:^(NSDictionary *returnData) {
        
        NSLog(@"获取下架车位数据%@",returnData);
        NSLog(@"%@",returnData[@"message"]);
        if ([[returnData objectForKey:@"states"] integerValue] == 1) {
        
            NSString * mess = [[returnData objectForKey:@"message"]description];
            [Calculate_frame showWithText:mess];
           
        }else{
            NSString * error = [[returnData objectForKey:@"message"]description];
            [Calculate_frame showWithText:error];
        }
        NSString * str = [NSString stringWithFormat:@"%@",[returnData objectForKey:@"states"]];
        switch ([str intValue]) {
            case 0:
                //过期
//                [weakSelf getTokenAgain];
                [weakSelf goLogin];
                break;
            case -1:
                //先登录
                [weakSelf goLogin];
                break;
                
            default:
                break;
        }
        
    } failureBlock:^(NSError *error) {
        NSString * err = [NSString stringWithFormat:@"%@",error];
        [Calculate_frame showWithText:err];
    } showHUD:YES];
}
-(void)goLogin
{
    LGViewController *LGVC = [[LGViewController alloc]init];
    [self.navigationController pushViewController:LGVC animated:YES];
}
- (void)updateData
{
    
    [self postPakingSpaceListWithPage:_page];
}

#pragma mark - 获取数据
- (void)postPakingSpaceListWithPage:(NSInteger)page
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    [params setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"CurrentPage"];
    
    userDefault = [NSUserDefaults standardUserDefaults];
    [params setObject:[userDefault valueForKey:@"Token"] forKey:@"Token"];
    __weak __typeof(self)weakSelf = self;
    
    [MHNetworkManager postReqeustWithURL:API_GET_PARKING_SPACE_LIST_URL params:params successBlock:^(NSDictionary *returnData) {
        //        [self endRefresh];
        NSLog(@"我的车位返回数据%@",returnData);

        if([returnData isKindOfClass:[NSArray class]])
        {
            NSMutableArray * modelArr = [NSMutableArray array];
            for (NSDictionary * dict in returnData)
            {
                NearbyModel * nearbyModel = [[NearbyModel alloc]initWithInfoDic:dict];
                [modelArr addObject:nearbyModel];
            }
            weakSelf.listArray = modelArr;
            modelArr = nil;
            [self updateView];
            
        }else if([returnData isKindOfClass:[NSDictionary class]])
        {
            //是一个字典
            [Calculate_frame showWithText:[returnData objectForKey:@"message"]];
            NSString * str = [NSString stringWithFormat:@"%@",[returnData objectForKey:@"states"]];
            if ([str intValue] == -1) {
                //先登录
                [weakSelf goLogin];
            }
        }

        [self endRefresh];
    } failureBlock:^(NSError *error) {
        
    } showHUD:YES];
    
}
#pragma mark 获取Token
-(void)getToken
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json",@"text/plain", nil];
    //通过 appid  secret 认证code . 来发送获取token的请求
    [manager GET:API_TOKEN_URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {  //获得token
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //        NSLog(@"dic -------------------%@",[dic valueForKey:@"Token"]);
        userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:[dic valueForKey:@"Token"] forKey:@"Token"];
        [userDefault synchronize];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error %@",error.localizedFailureReason);
        //        [userDefault setObject:@""forKey:@"Token"];
        //        [userDefault setObject:@"0" forKey:@"logState"];
        //        [userDefault synchronize];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
