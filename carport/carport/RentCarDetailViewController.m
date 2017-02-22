//
//  RentCarDetailViewController.m
//  carport
//
//  Created by 吴桂钊 on 2017/2/13.
//  Copyright © 2017年 86gg.cn. All rights reserved.
//

#import "RentCarDetailViewController.h"
#import <SDCycleScrollView.h>
#import "RentCarInfoCell.h"
#import "RentCarTimeCell.h"
#import "RentCarNeedToKnowCell.h"
#import "RentResultView.h"
@interface RentCarDetailViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>
{
    NSUserDefaults * userDefault;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIView *headBgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *pledgeMoneyLabel;//押金
@property (nonatomic, strong)SDCycleScrollView * scrollView;
@property (nonatomic, strong)NSArray * dataArray;
@end

@implementation RentCarDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"车辆详情";
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self setScrollImage];
    
    [self.tableView registerNib:[UINib nibWithNibName:kRentCarInfoCell bundle:nil] forCellReuseIdentifier:kRentCarInfoCell];
    [self.tableView registerNib:[UINib nibWithNibName:kRentCarTimeCell bundle:nil] forCellReuseIdentifier:kRentCarTimeCell];
    [self.tableView registerNib:[UINib nibWithNibName:kRentCarNeedToKnowCell bundle:nil] forCellReuseIdentifier:kRentCarNeedToKnowCell];
    
    _titleLabel.text = _model.VehicleInformation.car_size;
    _priceLabel.text = _model.VehicleInformation.non_holiday_prie;
    _pledgeMoneyLabel.text = [NSString stringWithFormat:@"¥%@",_model.VehicleInformation.deposited_price];
    
}
#pragma mark - 设置轮播
-(void)setScrollImage
{
    //遍历
    NSMutableArray * modelArr = [NSMutableArray array];
    for (NSDictionary * dict in _model.listImg)
    {
        ListImgModel * Model = [[ListImgModel alloc]initWithInfoDic:dict];
        [modelArr addObject:[NSString stringWithFormat:@"http://parking.86gg.cn%@",Model.imgurl]];
    }
    
    //轮%@播
    _scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, _headBgView.frame.size.width, _headBgView.frame.size.height) delegate:self placeholderImage:[UIImage imageNamed:@"picture-wait"]];
    _scrollView.imageURLStringsGroup = modelArr;
    _scrollView.pageControlDotSize = CGSizeMake(8.0, 8.0);
    _scrollView.autoScrollTimeInterval = 2.0;
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [_headBgView addSubview:_scrollView];
}

