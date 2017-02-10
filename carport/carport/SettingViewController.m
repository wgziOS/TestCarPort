//
//  SettingViewController.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/14.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import "SettingViewController.h"
#import "SubmitPassWordViewController.h"
#import "SuggestViewController.h"
@interface SettingViewController ()
{
    NSUserDefaults * userDefault;
}
@property (weak, nonatomic) IBOutlet UIButton *fixPassWordButton;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"设置";
    
}
#pragma mark - 退出登录
- (IBAction)outButtonClick:(id)sender {
    
    userDefault = [NSUserDefaults standardUserDefaults];
    if ([[userDefault objectForKey:@"logState"] isEqualToString:@"1"]) {
        
        [self logoutAlert];
    }else{
        [self didNoLoginAlert];
    }

}

- (void)logoutAlert
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定退出登录？" preferredStyle:  UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault removeObjectForKey:@"phoneNumber"];
        [userDefault removeObjectForKey:@"logState"];
        [userDefault synchronize];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    //弹出
    [self presentViewController:alert animated:true completion:nil];
}
- (void)didNoLoginAlert
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还未登录" preferredStyle:  UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self goLogin];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:true completion:nil];
}
-(void)goLogin
{
    LGViewController *LGVC = [[LGViewController alloc]init];
    [self.navigationController pushViewController:LGVC animated:YES];
}

- (IBAction)fixPassWordButtonClick:(id)sender {
    SubmitPassWordViewController * SUBVC = [[SubmitPassWordViewController alloc]init];
    [self.navigationController pushViewController:SUBVC animated:YES];
}
//建议
- (IBAction)suggestButtonClick:(id)sender {
    SuggestViewController * SVC = [[SuggestViewController alloc]init];
    [self.navigationController pushViewController:SVC animated:YES];
}
//帮助
- (IBAction)helpButtonClick:(id)sender {
    
}
//关于我们
- (IBAction)oboutUSButtonClick:(id)sender {
    
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
