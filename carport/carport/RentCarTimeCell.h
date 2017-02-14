//
//  RentCarTimeCell.h
//  carport
//
//  Created by 吴桂钊 on 2017/2/14.
//  Copyright © 2017年 86gg.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kRentCarTimeCell = @"RentCarTimeCell";
@interface RentCarTimeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nonHolidayPrie;
@property (weak, nonatomic) IBOutlet UILabel *holidayPrie;

@end
