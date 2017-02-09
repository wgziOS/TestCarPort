//
//  MeViewController.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/2.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import "MeViewController.h"
#import "MeTableViewCell.h"
#import "PersonalInfoViewController.h"
#import "BalanceViewController.h"
#import "SettingViewController.h"
#import "MeIsOwnerViewController.h"
#import "MasterOrderViewController.h"
#import "ClientOrderViewController.h"
#import "ComplaintViewController.h"
#import "MasterOrderMainViewController.h"
#import "ClientOrderMainViewController.h"
@interface MeViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeight;
@property (weak, nonatomic) IBOutlet UIImageView *topView;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (nonatomic, strong) UIImageView * logoImage;
@property (nonatomic, strong) UIButton * moneyButton;
@property (nonatomic, strong) UILabel * nikeNameLabel;
@property (nonatomic, strong) UIButton * setButton;//设置按钮
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.scrollViewHeight.constant = SCREENHEIGHT*1;
    [self headViewSet];
}
#pragma mark -  车主订单
- (IBAction)masterOrderBtnClick:(id)sender {
//    MasterOrderViewController * MOVC = [[MasterOrderViewController alloc]init];
//    [self.navigationController pushViewController:MOVC animated:YES];
    MasterOrderMainViewController * MMVC = [[MasterOrderMainViewController alloc]init];
    [self.navigationController pushViewController:MMVC animated:YES];
}
#pragma mark -  用户订单
- (IBAction)clientOrderBtnClick:(id)sender {
    ClientOrderMainViewController * CVC = [[ClientOrderMainViewController alloc]init];
    [self.navigationController pushViewController:CVC animated:YES];
}
#pragma mark -  我的车位
- (IBAction)myCarPortBtnClick:(id)sender {
    MeIsOwnerViewController * OWVC = [[MeIsOwnerViewController alloc]init];
    [self.navigationController pushViewController:OWVC animated:YES];
}
#pragma mark -  投诉
- (IBAction)complaintBtnClcik:(id)sender {
    ComplaintViewController * CVC = [[ComplaintViewController alloc]init];
    [self.navigationController pushViewController:CVC animated:YES];
}

#pragma mark -  加载头视图
-(void)headViewSet
{
    self.topView.userInteractionEnabled = YES;
    
    UIImageView * backlogoimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    backlogoimageView.userInteractionEnabled = YES;
    backlogoimageView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6];
    backlogoimageView.layer.cornerRadius = 35;//设置圆形
    backlogoimageView.layer.masksToBounds = YES;
    [self.headView addSubview:backlogoimageView];
    //用户头像
    self.logoImage = [[UIImageView alloc]initWithFrame:CGRectMake(3.5, 3.5, 63, 63)];
    self.logoImage.userInteractionEnabled = YES;
    self.logoImage.layer.cornerRadius = 31.0;//设置圆形
    self.logoImage.layer.masksToBounds = YES;
    self.logoImage.image = [UIImage imageNamed:@"touxiang"];//写死
    [backlogoimageView addSubview:self.logoImage];

    UITapGestureRecognizer * logotap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(logoTap)];
    [self.headView addGestureRecognizer:logotap];

    _moneyLabel.userInteractionEnabled = YES;
    [_moneyLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moneyButtonClick:)]];
//
    self.setButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _setButton.frame = CGRectMake(SCREENWITH-70, 25, 70, 40);
    [_setButton setTitle:@"设置" forState:UIControlStateNormal];
    _setButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
    [_setButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_setButton setImage:[UIImage imageNamed:@"shezhi"] forState:UIControlStateNormal];
    _setButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 25);
    _setButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [_setButton addTarget:self action:@selector(setBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:_setButton];

}

#pragma mark - 设置按钮点击
-(void)setBtnClick:(id)sender
{
    SettingViewController * SETVC = [[SettingViewController alloc]init];
    [self.navigationController pushViewController:SETVC animated:YES];
}


#pragma mark - 用户头像点击事件
-(void)logoTap
{
    PersonalInfoViewController * PVC = [[PersonalInfoViewController alloc]init];
    [self presentViewController:PVC animated:YES completion:nil];
}

-(void)moneyButtonClick:(id)sender
{
    BalanceViewController * BVC = [[BalanceViewController alloc]init];
    [self presentViewController:BVC animated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
