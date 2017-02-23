//
//  MasterOrderViewController.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/22.
//  Copyright © 2016年 86gg.cn. All rights reserved.
// API_OWNER_ORDERS_LIST_URL

#import "MasterOrderViewController.h"
#import "MasterOrderTableViewCell.h"
#import "NearbyModel.h"
#import "OrderListModel.h"
#import "MJExtension.h"
#import "ComplaintViewController.h"
@interface MasterOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSUserDefaults * userDefault;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong ,nonatomic) NSArray * listArray;
@property (assign, nonatomic) NSInteger page;
@end

@implementation MasterOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.title = @"我的订单";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:kMasterOrderTableViewCell bundle:nil] forCellReuseIdentifier:kMasterOrderTableViewCell];
    
    [self postOwnerOrdersListWithPrkid:@""];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MasterOrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kMasterOrderTableViewCell];
    OrderListModel * orderListModel = [OrderListModel mj_objectWithKeyValues:self.listArray[indexPath.row]];
    
    NSString * str1 = [NSString stringWithFormat:@"%@",[TurnDate turnDataWithString:orderListModel.starttime]];
    NSString * str2 = [NSString stringWithFormat:@"%@",[TurnDate turnDataWithString:orderListModel.endtime]];
    cell.startTimeLabel.text = str1;
    cell.endTimeLabel.text = str2;
    
    NSString * imgUrl =[NSString stringWithFormat:@"%@%@",URLHTTP,orderListModel.navigation_imgurl];
    NSURL * urlStr = [NSURL URLWithString:imgUrl];
    [cell.imgView sd_setImageWithURL:urlStr placeholderImage:[UIImage imageNamed:@"picture-wait@3x"]];
    
    cell.userNameLabel.text = orderListModel.truename;
    cell.phoneNumber.text = orderListModel.phone;
    cell.priceLabel.text = orderListModel.pay_price;
   
    cell.unitPriceLabel.text = orderListModel.park_price;
    
    cell.hoursLabel.text = [NSString stringWithFormat:@"%d",[orderListModel.pay_price intValue]/[orderListModel.park_price intValue]];
    
    cell.sureButton.userInteractionEnabled = NO;//用户交互
    
    switch ([orderListModel.status intValue]) {
        case 0:
        {// 取消订单
        }
            break;
        case 1:
        {// 未付款
            [cell.sureButton setImage:[UIImage imageNamed:@"czdd-wfk"] forState:UIControlStateNormal];
        }
            break;
        case 2:
        {//已付款
            [cell.sureButton setImage:[UIImage imageNamed:@"czdd-yfk"] forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
  
    cell.complainBtnBlock = ^(){//投诉
        NSLog(@"indexPath=%ld",(long)indexPath.row);
        ComplaintViewController * CVC = [[ComplaintViewController alloc]init];
        [self.navigationController pushViewController:CVC animated:YES];
    };
    cell.sureBtnBlock = ^(){//未付款已付款
        NSLog(@"indexPath=%ld",(long)indexPath.row);
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

#pragma mark - 获取数据
- (void)postOwnerOrdersListWithPrkid:(NSString *)prkid
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    [params setObject:prkid forKey:@"Prkid"];
    
    userDefault = [NSUserDefaults standardUserDefaults];
    [params setObject:[userDefault valueForKey:@"Token"] forKey:@"Token"];
    NSLog(@"参数%@",params);
    __weak __typeof(self)weakSelf = self;
    
    [MHNetworkManager postReqeustWithURL:API_OWNER_ORDERS_LIST_URL params:params successBlock:^(NSDictionary *returnData) {
        
        NSLog(@"我的订单车主返回数据%@",returnData);
        
        if([returnData isKindOfClass:[NSArray class]])
        {
            NSMutableArray * modelArr = [NSMutableArray array];
            for (NSDictionary * dict in returnData)
            {
                OrderListModel * Model = [[OrderListModel alloc]initWithInfoDic:dict];
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
        
        
    } failureBlock:^(NSError *error) {
        
    } showHUD:YES];
    
    
}
-(void)getTokenAgain
{
    //串行队列
    dispatch_sync(dispatch_queue_create("zz", DISPATCH_QUEUE_SERIAL), ^{
        // 1
        [GetToken getToken];
        // 2 重新获取后 请求

    });
    
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
