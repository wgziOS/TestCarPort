//
//  RentCarInfoCell.h
//  carport
//
//  Created by 吴桂钊 on 2017/2/14.
//  Copyright © 2017年 86gg.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kRentCarInfoCell = @"RentCarInfoCell";
@interface RentCarInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *carSizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *plateNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *seatCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyCarYearLabel;
@property (weak, nonatomic) IBOutlet UILabel *kilometersTraveledLabel;
@property (weak, nonatomic) IBOutlet UILabel *engineDisplacementLabel;
@property (weak, nonatomic) IBOutlet UILabel *variableBoxLabel;
@property (weak, nonatomic) IBOutlet UILabel *configurationLabel;

@end
