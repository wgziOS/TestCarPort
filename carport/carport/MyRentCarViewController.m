//
//  MyRentCarViewController.m
//  carport
//
//  Created by 吴桂钊 on 2017/2/23.
//  Copyright © 2017年 86gg.cn. All rights reserved.
// API_POST_USER_VEHICLE_INFOMATION_URL

#import "MyRentCarViewController.h"
#import "RentCarModel.h"
#import "MyRentCarCell.h"
#import "ListImgModel.h"
@interface MyRentCarViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSUserDefaults * userDefault;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray * listArray;
@property (assign, nonatomic) NSInteger page;
@end

@implementation MyRentCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我出租的爱车";
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:kMyRentCarCell bundle:nil] forCellReuseIdentifier:kMyRentCarCell];
    
    [self postVehicleListWithPage:0];
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page--;
        if (_page == 0 || _page ==-1) {
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

#pragma mark - tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 190;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    MyRentCarCell * cell = [tableView dequeueReusableCellWithIdentifier:kMyRentCarCell];
    RentCarModel *Model = [RentCarModel mj_objectWithKeyValues:self.listArray[indexPath.row]];
    
    cell.titleLabel.text = Model.VehicleInformation.car_size;
    cell.addressLabel.text = [NSString stringWithFormat:@"交车地址：%@",Model.VehicleInformation.car_address];
    cell.plateNumLabel.text = Model.VehicleInformation.plate_number;
    cell.depositedPriceLabel.text = [NSString stringWithFormat:@"押金：%@元",Model.VehicleInformation.deposited_price];
    cell.nonHolidayPrieLabel.text = Model.VehicleInformation.non_holiday_prie;
    cell.holidayPriceLabel.text = [NSString stringWithFormat:@"节假日%@元/天",Model.VehicleInformation.holiday_prie];
    
//    NSString * str = [NSString stringWithFormat:@"%@",Model.VehicleInformation.status];

    switch ([Model.VehicleInformation.status intValue]) {
        case 0://审核中
            
            break;
        case 1://已审核
            
            break;
        case 2://未通过
            
            break;
        case 3://被占用
            
            break;
        case -1://被下架
            
            break;
            
        default:
            break;
    }

    
    NSURL * urlStr;
    if (Model.listImg.count != 0) {
        NSMutableArray * modelArr = [NSMutableArray array];
        for (NSDictionary * dict in Model.listImg)
        {
            ListImgModel * Model = [[ListImgModel alloc]initWithInfoDic:dict];
            [modelArr addObject:Model];
        }
        ListImgModel * imgModel = [ListImgModel mj_objectWithKeyValues:modelArr[0]];
        
        NSString * imgUrl =[NSString stringWithFormat:@"%@%@",URLHTTP,imgModel.imgurl];
        urlStr = [NSURL URLWithString:imgUrl];
    }
    [cell.imgView sd_setImageWithURL:urlStr placeholderImage:[UIImage imageNamed:@"jztp"]];
    
    
    cell.firstBtnBlock = ^(){
        

    };
    cell.secondBtnBlock = ^(){
        

    };
    
    return cell;
}

#pragma mark - lg
-(void)goLogin
{
    LGViewController *LGVC = [[LGViewController alloc]init];
    [self.navigationController pushViewController:LGVC animated:YES];
}
- (void)updateData
{
    
    [self postVehicleListWithPage:_page];
}

#pragma mark - 获取数据
- (void)postVehicleListWithPage:(NSInteger)page
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    [params setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"CurrentPage"];
    
    userDefault = [NSUserDefaults standardUserDefaults];
    [params setObject:[userDefault valueForKey:@"Token"] forKey:@"Token"];
    __weak __typeof(self)weakSelf = self;
    
    [MHNetworkManager postReqeustWithURL:API_POST_USER_VEHICLE_INFOMATION_URL
        params:params successBlock:^(NSDictionary *returnData) {

        NSLog(@"我出租的车返回==%@",returnData);
        
        if([returnData isKindOfClass:[NSArray class]])
        {
            NSMutableArray * modelArr = [NSMutableArray array];
            for (NSDictionary * dict in returnData)
            {
                RentCarModel * Model = [[RentCarModel alloc]initWithInfoDic:dict];
                [modelArr addObject:Model];
            }
            weakSelf.listArray = modelArr;
            modelArr = nil;
            [self updateView];
            
        }else if([returnData isKindOfClass:[NSDictionary class]])
        {
            //是一个字典
            [Calculate_frame showWithText:[returnData objectForKey:@"message"]];
            NSString * str = [NSString stringWithFormat:@"%@",[returnData objectForKey:@"states"]];
            switch ([str intValue]) {
                case 0:
                    //过期
                    //                   [weakSelf getTokenAgain];
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
        
        [self endRefresh];
    } failureBlock:^(NSError *error) {
        
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
