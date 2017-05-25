//
//  RentCarTimeCell.m
//  carport
//
//  Created by 吴桂钊 on 2017/2/14.
//  Copyright © 2017年 86gg.cn. All rights reserved.
//

#import "RentCarTimeCell.h"

@implementation RentCarTimeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    _startTimeTextfield.delegate = self;
    _endTimeTextfield.delegate = self;
    [self addUUDate];
    
    
    [self.startTimeTextfield addTarget:self action:@selector(textfieldTextDidChange:) forControlEvents:UIControlEventEditingChanged];
    
//    [self.endTimeTextfield addTarget:self action:@selector(textfieldTextDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.endTimeTextfield addTarget:self action:@selector(textfieldTextDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(logoTap)];
    [self addGestureRecognizer:tap];
    
}

-(void)logoTap{
    [_startTimeTextfield resignFirstResponder];
    [_endTimeTextfield resignFirstResponder];
    
    self.startTimeBlock(self.startTimeTextfield.text);
    self.endTimeBlock(self.endTimeTextfield.text);
}
#pragma mark - 时间选择器
-(void)addUUDate
{
    //时间选择控件
    UUDatePicker *datePicker = [[UUDatePicker alloc]initWithframe:CGRectMake(0, 0, SCREEN_WIDTH, 200)
                                                      PickerStyle:UUDateStyle_YearMonthDay
                                                      didSelected:^(NSString *year,
                                                                    NSString *month,
                                                                    NSString *day,
                                                                    NSString *hour,
                                                                    NSString *minute,
                                                                    NSString *weekDay) {
                                                          _startTimeTextfield.text = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
                                                          
                                                      }];
    datePicker.minLimitDate = [[NSDate date]dateByAddingTimeInterval:0];
    _startTimeTextfield.inputView = datePicker;
    
    UUDatePicker * datePickers = [[UUDatePicker alloc]initWithframe:CGRectMake(0, 0, SCREEN_WIDTH, 200)
                                                           Delegate:self
                                                        PickerStyle:UUDateStyle_YearMonthDay];
    datePickers.minLimitDate = [[NSDate date]dateByAddingTimeInterval:0];
    _endTimeTextfield.inputView = datePickers;
    //
}
#pragma mark - UUDatePicker's delegate
- (void)uuDatePicker:(UUDatePicker *)datePicker
                year:(NSString *)year
               month:(NSString *)month
                 day:(NSString *)day
                hour:(NSString *)hour
              minute:(NSString *)minute
             weekDay:(NSString *)weekDay
{
    //赋值
    _endTimeTextfield.text = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
    //
}

////下面为了防止UItextfield弹出键盘
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    
//    if (textField==self.startTimeTextfield) {
//        return NO;
//    }
//    if (textField==self.endTimeTextfield) {
//        return NO;
//    }
//    return YES;
//}
#pragma mark - private method

- (void)textfieldTextDidChange:(UITextField *)textField
{
    
    switch ([[NSString stringWithFormat:@"%ld",(long)textField.tag] intValue]) {
        case 201:
        {
            self.startTimeBlock(self.startTimeTextfield.text);
        }
            break;
        case 202:
        {
            self.endTimeBlock(self.endTimeTextfield.text);
        }
            break;
               default:
            break;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
