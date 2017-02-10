//
//  PublishCarPortViewController.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/12.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import "PublishCarPortViewController.h"
#import "WGZaddCatPortImgView.h"
#import "IsBlankString.h"
@interface PublishCarPortViewController ()<UITextFieldDelegate,UITextViewDelegate,UUDatePickerDelegate>
{
    WGZToggleButton * manageButton;
    
    NSUserDefaults * userDefault;
    
    
}

@property (weak, nonatomic) IBOutlet UILabel *shangchuangLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeight;
@property (weak, nonatomic) IBOutlet UIView *bottonView;
@property (weak, nonatomic) IBOutlet UITextField *startTimeTextfield;
@property (weak, nonatomic) IBOutlet UITextField *endTimeTextfield;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet UIView *imgLineView;//分割线

@property (weak, nonatomic) IBOutlet UITextField *carPortTitle;//title
@property (weak, nonatomic) IBOutlet UITextField *userName;//车主
@property (weak, nonatomic) IBOutlet UITextField *PlateNumber;//原始编号
@property (weak, nonatomic) IBOutlet UITextField *priceTextfield;//价格
@property (weak, nonatomic) IBOutlet UITextField *hoursTextfield;//满几小时
@property (weak, nonatomic) IBOutlet UITextField *discountTextfield;//几折优惠
@property (weak, nonatomic) IBOutlet UITextField *addressTextfield;//车位地址
@property (weak, nonatomic) IBOutlet UITextField *parkingEntranceTextfield;//入口
@property (weak, nonatomic) IBOutlet UITextView *describeTextView;//详细描述

@property (strong, nonatomic) NSString * entryModeStr;//进入方式
@property (strong, nonatomic) NSString * manageStr;//车位管理方式
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) NSString * selectTime;
//@property (strong, nonatomic) WGZaddImagesView * addImageView;
@property (strong, nonatomic) WGZaddCatPortImgView * addcarPortImgView;
@property (strong, nonatomic) NSString * carPortImgString;//车位照片str
@property (strong, nonatomic) WGZaddCatPortImgView * addMapImgView;
@property (strong, nonatomic) NSString * mapImgString;//车位照片str
@property (strong, nonatomic) NSString * userLongitude;
@property (strong, nonatomic) NSString * userLatitude;
@end

@implementation PublishCarPortViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"发布车位";
    
    userDefault = [NSUserDefaults standardUserDefaults];
    self.userLongitude = [userDefault objectForKey:@"userLongitude"];
    self.userLatitude = [userDefault objectForKey:@"userLatitude"];
    
    
    self.scrollViewHeight.constant = self.sureButton.frame.origin.y + 80;

    //时间选择器
    [self addUUDate];
    
    CGFloat labelX = self.imgLineView.frame.origin.x;
    CGFloat labelY = self.imgLineView.frame.origin.y;
    //多图片
//    _addImageView = [[WGZaddImagesView alloc]initWithFrame:CGRectMake(labelX, labelY, SCREENWITH, 150)];
//    [self.bottonView addSubview:_addImageView];
    
    _addcarPortImgView = [[WGZaddCatPortImgView alloc]initWithFrame:CGRectMake(labelX+100, labelY+10, 60, 60) andImageStr:@"cwcz-tjtp.png"];
    [self.bottonView addSubview:_addcarPortImgView];
    
    _addMapImgView = [[WGZaddCatPortImgView alloc]initWithFrame:CGRectMake(labelX +20, labelY+ 10, 60, 60) andImageStr:@"cwcz-dht@3x"];
    [self.bottonView addSubview:_addMapImgView];
    
    [self addManageModeButton];
    [self addEntryModeButton];
    self.parkingEntranceTextfield.delegate = self;
    self.describeTextView.delegate = self;
