//
//  CarPortDetailViewController.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/12.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import "CarPortDetailViewController.h"
#import "ImageScrollView.h"
#import "LGViewController.h"
#import "SucessViewController.h"
#import "FailureViewController.h"
@interface CarPortDetailViewController () <UIAlertViewDelegate>
{
    NSUserDefaults * userDefault;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeight;

@end

@implementation CarPortDetailViewController
-(void)viewWillAppear:(BOOL)animated
{
    [self beginAppearanceTransition: YES animated: animated];
    
    //右按钮
    UIView * rightButtonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 25)];
    UIButton * rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 25)];
    
    [rightButton setImage:[UIImage imageNamed:@"cwxq-map-icon@3x"] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightButtonView addSubview:rightButton];
    UIBarButtonItem *rightCunstomButtonView = [[UIBarButtonItem alloc]initWithCustomView:rightButtonView];
    self.navigationItem.rightBarButtonItem = rightCunstomButtonView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    //根据内容高度设置滚动背景高度
    self.scrollViewHeight.constant = self.appointmentButton.frame.origin.y+100;
    self.title = @"车位详情";
    //图片轮播
//    ImageScrollView * imgScrollView = [[ImageScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWITH, 100)];
////    ImageScrollView * imgScrollView = [[ImageScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWITH, 120)andImageArray:<#(NSArray *)#>];
//    [self.bottonView addSubview:imgScrollView];
    
    
        NSString * imgUrl =[NSString stringWithFormat:@"http://parking.86gg.cn%@",self.nearbyModel.ParkingSpace.imgurl];
        NSURL * url = [NSURL URLWithString:imgUrl];
        [self.imgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"picture-wait@3x"]];
    
    
    
    self.titleLabel.text = self.nearbyModel.ParkingSpace.title;

    self.userNameLabel.text = self.nearbyModel.ParkingSpace.username;
    self.phoneNumberLabel.text = self.nearbyModel.ParkingSpace.phone;
    NSString * price = self.nearbyModel.ParkingSpace.park_price;
    self.priceLabel.text = price;
    
    NSString * str = [NSString stringWithFormat:@"%@-%@",[TurnDate turnDataWithString:self.nearbyModel.ParkingSpace.starttime],[TurnDate turnDataWithString:self.nearbyModel.ParkingSpace.endtime]];
    self.carPortTimeLabel.text = str;
    
    self.addressLabel.text = self.nearbyModel.ParkingSpace.user_address;

    self.describeLabel.text = [FilterHTML filterHTML:self.nearbyModel.ParkingSpace.describe];
    // 折扣
//    self.discountLabel
    //
    self.carportOriginalNOLabel.text = [NSString stringWithFormat:@"CLCX0%@",self.nearbyModel.ParkingSpace.id];
    self.carportNOLabel.text = self.nearbyModel.ParkingSpace.plate_number;
    self.entranceLabel.text = self.nearbyModel.ParkingSpace.parking_entrance;
    self.phoneNumberLabel.text = self.nearbyModel.ParkingSpace.phone;
    
    
}
#pragma  mark - 查看地图
- (IBAction)checkMapClick:(id)sender {
}
#pragma mark - 预约按钮
- (IBAction)appointmentButtonClick:(id)sender {
    UIAlertView * alert1 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"下单超过5分钟无法取消订单\n是否预约此车位" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert1.delegate = self;
    [alert1 show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSLog(@"跳转");
        [self postNearPakingWithParkid:[_nearbyModel.ParkingSpace.id intValue]];
    }
}

#pragma mark - 获取数据
- (void)postNearPakingWithParkid:(int)parkid
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    [params setObject:[NSString stringWithFormat:@"%d",parkid] forKey:@"Parkid"];
    userDefault = [NSUserDefaults standardUserDefaults];
    [params setObject:[userDefault valueForKey:@"Token"] forKey:@"Token"];
    
    __weak __typeof(self)weakSelf = self;
    
    [MHNetworkManager postReqeustWithURL:API_USER_BESPEAK_SPACE_URL params:params successBlock:^(NSDictionary *returnData) {

//        NSLog(@"st=%@",[returnData objectForKey:@"states"]);
        
        [Calculate_frame showWithText:[returnData objectForKey:@"message"]];
//        states = 0, message = "token不存在或到期！"

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
                
            default:
                break;
        }
        
        
    } failureBlock:^(NSError *error) {
        [Calculate_frame showWithText:@"网络请求失败"];
    } showHUD:YES];
    
    
}
-(void)goFailure
{
    FailureViewController * FVC = [[FailureViewController alloc]init];
    [self.navigationController pushViewController:FVC animated:YES];
}
-(void)goSucess
{
    SucessViewController * SVC = [[SucessViewController alloc]init];
    SVC.nearbyModel = self.nearbyModel;
    
    [self.navigationController pushViewController:SVC animated:YES];
}
-(void)goLogin
{
    LGViewController *LGVC = [[LGViewController alloc]init];
    [self.navigationController pushViewController:LGVC animated:YES];
}
#pragma mark - 右按钮
-(void)rightButtonClick:(id)sender
{
    
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
