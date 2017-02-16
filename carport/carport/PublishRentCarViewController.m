//
//  PublishRentCarViewController.m
//  carport
//
//  Created by 吴桂钊 on 2017/2/13.
//  Copyright © 2017年 86gg.cn. All rights reserved.
//

#import "PublishRentCarViewController.h"
#import "WGZaddCatPortImgView.h"
#import "PublishRentCarInfoCell.h"

@interface PublishRentCarViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UUDatePickerDelegate>
{
    
    NSString * boxValue;
    NSString * configurationValue;
    NSString * displacementValue;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *ownerNameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *ownerPhoneTextfield;
@property (weak, nonatomic) IBOutlet UITextField *startTimeTextfield;
@property (weak, nonatomic) IBOutlet UITextField *endTimeTextfield;
@property (weak, nonatomic) IBOutlet UITextField *holidayPriceTextfield;
@property (weak, nonatomic) IBOutlet UITextField *normalPriceTextfield;
@property (weak, nonatomic) IBOutlet UITextField *pledgePriceTextfield;
@property (weak, nonatomic) IBOutlet UITextField *addressTextfield;
@property (weak, nonatomic) IBOutlet UITextField *needToKnowTextfield;

@property (strong, nonatomic) WGZaddCatPortImgView * carImgView;
@property (strong, nonatomic) WGZaddCatPortImgView * papersImgView;
@property (strong, nonatomic) NSString * carImgString;//车照片str
@property (strong, nonatomic) NSString * papersImgString;//


@end

@implementation PublishRentCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fun];
    [self addUUDate];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
     [self.tableView registerNib:[UINib nibWithNibName:kPublishRentCarInfoCell bundle:nil] forCellReuseIdentifier:kPublishRentCarInfoCell];
    
}

#pragma mark - tableView

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PublishRentCarInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:kPublishRentCarInfoCell];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
    
    
    cell.carImgBlock = ^(NSString *cartext){
        NSLog(@"car-base64=%@",cartext);
    };
    
    cell.papersImgBlock = ^(NSString *text){
        NSLog(@"par-base64=%@",text);
    };
    
    cell.carSizeBlock = ^(NSString *text){
        NSLog(@"size=%@",text);
    };
    
    cell.plateNumBlock = ^(NSString *text){
        NSLog(@"num=%@",text);
    };
    
    cell.seatCountBlock = ^(NSString *text){
        NSLog(@"seat=%@",text);
    };
    
    cell.buyCarYearBlock = ^(NSString *text){
        NSLog(@"year=%@",text);
    };
    
    cell.kmBlock = ^(NSString *text){
        NSLog(@"km=%@",text);
    };
    
    cell.boxBtnBlock = ^(){
        boxValue = cell.boxValue;
        NSLog(@"box-tag=%@",boxValue);
    };
    
    cell.configurationBtnBlock = ^(){
        configurationValue = cell.configurationValue;
        NSLog(@"配置tag=%@",configurationValue);
    };
    
    cell.displacementBtnBlock = ^(){
        displacementValue = cell.displacementValue;
        NSLog(@"排量tag=%@",displacementValue);
    };
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 495;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PublishRentCarInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:kPublishRentCarInfoCell];
//    [self textFieldDidEndEditing:cell.seatCountTextfield];
//    cell.seatCountTextfield.delegate = self;
    [cell.seatCountTextfield resignFirstResponder];
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

//下面为了防止UItextfield弹出键盘
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (textField==self.startTimeTextfield) {
        return NO;
    }
    if (textField==self.endTimeTextfield) {
        return NO;
    }
    return YES;
}

#pragma mark - publish
- (IBAction)publishBtnClick:(id)sender {
 
}
//textField 协议
-(void)fun
{
    _ownerNameTextfield.delegate = self;
    _ownerPhoneTextfield.delegate = self;
//    _startTimeTextfield.delegate = self;
//    _endTimeTextfield.delegate = self;
    _holidayPriceTextfield.delegate = self;
    _normalPriceTextfield.delegate = self;
    _pledgePriceTextfield.delegate = self;
    _addressTextfield.delegate = self;
    _needToKnowTextfield.delegate = self;
}
//文本框return收回键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
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
