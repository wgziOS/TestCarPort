//
//  SucessViewController.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/16.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import "SucessViewController.h"

@interface SucessViewController ()


@end

@implementation SucessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _addressLabel.text = self.nearbyModel.ParkingSpace.user_address;
    _entryLabel.text = self.nearbyModel.ParkingSpace.parking_entrance;
    switch (self.nearbyModel.ParkingSpace.entry_mode) {
        case 1:
        {
            _entryModeLabel.text =@"给管理员看订单";
        }
            break;
        case 2:
        {
            _entryModeLabel.text =@"给管理员报名字";
        }
            break;
        case 3:
        {
            _entryModeLabel.text =@"给车主打电话";
        }
            break;
        default:
            break;
    }
    
    _NOLabel.text = [NSString stringWithFormat:@"CLCX0%@",self.nearbyModel.ParkingSpace.id];
    _ONOLabel.text = self.nearbyModel.ParkingSpace.plate_number;
    _phoneNumberLabel.text = self.nearbyModel.ParkingSpace.phone;
}
- (IBAction)buttonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
