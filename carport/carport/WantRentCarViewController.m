//
//  WantRentCarViewController.m
//  carport
//
//  Created by 吴桂钊 on 2017/2/13.
//  Copyright © 2017年 86gg.cn. All rights reserved.
//

#import "WantRentCarViewController.h"
#import "WantRentCarCell.h"
#import "RentCarDetailViewController.h"
#import "RentCarModel.h"
#import "ListImgModel.h"

@interface WantRentCarViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSUserDefaults * userDefault;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray * dataArray;
@property (assign, nonatomic) NSInteger page;

@end

@implementation WantRentCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:kWantRentCarCell bundle:nil] forCellReuseIdentifier:kWantRentCarCell];
    
    [self postVehicleWithPage:0];
    [self MJRefresh];

}

#pragma mark - MJRefresh
-(void)MJRefresh
{
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page--;
        if (_page == 0 || _page ==-1) {
            _page = 0;
            [Calculate_frame showWithText:@"已经是第一页"];
            [self endRefresh];
            [self updateData];
        }else{
            [self updateData];
        }
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self updateData];
    }];
    
}
- (void)updateData
{
    [self postVehicleWithPage:_page];
}
#pragma mark - 获取数据 API_GET_VEHICLE_INFOMATION_URL
- (void)postVehicleWithPage:(NSInteger)page
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    [params setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"CurrentPage"];
  
    userDefault = [NSUserDefaults standardUserDefaults];
    [params setObject:[userDefault valueForKey:@"Token"] forKey:@"Token"];
    NSLog(@"====%@",[userDefault valueForKey:@"Token"] );
    __weak __typeof(self)weakSelf = self;
    
    [MHNetworkManager postReqeustWithURL:API_GET_VEHICLE_INFOMATION_URL params:params successBlock:^(NSDictionary *returnData) {
        
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
                    break;
                case -1:
                    //先登录
//                    [weakSelf goLogin];
                    break;
                    
                default:
                    break;
            }
        }
        [self endRefresh];
        
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
/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
#pragma mark - tableView 代理
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WantRentCarCell * cell = [tableView dequeueReusableCellWithIdentifier:kWantRentCarCell];
    
    RentCarModel * model = [RentCarModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
    
    cell.titleLabel.text = model.VehicleInformation.car_size;
    cell.addressLabel.text = model.VehicleInformation.car_address;
    cell.priceLabel.text = model.VehicleInformation.non_holiday_prie;
    
    if (model.listImg.count!=0) {
        ListImgModel * imgModel = [ListImgModel mj_objectWithKeyValues:model.listImg[0]];
        
        NSString * imgUrl =[NSString stringWithFormat:@"http://parking.86gg.cn%@",imgModel.imgurl];
        //         NSString * imgUrl =[NSString stringWithFormat:@"http://192.168.123.73:8090%@",model.imgurl];
        /*
         tableView
         */
        NSURL * url = [NSURL URLWithString:imgUrl];
        NSLog(@"url===%@",url);
        [cell.ImgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"picture-wait@3x"]];
    }
    
   
    

    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    RentCarModel * model = [RentCarModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
    RentCarDetailViewController * RVC = [[RentCarDetailViewController alloc]init];
    RVC.model = model;
    NSLog(@"00000%@",model.VehicleInformation.starttime);
    [self.navigationController pushViewController:RVC animated:YES];
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
