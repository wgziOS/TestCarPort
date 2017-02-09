//
//  SucessViewController.h
//  carport
//
//  Created by 吴桂钊 on 2016/12/16.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearbyModel.h"
@interface SucessViewController : UIViewController
@property(nonatomic,strong) NearbyModel * nearbyModel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *entryLabel;
@property (weak, nonatomic) IBOutlet UILabel *entryModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *NOLabel;
@property (weak, nonatomic) IBOutlet UILabel *ONOLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@end
