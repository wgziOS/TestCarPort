//
//  BalanceViewController.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/6.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import "BalanceViewController.h"

@interface BalanceViewController ()

@end

@implementation BalanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)goBackClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 充值
- (IBAction)rechargeButtonClick:(id)sender {
}
#pragma mark - 提现
- (IBAction)withdrawButtonClick:(id)sender {
    
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
