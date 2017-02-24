//
//  MyRentCarCell.h
//  carport
//
//  Created by 吴桂钊 on 2017/2/23.
//  Copyright © 2017年 86gg.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kMyRentCarCell = @"MyRentCarCell";
@interface MyRentCarCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *plateNumLabel
;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *nonHolidayPrieLabel;
@property (weak, nonatomic) IBOutlet UILabel *holidayPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *depositedPriceLabel
;
@property (weak, nonatomic) IBOutlet UIButton *firstButton;
@property (weak, nonatomic) IBOutlet UIButton *secondButton;
@property (weak, nonatomic) IBOutlet UILabel *statesLabel;


@property(nonatomic,strong) void (^firstBtnBlock)();
@property(nonatomic,strong) void (^secondBtnBlock)();
@end
