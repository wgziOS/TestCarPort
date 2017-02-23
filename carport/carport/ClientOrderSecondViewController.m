//
//  ClientOrderSecondViewController.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/27.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import "ClientOrderSecondViewController.h"
#import "RentCarOrderModel.h"
#import "MJExtension.h"
#import "ClientOrderTableViewCell.h"
#import "ClientRentCarCell.h"
#import "ComplaintViewController.h"
#import "ListImgModel.h"
@interface ClientOrderSecondViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSUserDefaults * userDefault;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong ,nonatomic) NSArray * listArray;
@end

@implementation ClientOrderSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:kClientRentCarCell bundle:nil] forCellReuseIdentifier:kClientRentCarCell];
    
    [self postUserOrdersList];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClientRentCarCell * cell = [tableView dequeueReusableCellWithIdentifier:kClientRentCarCell];
    
    RentCarOrderModel * Model = [RentCarOrderModel mj_objectWithKeyValues:self.listArray[indexPath.row]];
    
    cell.titleLabel.text = Model.CarRentalOrders.car_size;
    cell.nameTitle.text = @"车主:";
    cell.nameAndPhoneLabel.text = [NSString stringWithFormat:@"%@ %@",Model.CarRentalOrders.owner_name,Model.CarRentalOrders.owner_phone];
    
    NSString * str = [NSString stringWithFormat:@"%@",Model.CarRentalOrders.Starttime];
    if (str.length == 21) {
        cell.startLabel.text = [NSString stringWithFormat:@"开始-%@",[TurnDate turnDataWithString:Model.CarRentalOrders.Starttime]];
        cell.endLabel.text = [NSString stringWithFormat:@"结束-%@",[TurnDate turnDataWithString:Model.CarRentalOrders.Endtime]];
    }else{
        cell.startLabel.text = [NSString stringWithFormat:@"时间数据异常"];
        cell.endLabel.text = [NSString stringWithFormat:@"时间数据异常"];
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
    
    
    cell.greenLabel.text = [NSString stringWithFormat:@"该车押金%@元，非节假日%@元/天，节假日%@元/天",Model.CarRentalOrders.deposited_price,Model.CarRentalOrders.on_holiday_prie,Model.CarRentalOrders.holiday_prie];
    //天数
    cell.grayLabel.text = [NSString stringWithFormat:@"（非节假日，租用%@天，共计：%@元）",@"n",Model.CarRentalOrders.Pay_price];
    
    cell.blackLabel.text = [NSString stringWithFormat:@"剩余押金：%d元",[Model.CarRentalOrders.deposited_price intValue] - [Model.CarRentalOrders.Pay_price intValue]];
    
   
    switch ([Model.CarRentalOrders.Status intValue]) {
        case 0:
        {// 取消订单
            
        }
            break;
        case 1:
        {// 未付款
//            [cell.payButton setImage:[UIImage imageNamed:@"czdd-fk"] forState:UIControlStateNormal];
        }
            break;
        case 2:
        {//已付款
//            [cell.payButton setImage:[UIImage imageNamed:@"czdd-yfk"] forState:UIControlStateNormal];
            cell.firstButton.hidden  = YES;
        }
            break;
        default:
            break;
    }
    
    cell.secondBtnBlock = ^(){//投诉
        NSLog(@"dsfg%ld",(long)indexPath.row);
        ComplaintViewController * CVC = [[ComplaintViewController alloc]init];
        [self.navigationController pushViewController:CVC animated:YES];
    };
    cell.firstBtnBlock = ^(){//取消 API_POST_USER_CAR_ORDER_CANCEL_URL
        NSLog(@"取消%ld",(long)indexPath.row);
        
        [self postCancelOrdersWithOrderid:[Model.CarRentalOrders.Id integerValue]];
    };
    cell.thirdBtnBlock = ^(){//还车
        NSLog(@"还车%ld",(long)indexPath.row);
        
    };
    
    return cell;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 210;
    
}
#pragma mark - cancelOrders
- (void)postCancelOrdersWithOrderid:(NSInteger)orderid
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    userDefault = [NSUserDefaults standardUserDefaults];
    [params setObject:[userDefault valueForKey:@"Token"] forKey:@"Token"];
    [params setObject:[NSString stringWithFormat:@"%ld",(long)orderid] forKey:@"Orderid"];
    
    [MHNetworkManager postReqeustWithURL:API_POST_USER_CAR_ORDER_CANCEL_URL params:params successBlock:^(NSDictionary *returnData) {
        
        NSLog(@"取消订单返回数据%@",returnData);
        [Calculate_frame showWithText:[returnData objectForKey:@"message"]];
        NSString * str = [NSString stringWithFormat:@"%@",[returnData objectForKey:@"states"]];
        /*
         states = 1, message = "订单取消成功"
         states = -3, message = "订单取消失败"
         states = -4, message = "订单超过5分钟无法取消！"
         states = -1, message = "请先登录！"
         */
        switch ([str intValue]) {
            case -3:
               
                break;
            case -4:
                
                break;
            case -1:
                [self goLogin];
                break;
            case 1:
                
                
                break;
                
            default:
                break;
        }

        
       } failureBlock:^(NSError *error) {
        
    } showHUD:YES];
    
}
#pragma mark - 获取数据
- (void)postUserOrdersList
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    userDefault = [NSUserDefaults standardUserDefaults];
    [params setObject:[userDefault valueForKey:@"Token"] forKey:@"Token"];
    __weak __typeof(self)weakSelf = self;

    [MHNetworkManager postReqeustWithURL:API_POST_RENTAL_ORDERS_LIST_URL params:params successBlock:^(NSDictionary *returnData) {
        
        NSLog(@"我的订单客户返回数据%@",returnData);
        
        if([returnData isKindOfClass:[NSArray class]])
        {
            
            NSMutableArray * modelArr = [NSMutableArray array];
            for (NSDictionary * dict in returnData)
            {
                RentCarOrderModel * Model = [[RentCarOrderModel alloc]initWithInfoDic:dict];
                [modelArr addObject:Model];
            }
            weakSelf.listArray = modelArr;
            modelArr = nil;
            [self updateView];
            
        }else if([returnData isKindOfClass:[NSDictionary class]])
        {
        
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
        
    } failureBlock:^(NSError *error) {
        
    } showHUD:YES];
    
}
-(void)getTokenAgain
{
    //串行队列
    //    dispatch_sync(dispatch_queue_create("zz", DISPATCH_QUEUE_SERIAL), ^{
    //        // 1
    //        [self getToken];
    //        // 2 重新获取后 请求
    //        [self postNearPakingWithLongitude:self.userLongitude andLatitude:self.userLatitude andPage:0 andSearchkey:@""];
    //    });
    
}
-(void)goLogin
{
    LGViewController *LGVC = [[LGViewController alloc]init];
    [self.navigationController pushViewController:LGVC animated:YES];
}

/**
 * 更新视图.
 */
- (void) updateView
{
    [self.tableView reloadData];
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
