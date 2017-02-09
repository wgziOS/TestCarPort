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
    [userDefault removeObjectForKey:@"phoneNumber"];
    [userDefault removeObjectForKey:@"logState"];
    
    [userDefault synchronize];
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
