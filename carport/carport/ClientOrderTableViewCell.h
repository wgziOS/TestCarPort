//
//  ClientOrderTableViewCell.h
//  carport
//
//  Created by 吴桂钊 on 2016/12/27.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kClientOrderTableViewCell = @"ClientOrderTableViewCell";
@interface ClientOrderTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel * titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView * imgView;
@property (weak, nonatomic) IBOutlet UILabel * userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel * phoneNumber;
@property (weak, nonatomic) IBOutlet UILabel * priceLabel;
@property (weak, nonatomic) IBOutlet UILabel * startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel * endTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel * unitPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel * hoursLabel;
@property (weak, nonatomic) IBOutlet UIButton * payButton;
@property (weak, nonatomic) IBOutlet UIButton * complaintButton;
@property (weak, nonatomic) IBOutlet UIButton * chargeBackButton;

@property(nonatomic,strong) void (^complainBtnBlock)();
@property(nonatomic,strong) void (^payBtnBlock)();
@property(nonatomic,strong) void (^chargeBackBtnBlock)();
@end
