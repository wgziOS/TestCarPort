//
//  RentCarTimeCell.h
//  carport
//
//  Created by 吴桂钊 on 2017/2/14.
//  Copyright © 2017年 86gg.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kRentCarTimeCell = @"RentCarTimeCell";
@interface RentCarTimeCell : UITableViewCell<UUDatePickerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nonHolidayPrie;
@property (weak, nonatomic) IBOutlet UILabel *holidayPrie;

@property (weak, nonatomic) IBOutlet UITextField *startTimeTextfield;
@property (weak, nonatomic) IBOutlet UITextField *endTimeTextfield;

@property(nonatomic,strong) void (^startTimeBlock)(NSString *);
@property(nonatomic,strong) void (^endTimeBlock)(NSString *);
@end
