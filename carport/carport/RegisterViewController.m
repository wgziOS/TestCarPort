//
//  RegisterViewController.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/5.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate>
{
     NSUserDefaults * userDefault;
}
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;//codeTextField
@property (weak, nonatomic) IBOutlet UIButton *codeButton;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"加入我们";
    //手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(restoredAndHiedBoard)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
    //获取token
    [self getToken];


    
}
#pragma mark - 获取验证码
- (IBAction)onGetCodeAction:(id)sender
{
    [self hideKeyboard];
    
    NSString *phoneNumber = _phoneNumberTextField.text;
    
    if ([phoneNumber length] == 0) {
        [Calculate_frame showWithText:@"请填写手机号码"];
        return;
    }
    
    if ([phoneNumber length] != 11) {
        [Calculate_frame showWithText:@"请输入11位手机号码"];
        return;
    }
    
    self.isRequestRunning = YES;

    //获取验证码
    userDefault = [NSUserDefaults standardUserDefaults];
    [self getPhoneCode:_phoneNumberTextField.text andToken:[userDefault objectForKey:@"Token"]];
}
#pragma mark - 获取验证码 1
- (void)getPhoneCode:(NSString *)phone andToken:(NSString *)token
{
    [Calculate_frame showWithHUD];
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:phone forKey:@"Phone"];
    [params setObject:token forKey:@"Token"];

    [MHNetworkManager postReqeustWithURL:API_SEND_PHONE_CODE_URL params:params successBlock:^(NSDictionary *returnData) {
        [Calculate_frame dismiss];
        
        if ([[returnData objectForKey:@"states"] integerValue] == 1) {
            NSString * message = [returnData objectForKey:@"message"];
            [Calculate_frame showWithText:message];
            //倒计时
            [self codeTimerStart];
            
        }else{
            NSString *error = [[returnData objectForKey:@"message"]description];
            [Calculate_frame showWithText:error];
        }
    } failureBlock:^(NSError *error) {
        
    } showHUD:NO];
}
- (void)codeTimerStart
{
    if (self.codeTimer) {
        return;
    }
    
    self.codeTimerCount = 180;
    [_codeButton setTintColor:[UIColor grayColor]];
    [_codeButton setTitle:[NSString stringWithFormat:@"%d秒", self.codeTimerCount--] forState:UIControlStateNormal];
    self.codeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(codeTimerDo) userInfo:nil repeats:YES];
}
- (void)codeTimerDo
{
    if (self.codeTimerCount >= 0) {
        [_codeButton setTitle:[NSString stringWithFormat:@"%d秒", self.codeTimerCount--] forState:UIControlStateNormal];
    } else {
        [self codeTimerStop];
    }
}
- (void)codeTimerStop
{
    if (self.codeTimer) {
        [self.codeTimer invalidate];
        self.codeTimer = nil;
        
        [_codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _codeButton.titleLabel.font = [UIFont systemFontOfSize:10.f];
        [_codeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}
#pragma mark 获取Token
-(void)getToken
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json",@"text/plain", nil];
    //通过 appid  secret 认证code . 来发送获取token的请求
    [manager GET:API_TOKEN_URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {  //获得token
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:[dic valueForKey:@"Token"] forKey:@"Token"];
        [userDefault synchronize];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error %@",error.localizedFailureReason);
    }];

}


- (void)onEditingDidEndOnExit:(id)sender
{
    UITextField *textField = sender;
    [textField resignFirstResponder];
}
#pragma mark 注册点击事件
- (IBAction)registerClick:(id)sender {
    [self hideKeyboard];
    
    NSString *phoneNumber = _phoneNumberTextField.text;
    
    if ([phoneNumber length] == 0) {
        [Calculate_frame showWithText:@"请填写手机号码"];
        return;
    }
    
    if ([phoneNumber length] != 11) {
        [Calculate_frame showWithText:@"请输入11位手机号码"];
        return;
    }
    
    NSString *password = _passWordTextField.text;
    if ([password length] == 0) {
        [Calculate_frame showWithText:@"请设置登录密码"];
        return;
    }
    
    if( _passWordTextField.text.length < 6 || _passWordTextField.text.length > 16 ){
        [Calculate_frame showWithText:@"密码为6-16位的数字或字母"];
        return;
    }
    
    NSString *code = _codeTextField.text;
    if ([code length] == 0) {
        [Calculate_frame showWithText:@"请输入验证码"];
        return;
    }
    
    self.isRequestRunning = YES;
    //注册接口请求
    [self postRegister];
}
#pragma mark - 注册
- (void)postRegister{
    [Calculate_frame showWithHUD];
    
    NSString * TEACHERreg          = [Calculate_frame md5:_passWordTextField.text];
    NSString * TEACHERLowerreg     = [TEACHERreg lowercaseString];    //小写
    
    userDefault = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:_phoneNumberTextField.text forKey:@"Phone"];
    [params setObject:TEACHERLowerreg forKey:@"Password"];
    [params setObject:_codeTextField.text forKey:@"Code"];
    [params setObject:[userDefault objectForKey:@"Token"] forKey:@"Token"];
    NSLog(@"params=%@",params);
//    http://192.168.123.73:8090/API/Register?Token=39625555fff94a63ae361add7c470ad3&Phone=13646017098&Password=e10adc3949ba59abbe56e057f20f883e&Code=992536

    [MHNetworkManager postReqeustWithURL:API_REGISTER_URL params:params successBlock:^(NSDictionary *returnData) {
        [Calculate_frame dismiss];
        NSLog(@"message==%@",[returnData valueForKey:@"message"]);
        if ([[returnData objectForKey:@"states"] integerValue] == 1) {
            
            NSString *mss = [[returnData objectForKey:@"message"]description];
            [Calculate_frame showWithText:mss];

            [self.navigationController popViewControllerAnimated:YES];
        }else{
            NSString *error = [[returnData objectForKey:@"message"]description];
            [Calculate_frame showWithText:error];
        }
    } failureBlock:^(NSError *error) {
        
    } showHUD:NO];
}

- (IBAction)gobackClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 隐藏软键盘
-(void)restoredAndHiedBoard {
    
//    if (SCREENHEIGHT == 480) {
//        CGRect frame = self.view.frame;
//        frame.size.height = SCREENHEIGHT;
//        //通过定时器确定延缓执行掩藏
//        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
//            
//            //将textView的高度收起。恢复高度
//            self.view.frame = frame;
//            
//        } completion:nil];
//    }
    
    [self hideKeyboard];
}
- (void)hideKeyboard
{
    [self.passWordTextField resignFirstResponder];
    [self.phoneNumberTextField resignFirstResponder];
    [self.codeTextField resignFirstResponder];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