//    NSLog(@"ididid=%@",_id);
}
#pragma mark - 确定按钮
- (IBAction)buttonClick:(id)sender {
    
    NSInteger time = [self turnSringToTimeIntervalWithString:_startTimeTextfield.text];
    NSInteger time1 = [self turnSringToTimeIntervalWithString:_endTimeTextfield.text];
    NSString * start = [NSString stringWithFormat:@"/Date(%ld000)/",(long)time];
    NSString * end = [NSString stringWithFormat:@"/Date(%ld000)/",(long)time1];
    
//    NSString *baseb4_1 = [self image2DataURL:_addMapImgView.image];
//    NSString *baseb4_2 = [self image2DataURL:_addcarPortImgView.image];
    
    NSString *baseb4_1 = [NSString stringWithFormat:@"data: image/png;base64,%@",[self UIImageToBase64Str:_addMapImgView.image]];
    NSString *baseb4_2 = [NSString stringWithFormat:@"data: image/png;base64,%@",[self UIImageToBase64Str:_addcarPortImgView.image]];
    
//    NSLog(@"baseb4_1-----==--=======%@",baseb4_1);
//    NSLog(@"baseb4_2-----==--=======%@",baseb4_2);
 
    NSString * describe = [NSString stringWithFormat:@"<p>%@</p>",_describeTextView.text];
   
    NSString * discount = [NSString stringWithFormat:@"%f",[_discountTextfield.text floatValue]];
    
    if ([IsBlankString isBlankString:_id]) {//判断id
        NSDictionary * json = @{
                                @"ParkingSpace": @{
                                        @"username": _userName.text,
                                        @"user_address": _addressTextfield.text,
                                        @"park_price": _priceTextfield.text,
                                        @"plate_number": _PlateNumber.text,
                                        @"starttime": start,
                                        @"endtime": end,
                                        @"X_coordinate": self.userLongitude,
                                        @"Y_coordinate": self.userLatitude,
                                        @"title": _carPortTitle.text,
                                        @"describe": describe,
                                        @"parking_entrance": _parkingEntranceTextfield.text,
                                        @"parking_manage": _manageStr,
                                        @"entry_mode": _entryModeStr,
                                        @"hours": _hoursTextfield.text,
                                        @"discount": discount,
                                        @"navigation_imgurl": baseb4_1
                                        },
                                @"listImg": @[
                                        @{
                                            @"imgurl": baseb4_2
                                            }
                                        ]
                                };
        NSString * jsonStr = [DicToJson dictionaryToJson:json];
        NSLog(@"发布jsonStr=%@",jsonStr);
        
        [self postWithJson:jsonStr];
    }else{
        NSDictionary * json = @{
                                @"ParkingSpace": @{
                                        @"id": _id,
                                        @"username": _userName.text,
                                        @"user_address": _addressTextfield.text,
                                        @"park_price": _priceTextfield.text,
                                        @"plate_number": _PlateNumber.text,
                                        @"starttime": start,
                                        @"endtime": end,
                                        @"X_coordinate": self.userLongitude,
                                        @"Y_coordinate": self.userLatitude,
                                        @"title": _carPortTitle.text,
                                        @"describe": describe,
                                        @"parking_entrance": _parkingEntranceTextfield.text,
                                        @"parking_manage": _manageStr,
                                        @"entry_mode": _entryModeStr,
                                        @"hours": _hoursTextfield.text,
                                        @"discount": discount,
                                        @"navigation_imgurl": baseb4_1
                                        },
                                @"listImg": @[
                                        @{
                                            @"imgurl": baseb4_2
                                            }
                                        ]
                                };
        NSString * jsonStr = [DicToJson dictionaryToJson:json];
        NSLog(@"发布jsonStr=%@",jsonStr);
        
        [self postWithJson:jsonStr];

    }
    
}
#pragma mark - 字符串转时间戳
-(NSTimeInterval)turnSringToTimeIntervalWithString:(NSString *)str
{
    NSDateFormatter * dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date =[dateFormat dateFromString:str];
    //将NSDate对象转换为时间戳
    NSTimeInterval dis = [date timeIntervalSince1970];//时间戳是一个double类型
    return dis;
}

#pragma mark - 图片转base64字符串
-(NSString *)UIImageToBase64Str:(UIImage *) image
{//
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}
#pragma mark - 获取数据
- (void)postWithJson:(NSString *)jsonStr
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    userDefault = [NSUserDefaults standardUserDefaults];
    [params setObject:[userDefault valueForKey:@"Token"] forKey:@"Token"];
    [params setObject:jsonStr forKey:@"Json"];
    __weak __typeof(self)weakSelf = self;
    [MHNetworkManager postReqeustWithURL:API_SUBMIT_PARKING_SPACE_URL params:params successBlock:^(NSDictionary *returnData) {
        
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
- (void)succeedAlert
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"发布成功" preferredStyle:  UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self viewDidLoad];
        [self setTextfieldNil];
    }]];
    
    [self presentViewController:alert animated:true completion:nil];
}