#pragma mark - tableView 代理
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RentCarInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:kRentCarInfoCell];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
    RentCarTimeCell * cell1 = [tableView dequeueReusableCellWithIdentifier:kRentCarTimeCell];
    cell1.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
    RentCarNeedToKnowCell * cell2 = [tableView dequeueReusableCellWithIdentifier:kRentCarNeedToKnowCell];
    cell2.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
    switch (indexPath.row) {
        case 0:
        {
            cell.carSizeLabel.text = _model.VehicleInformation.car_size;
            cell.buyCarYearLabel.text = [NSString stringWithFormat:@"%@年",_model.VehicleInformation.buy_car_year];
            cell.plateNumberLabel.text = _model.VehicleInformation.plate_number;
            cell.kilometersTraveledLabel.text = [NSString stringWithFormat:@"%@公里",_model.VehicleInformation.kilometers_traveled];
            cell.seatCountLabel.text = [NSString stringWithFormat:@"%@座",_model.VehicleInformation.seat_count];
            cell.engineDisplacementLabel.text = _model.VehicleInformation.engine_displacement;
            cell.variableBoxLabel.text = _model.VehicleInformation.variable_box;
//            cell.configurationLabel.text =
            //多媒体
            return cell;
        }
            break;
        case 1:
        {
//            NSString * str = [NSString stringWithFormat:@"%@ 至 %@",[TurnDate turToDataWithoutHour:_model.VehicleInformation.starttime],[TurnDate turToDataWithoutHour:_model.VehicleInformation.endtime]];
            
            NSLog(@"我要租车详情页endtime=%@",_model.VehicleInformation.endtime);
            NSString *str1 = [[TurnDate turnDataWithString:_model.VehicleInformation.starttime] substringToIndex:10];
            NSString *str2 = [[TurnDate turnDataWithString:_model.VehicleInformation.endtime] substringToIndex:10];
            NSString * str = [NSString stringWithFormat:@"%@ 至 %@",str1,str2];
           
            
            cell1.timeLabel.text = str;
            cell1.nonHolidayPrie.text = [NSString stringWithFormat:@"%@元/天",_model.VehicleInformation.non_holiday_prie];
            cell1.holidayPrie.text = [NSString stringWithFormat:@"%@元/天",_model.VehicleInformation.holiday_prie];
            return cell1;
        }
            break;
        case 2:
        {
            cell2.addressLabel.text = _model.VehicleInformation.car_address;
            cell2.ownerPhoneLabel.text = [NSString stringWithFormat:@"%@  %@",_model.VehicleInformation.owner_name,_model.VehicleInformation.owner_phone];
            cell2.needToKnowLabel.text = _model.VehicleInformation.descinfo;
            return cell2;
        }
            break;
            
        default:
            break;
    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 1 || indexPath.row == 2) {
        return 145;
    }else return 200;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
#pragma mark - 立即租用按钮
- (IBAction)rentBtnClick:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"下单超过5分钟无法取消订单\n是否立即租用" preferredStyle:  UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self postRental];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    //弹出
    [self presentViewController:alert animated:true completion:nil];
    
}

#pragma mark - 获取数据
- (void)postRental
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    [params setObject:[NSString stringWithFormat:@"%@",_model.VehicleInformation.Id] forKey:@"VehicleId"];
    userDefault = [NSUserDefaults standardUserDefaults];
    [params setObject:[userDefault valueForKey:@"Token"] forKey:@"Token"];
    __weak __typeof(self)weakSelf = self;
    
    [MHNetworkManager postReqeustWithURL:API_GET_USER_CAR_RENTAL_URL params:params successBlock:^(NSDictionary *returnData) {
        
        [Calculate_frame showWithText:[returnData objectForKey:@"message"]];
        
        NSString * str = [NSString stringWithFormat:@"%@",[returnData objectForKey:@"states"]];
        switch (str.intValue) {
            case 1:
                //预约成功
                [self goSucess];
                break;
            case -2:
                //已经预约
                [self goFailure];
                break;
            case -1:
                //先登录
                [weakSelf goLogin];
                break;
            case 0:
                //过期先登录
                [weakSelf goLogin];
                break;
            default:
                break;
        }
        
    } failureBlock:^(NSError *error) {
        [Calculate_frame showWithText:@"网络请求失败"];
    } showHUD:YES];
    
}
-(void)goFailure
{

    RentResultView * resultView = [[RentResultView alloc]initViewTitleImgString:@"clxq-icon" TitleString:@"订单失败" SubTitleString:@"该车辆已被出租" BtnImgString:@"clxq-cxzc"];
    [resultView show];

    resultView.goonBlock = ^() {
//        [self.navigationController popViewControllerAnimated:YES];
    };
    
}
-(void)goSucess
{
  //成功
    RentResultView * resultView = [[RentResultView alloc]initViewTitleImgString:@"cwxq-yycg-icon" TitleString:@"出租成功" SubTitleString:@"" BtnImgString:@"clxq-cxzc"];
    [resultView show];
    
    resultView.goonBlock = ^() {
//        [self.navigationController popViewControllerAnimated:YES];
    };
}
-(void)goLogin
{
    LGViewController *LGVC = [[LGViewController alloc]init];
    [self.navigationController pushViewController:LGVC animated:YES];
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
