//
//  LeftMenuController.m
//  YQSlideMenuControllerDemo
//
//  Created by Wang on 15/5/26.
//  Copyright (c) 2015年 Wang. All rights reserved.
//
#import "LeftMenuController.h"
#import "MainViewController.h"

#import "CarOwnerViewController.h"
#import "MeViewController.h"
#import "UIViewController+YQSlideMenu.h"
#import "MeTableViewCell.h"
#import "BalanceViewController.h"
#import "PersonalInfoViewController.h"
#import "YQSlideMenuController.h"
@interface LeftMenuController ()

@end

@implementation LeftMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[@"我的订单",@"我的车位",@"附近车位",@"我要投诉",@"历史清单"];

   [self.tableView registerNib:[UINib nibWithNibName:kMeTableViewCell bundle:nil] forCellReuseIdentifier:kMeTableViewCell];
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 150)];
    [self headViewSet];
    self.tableView.tableHeaderView = _headerView;
    
    [self.tableView reloadData];
}

-(void)headViewSet
{
    UIImageView * backView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"grzx_10"]];
    backView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 150);
    [self.headerView addSubview:backView];
    
    UIImageView * backlogoimageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 35, 70, 70)];
    backlogoimageView.userInteractionEnabled = YES;
    backlogoimageView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6];
    backlogoimageView.layer.cornerRadius = 35;//设置圆形
    backlogoimageView.layer.masksToBounds = YES;
    [self.headerView addSubview:backlogoimageView];
    //用户头像
    self.logoImage = [[UIImageView alloc]initWithFrame:CGRectMake(3.5, 3.5, 62, 62)];
    self.logoImage.userInteractionEnabled = YES;
    self.logoImage.layer.cornerRadius = 31.0;//设置圆形
    self.logoImage.layer.masksToBounds = YES;
    self.logoImage.image = [UIImage imageNamed:@"touxiang"];//写死
    [backlogoimageView addSubview:self.logoImage];
    
    UITapGestureRecognizer * logotap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(logoTap)];
    [self.headerView addGestureRecognizer:logotap];
    
    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 120, 30, 30)];
    label1.text = @"余额";
    label1.font = [UIFont systemFontOfSize:12.f];
    label1.textColor = [UIColor whiteColor];
    [self.headerView addSubview:label1];
    
    self.moneyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.moneyButton.frame = CGRectMake(48, 120, 60, 30);
    [self.moneyButton setTitle:@"250.25" forState:UIControlStateNormal];//写死
    self.moneyButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
    [self.moneyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.moneyButton.backgroundColor = [UIColor clearColor];
    [self.moneyButton addTarget:self action:@selector(moneyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:self.moneyButton];
    
    self.nikeNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 50, 80, 40)];
    self.nikeNameLabel.text = @"KissMe>>>";
    self.nikeNameLabel.font = [UIFont systemFontOfSize:15.f];
    self.nikeNameLabel.textColor = [UIColor whiteColor];
    [self.headerView addSubview:self.nikeNameLabel];
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
   
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kMeTableViewCell];
    
    NSArray * array1 = @[@"gerzx_02",@"gerzx_03",@"gerzx_04",@"gerzx_05",@"gerzx_06"];
    cell.imgView.image = [UIImage imageNamed:array1[indexPath.row]];
    cell.label.text = _dataArray[indexPath.row];
    
    return cell;
    
}
#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    switch (indexPath.row) {
        case 0:
        {
        
        }
            break;
        case 1:
        {//发布车位
            PublishCarPortViewController * carVC = [[PublishCarPortViewController alloc]init];
            [self.slideMenuController showViewController:carVC];
 
        }
            break;
        case 2:
        {//附近
            MainViewController * MVC = [[MainViewController alloc]init];
            [self.slideMenuController showViewController:MVC];
        }
            break;
        case 3:
        {
            
        }
            break;
        case 4:
        {
            
        }
            break;
            
        default:
            break;
    }
    //    if(indexPath.row == 0){
    //        OneViewController *one = [[OneViewController alloc] initWithNibName:@"OneViewController" bundle:nil];
    //        [self.slideMenuController showViewController:one];
    //        one.title = self.dataArray[indexPath.row];
    //    }else{
    //        TwoViewController *two = [[TwoViewController alloc] initWithNibName:@"TwoViewController" bundle:nil];
    //        [self.slideMenuController showViewController:two];
    //        two.title = self.dataArray[indexPath.row];
    //    }

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