-(void)setTextfieldNil{
    
    [_startTimeTextfield setText:@""];
    [_endTimeTextfield setText:@""];
    [_carPortTitle setText:@""];
    [_userName setText:@""];
    [_PlateNumber setText:@""];
    [_priceTextfield setText:@""];
    [_hoursTextfield setText:@""];
    [_discountTextfield setText:@""];
    [_addressTextfield setText:@""];
    [_parkingEntranceTextfield setText:@""];
    [_describeTextView setText:@""];

}
-(void)goLogin
{
    LGViewController *LGVC = [[LGViewController alloc]init];
    [self.navigationController pushViewController:LGVC animated:YES];
}

#pragma mark - 加载entryMode button
-(void)addEntryModeButton
{
    CGFloat y = self.imgLineView.frame.origin.y;
    NSArray * array = @[@"fbcw-kdd.jpg",@"fbcw-bmz.jpg",@"fbcw-ddh.jpg"];
    NSArray * DJArray = @[@"fbcw-kdd-dj.jpg",@"fbcw-bmz-dj.jpg",@"fbcw-ddh-dj.jpg"];
    for (int i = 0; i<3 ;i++) {
        manageButton = [WGZToggleButton buttonWithOnImage:[UIImage imageNamed:DJArray[i]] offImage:[UIImage imageNamed:array[i]] highlightedImage:[UIImage imageNamed:array[i]]];
        manageButton.tag = i+4;
        if (i == 2) {
            manageButton.frame = CGRectMake(81, y+188, 75, 25);
        }else{
            manageButton.frame = CGRectMake(81+i*85, y+155, 75, 25);
        }
        [manageButton addTarget:self action:@selector(entryModeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottonView addSubview:manageButton];
    }
    
}
-(void)addManageModeButton
{
    CGFloat y = self.imgLineView.frame.origin.y;
    NSArray * array = @[@"fbcw-wy.jpg",@"ck.jpg",@"fbcw-qt.jpg"];
    NSArray * DJArray = @[@"fbcw-wy-dj.jpg",@"ck-dj.jpg",@"fbcw-qt-dj.jpg"];
    for (int i = 0; i<3 ;i++) {
        manageButton = [WGZToggleButton buttonWithOnImage:[UIImage imageNamed:DJArray[i]] offImage:[UIImage imageNamed:array[i]] highlightedImage:[UIImage imageNamed:array[i]]];
        manageButton.frame = CGRectMake(81+i*60, y+105, 50, 25);
        manageButton.tag = i+1;
        [manageButton addTarget:self action:@selector(manageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottonView addSubview:manageButton];
    }
}
#pragma mark - 获取entryMode值
-(void)entryModeButtonClick:(WGZToggleButton *)sender
{
    WGZToggleButton * button = sender;
    NSInteger a  = sender.tag;
    _entryModeStr = [NSString stringWithFormat:@"%ld",a-3];
    NSLog(@"_entryModeStr=%@",_entryModeStr);
    switch (button.tag) {
        case 4:
        {
            if (button.on == NO) {
                for (WGZToggleButton * btn in self.bottonView.subviews)
                {
                    if (btn.tag == 5)
                    {
                        [btn setEnabled:YES];
                    }
                    if (btn.tag == 6)
                    {
                        [btn setEnabled:YES];
                    }
                }
            }
            if (button.on == YES)
            {
                for (WGZToggleButton * btn in self.bottonView.subviews)
                {
                    if (btn.tag == 5)
                    {
                        [btn setEnabled:NO];
                    }
                    if (btn.tag == 6)
                    {
                        [btn setEnabled:NO];
                    }
                }
            }
            
        }
            break;
        case 5:
        {
            if (button.on == NO) {
                for (WGZToggleButton * btn in self.bottonView.subviews)
                {
                    if (btn.tag == 4)
                    {
                        [btn setEnabled:YES];
                    }
                    if (btn.tag == 6)
                    {
                        [btn setEnabled:YES];
                    }
                }
            }
            if (button.on == YES)
            {
                for (WGZToggleButton * btn in self.bottonView.subviews)
                {
                    if (btn.tag == 4)
                    {
                        [btn setEnabled:NO];
                    }
                    if (btn.tag == 6)
                    {
                        [btn setEnabled:NO];
                    }
                }
            }
            
        }
            break;
        case 6:
        {
            if (button.on == NO) {
                for (WGZToggleButton * btn in self.bottonView.subviews)
                {
                    if (btn.tag == 5)
                    {
                        [btn setEnabled:YES];
                    }
                    if (btn.tag == 4)
                    {
                        [btn setEnabled:YES];
                    }
                }
            }
            if (button.on == YES)
            {
                for (WGZToggleButton * btn in self.bottonView.subviews)
                {
                    if (btn.tag == 5)
                    {
                        [btn setEnabled:NO];
                    }
                    if (btn.tag == 4)
                    {
                        [btn setEnabled:NO];
                    }
                }
            }
            
        }
            break;
        default:
            break;
    }

}

-(void)manageButtonClick:(WGZToggleButton *)sender
{
    WGZToggleButton * button = sender;
    _manageStr = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    NSLog(@"%@",_manageStr);
    switch (button.tag) {
        case 1:
        {
            if (button.on == NO) {
                for (WGZToggleButton * btn in self.bottonView.subviews)
                {
                    if (btn.tag == 2)
                    {
                        [btn setEnabled:YES];
                    }
                    if (btn.tag == 3)
                    {
                        [btn setEnabled:YES];
                    }
                }
            }
            if (button.on == YES)
            {
                for (WGZToggleButton * btn in self.bottonView.subviews)
                {
                    if (btn.tag == 2)
                    {
                        [btn setEnabled:NO];
                    }
                    if (btn.tag == 3)
                    {
                        [btn setEnabled:NO];
                    }
                }
            }

        }
            break;
        case 2:
        {
            if (button.on == NO) {
                for (WGZToggleButton * btn in self.bottonView.subviews)
                {
                    if (btn.tag == 1)
                    {
                        [btn setEnabled:YES];
                    }
                    if (btn.tag == 3)
                    {
                        [btn setEnabled:YES];
                    }
                }
            }
            if (button.on == YES)
            {
                for (WGZToggleButton * btn in self.bottonView.subviews)
                {
                    if (btn.tag == 1)
                    {
                        [btn setEnabled:NO];
                    }
                    if (btn.tag == 3)
                    {
                        [btn setEnabled:NO];
                    }
                }
            }

        }
            break;
        case 3:
        {
            if (button.on == NO) {
                for (WGZToggleButton * btn in self.bottonView.subviews)
                {
                    if (btn.tag == 2)
                    {
                        [btn setEnabled:YES];
                    }
                    if (btn.tag == 1)
                    {
                        [btn setEnabled:YES];
                    }
                }
            }
            if (button.on == YES)
            {
                for (WGZToggleButton * btn in self.bottonView.subviews)
                {
                    if (btn.tag == 1)
                    {
                        [btn setEnabled:NO];
                    }
                    if (btn.tag == 2)
                    {
                        [btn setEnabled:NO];
                    }
                }
            }

        }
            break;
        default:
            break;
    }

}

#pragma mark - 时间选择器
-(void)addUUDate
{
    //时间选择控件
    UUDatePicker *datePicker = [[UUDatePicker alloc]initWithframe:CGRectMake(0, 0, SCREEN_WIDTH, 200)
                                                      PickerStyle:0
                                                      didSelected:^(NSString *year,
                                                                    NSString *month,
                                                                    NSString *day,
                                                                    NSString *hour,
                                                                    NSString *minute,
                                                                    NSString *weekDay) {
                                                          _startTimeTextfield.text = [NSString stringWithFormat:@"%@-%@-%@ %@:%@",year,month,day,hour,minute];
                                                          
                                                      }];
    datePicker.minLimitDate = [[NSDate date]dateByAddingTimeInterval:0];
    _startTimeTextfield.inputView = datePicker;
    
    UUDatePicker * datePickers = [[UUDatePicker alloc]initWithframe:CGRectMake(0, 0, SCREEN_WIDTH, 200)
                                                           Delegate:self
                                                        PickerStyle:UUDateStyle_YearMonthDayHourMinute];
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
    _endTimeTextfield.text = [NSString stringWithFormat:@"%@-%@-%@ %@:%@",year,month,day,hour,minute];
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
- (void)textFieldDidEndEditing:(UITextField *)sender
{

    [sender resignFirstResponder];
}

//点击背景收起键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.bottonView endEditing:YES];//实现该方法是需要注意view需要是继承UIControl而来的

}
//文本框return收回键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
#pragma mark - 地图详情
- (IBAction)checkMapClick:(id)sender {
    
}
#pragma mark - textView 代理方法
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //
    //地址字符串转经纬字符串
    
}



@end
