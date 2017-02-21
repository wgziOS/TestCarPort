//
//  PublishRentCarViewController.m
//  carport
//
//  Created by 吴桂钊 on 2017/2/13.
//  Copyright © 2017年 86gg.cn. All rights reserved.
//

#import "PublishRentCarViewController.h"

@interface PublishRentCarViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UUDatePickerDelegate>
{
    NSUserDefaults * userDefault;
    
    NSString * boxValue;
    NSString * configurationValue;
    NSString * displacementValue;
    NSString * start;
    NSString * end;
    NSString * carBase64;
    NSString * papersBase64;
    NSString * plateNumber;
    NSString * carSize;
    NSString * seatCount;
    NSString * buyCarYear;
    NSString * kmString;
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
#pragma mark - publish
- (IBAction)publishBtnClick:(id)sender {
   
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否发布" preferredStyle:  UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (![IsBlankString isBlankString:_startTimeTextfield.text] &&
            ![IsBlankString isBlankString:_endTimeTextfield.text] &&
            ![IsBlankString isBlankString:_ownerNameTextfield.text] &&
            ![IsBlankString isBlankString:_ownerPhoneTextfield.text] &&
            ![IsBlankString isBlankString:carBase64] &&
            ![IsBlankString isBlankString:papersBase64]
            ) {
            NSInteger time = [self turnSringToTimeIntervalWithString:_startTimeTextfield.text];
            NSInteger time1 = [self turnSringToTimeIntervalWithString:_endTimeTextfield.text];
            //        NSLog(@"time1=%ld",(long)time1);
            start = [NSString stringWithFormat:@"/Date(%ld000)/",(long)time];
            end = [NSString stringWithFormat:@"/Date(%ld000)/",(long)time1];
            NSLog(@"发布时endtime=%@",end);//
            
            [self turnJson];
        }else
        {
            [Calculate_frame showWithText:@"信息填写不全"];
            return;
        }

  
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:true completion:nil];
    
    
}
#pragma mark - turnJson
-(void)turnJson
{
    NSDictionary * json = @{
                            @"listImg" : @[
                                    @{
                                        @"imgurl" : carBase64
//                                        @"imgurl" : @""
                                        },
                                    @{
                                        @"imgurl" : papersBase64
//                                        @"imgurl" : @""
                                        }
                                    ],
                            @"VehicleInformation" : @{
                                    @"owner_name":_ownerNameTextfield.text,
                                    @"owner_phone":_ownerPhoneTextfield.text,
                                    @"plate_number":plateNumber,
                                    @"car_size":carSize,
                                    @"seat_count":seatCount,
                                    @"buy_car_year":buyCarYear,
                                    @"kilometers_traveled":kmString,
                                    @"variable_box":boxValue,
                                    @"engine_displacement":displacementValue,
                                    @"starttime":start,
                                    @"endtime":end,
                                    @"non_holiday_prie":_normalPriceTextfield.text,
                                    @"holiday_prie":_holidayPriceTextfield.text,
                                    @"deposited_price":_pledgePriceTextfield.text,
                                    @"car_address":_addressTextfield.text,
                                    @"take_car":_needToKnowTextfield.text,
                                    @"descinfo":@"5445",
                                    @"remarks":configurationValue //配置
                                    }
                            };
    NSString * jsonStr = [DicToJson dictionaryToJson:json];
    
//    NSLog(@"发布租车json==%@",jsonStr);
    
    [self postWithJson:jsonStr];
}
#pragma mark - 网络请求 发布车位
- (void)postWithJson:(NSString *)jsonStr
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    userDefault = [NSUserDefaults standardUserDefaults];
    [params setObject:[userDefault valueForKey:@"Token"] forKey:@"Token"];
    [params setObject:jsonStr forKey:@"Json"];
    __weak __typeof(self)weakSelf = self;
    [MHNetworkManager postReqeustWithURL:API_SUBMIT_VEHICLE_INFORMATION_URL params:params successBlock:^(NSDictionary *returnData) {
        
        [Calculate_frame showWithText:[returnData objectForKey:@"message"]];
        
        NSString * str = [NSString stringWithFormat:@"%@",[returnData objectForKey:@"states"]];
        
        switch ([str intValue]) {
            case 1:
            {//发布成功
                [weakSelf succeedAlert];
            }
                break;
            case -1:
            {
                //先登录
                [weakSelf goLogin];
            }
                break;
                
            default:
                break;
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"error=%@",error);
        [Calculate_frame showWithText:@"网络请求失败"];
    } showHUD:YES];
    
}

#pragma mark - tableView

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PublishRentCarInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:kPublishRentCarInfoCell];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
    
    cell.carImgBlock = ^(NSString *cartext){
        carBase64 = cartext;
    };
    
    cell.papersImgBlock = ^(NSString *text){
        papersBase64 = text;
    };
    
    cell.carSizeBlock = ^(NSString *text){
        carSize = text;
    };
    
    cell.plateNumBlock = ^(NSString *text){
        plateNumber = text;
    };
    
    cell.seatCountBlock = ^(NSString *text){
        seatCount = text;
    };
    
    cell.buyCarYearBlock = ^(NSString *text){
        buyCarYear = text;
    };
    
    cell.kmBlock = ^(NSString *text){
        kmString = text;
    };
    
    cell.boxBtnBlock = ^(){
        boxValue = cell.boxValue;
    };
    
    cell.configurationBtnBlock = ^(){
        configurationValue = cell.configurationValue;
    };
    
    cell.displacementBtnBlock = ^(){
        displacementValue = cell.displacementValue;
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

#pragma mark - 字符串转时间戳 - nian
-(NSTimeInterval)turnSringToTimeIntervalWithString:(NSString *)str
{
    NSDateFormatter * dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *date =[dateFormat dateFromString:str];
    //将NSDate对象转换为时间戳
    NSTimeInterval dis = [date timeIntervalSince1970];//时间戳是一个double类型
    return dis;
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
#pragma mark -发布后弹出框
- (void)succeedAlert
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"发布成功" preferredStyle:  UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self viewDidLoad];//重新加载
        [self.tableView reloadData];
        [self setTextfieldNil];
    }]];
    
    [self presentViewController:alert animated:true completion:nil];
}

-(void)setTextfieldNil{
    
    [_startTimeTextfield setText:@""];
    [_endTimeTextfield setText:@""];
    [_ownerNameTextfield setText:@""];
    [_ownerPhoneTextfield setText:@""];
    [_pledgePriceTextfield setText:@""];
    [_normalPriceTextfield setText:@""];
    [_holidayPriceTextfield setText:@""];
    [_addressTextfield setText:@""];
    [_needToKnowTextfield setText:@""];
    
}
-(void)goLogin
{
    LGViewController *LGVC = [[LGViewController alloc]init];
    [self.navigationController pushViewController:LGVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
