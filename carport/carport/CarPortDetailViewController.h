//
//  CarPortDetailViewController.h
//  carport
//
//  Created by 吴桂钊 on 2016/12/12.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearbyModel.h"
@interface CarPortDetailViewController : UIViewController
@property(strong ,nonatomic)NearbyModel * nearbyModel;
@property (weak, nonatomic) IBOutlet UIView *bottonView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *carportOriginalNOLabel;//车位原始编号
@property (weak, nonatomic) IBOutlet UILabel *carportNOLabel;//车位编号
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;//电话
//@property (weak, nonatomic) IBOutlet UILabel *plateNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;//价格
@property (weak, nonatomic) IBOutlet UILabel *carPortTimeLabel;//车位时间
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;//地址
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;//描述
@property (weak, nonatomic) IBOutlet UIButton *appointmentButton;//预约按钮
@property (weak, nonatomic) IBOutlet UIImageView *imgView;//图片
@property (weak, nonatomic) IBOutlet UILabel *entranceLabel;//入口
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;//折扣

@end
