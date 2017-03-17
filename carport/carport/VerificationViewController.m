//
//  VerificationViewController.m
//  carport
//
//  Created by 吴桂钊 on 2017/3/17.
//  Copyright © 2017年 86gg.cn. All rights reserved.
//

#import "VerificationViewController.h"
#import "WGZaddCatPortImgView.h"
#import "UserInfoModel.h"
@interface VerificationViewController ()
{
    int clickCount;
    NSUserDefaults *userDefault;
    UserInfoModel * Model;
    NSString * userID;
}
@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextfield;
@property (weak, nonatomic) IBOutlet UITextField *cardNumTextfield;
@property (weak, nonatomic) IBOutlet UILabel *bangdingLabel;
@property (weak, nonatomic) IBOutlet UITextField *weixinTextfield;
@property (weak, nonatomic) IBOutlet UIView *lineView;//中间分隔线
@property (weak, nonatomic) IBOutlet UIButton *tongyiBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headImgView;//头像
@property (strong, nonatomic) WGZaddCatPortImgView * firstImgView;
@property (strong, nonatomic) WGZaddCatPortImgView * secondImgView;
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (strong, nonatomic) WGZaddCatPortImgView * thirdImgView;
@end

@implementation VerificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"验证信息";
    [self addThreeView];
    _bangdingLabel.hidden = YES;
    _cardNumTextfield.hidden = YES;
    clickCount = 1;
    [self.tongyiBtn setBackgroundImage:[UIImage imageNamed:@"同意"] forState:UIControlStateNormal];
    [self getUserBaseInfo];
}
#pragma mark - 获取数据
- (void)getUserBaseInfo
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    userDefault = [NSUserDefaults standardUserDefaults];
    [params setObject:[userDefault valueForKey:@"Token"] forKey:@"Token"];
    __weak __typeof(self)weakSelf = self;
    [MHNetworkManager postReqeustWithURL:API_GET_USER_BASE_INFO_URL params:params successBlock:^(NSDictionary *returnData) {
        
        NSLog(@"%@",returnData);
        NSString * str = [NSString stringWithFormat:@"%@",[returnData objectForKey:@"states"]];
        
        switch ([str intValue]) {
            case 1:
            {
            }
                break;
            case -1:
            {
                //先登录
//                [weakSelf goLogin];
            }
                break;
                
            default:
                break;
        }
        
        Model = [UserInfoModel mj_objectWithKeyValues:returnData];
        _nameTextfield.text = Model.truename;
        _phoneTextfield.text = Model.phone;
        _weixinTextfield.text = Model.weixin;
        userID = Model.id;
        
    } failureBlock:^(NSError *error) {
        [Calculate_frame showWithText:@"网络请求失败"];
    } showHUD:YES];
    
}

#pragma mark - 同意协议
- (IBAction)rememberButtonClick:(id)sender {
    if (clickCount == 1) {
        [self.tongyiBtn setBackgroundImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
        
        clickCount =2;
        return;
    }
    if (clickCount ==2) {
        [self.tongyiBtn setBackgroundImage:[UIImage imageNamed:@"同意"] forState:UIControlStateNormal];
        
        clickCount = 1;
        return;
    }
}
-(void)addThreeView{
    
//    CGFloat y = _lineView.frame.origin.y;
    
    _firstImgView = [[WGZaddCatPortImgView alloc]initWithFrame:CGRectMake(20, 40, 60, 60) andImageStr:@"传照片"];
    [self.middleView addSubview:_firstImgView];
    
    _secondImgView = [[WGZaddCatPortImgView alloc]initWithFrame:CGRectMake(90, 40, 60, 60) andImageStr:@"传照片"];
    [self.middleView addSubview:_secondImgView];
    
    _secondImgView = [[WGZaddCatPortImgView alloc]initWithFrame:CGRectMake(20, 162, 60, 60) andImageStr:@"驾驶证照片"];
    [self.middleView addSubview:_secondImgView];
    
}
#pragma mark - 保存
- (IBAction)saveBtnClick:(id)sender {
    [self turnJson];
}
#pragma mark - turnJson
-(void)turnJson
{
    NSString * str = [self UIImageToBase64Str:_firstImgView.image];
    NSString * str1 = [self UIImageToBase64Str:_secondImgView.image];
    NSString * str2 = [self UIImageToBase64Str:_thirdImgView.image];
    NSDictionary * json = @{
                            @"userid": userID,
                            @"IDcard_obverse": str,
                            @"IDcard_opposite": str1,
                            @"driver_license":  str2,
                            @"consent_agreement": @"1"
                            };
    NSString * jsonStr = [DicToJson dictionaryToJson:json];
    
    
    [self postBCWithJson:jsonStr];
}
#pragma mark - 图片转base64字符串
-(NSString *)UIImageToBase64Str:(UIImage *) image
{//
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}
#pragma mark - 网络请求
- (void)postBCWithJson:(NSString *)jsonStr
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    userDefault = [NSUserDefaults standardUserDefaults];
    [params setObject:[userDefault valueForKey:@"Token"] forKey:@"Token"];
    [params setObject:jsonStr forKey:@"Json"];
    __weak __typeof(self)weakSelf = self;
    [MHNetworkManager postReqeustWithURL:API_USER_VERIFICATION_SUBMIT_URL params:params successBlock:^(NSDictionary *returnData) {
        
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
//                [weakSelf goLogin];
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
#pragma mark -发布后弹出框
- (void)succeedAlert
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"保存成功" preferredStyle:  UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

    }]];
    
    [self presentViewController:alert animated:true completion:nil];
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
