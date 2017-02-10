//
//  ForgetPassWordViewController.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/14.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import "ForgetPassWordViewController.h"

@interface ForgetPassWordViewController ()
{
    NSUserDefaults * userDefault;
}
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextfield;
@property (weak, nonatomic) IBOutlet UITextField *codeTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextfield;
@property (weak, nonatomic) IBOutlet UITextField *againPassWordTextfield;
@property (weak, nonatomic) IBOutlet UIButton *codeButton;

@end

@implementation ForgetPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"忘记密码";
    //手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(restoredAndHiedBoard)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
    
}
#pragma mark 背景高度恢复
-(void)restoredAndHiedBoard {
    
    if (SCREENHEIGHT == 480) {
        CGRect frame = self.view.frame;
        frame.size.height = SCREENHEIGHT;
        //通过定时器确定延缓执行掩藏
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            
            //将textView的高度收起。恢复高度
            self.view.frame = frame;
            
        } completion:nil];
    }
    
    [self hideKeyboard];
}
#pragma mark 隐藏软键盘
- (void)hideKeyboard
{
    [self.phoneNumberTextfield resignFirstResponder];
    [self.codeTextfield resignFirstResponder];
    [self.passWordTextfield resignFirstResponder];
    [self.againPassWordTextfield resignFirstResponder];
   
}
#pragma mark - 获取验证码
- (IBAction)getCodeClick:(id)sender {
    [self hideKeyboard];
    
    NSString *phoneNumber = _phoneNumberTextfield.text;
    
    if ([phoneNumber length] == 0) {
        [Calculate_frame showWithText:@"请填写手机号码"];
        return;
    }
    
    if ([phoneNumber length] != 11) {
        [Calculate_frame showWithText:@"请输入11位手机号码"];
        return;
    }
    //获取验证码
    userDefault = [NSUserDefaults standardUserDefaults];
    [self getPhoneCode:_phoneNumberTextfield.text andToken:[userDefault objectForKey:@"Token"]];
    
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
        self.codeButton.userInteractionEnabled = NO;
    } else {
        [self codeTimerStop];
    }
}
- (void)codeTimerStop
{
    _codeButton.userInteractionEnabled = YES;
    if (self.codeTimer) {
        [self.codeTimer invalidate];
        self.codeTimer = nil;
        
        [_codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _codeButton.titleLabel.font = [UIFont systemFontOfSize:10.f];
        [_codeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}
- (IBAction)sureButtonClick:(id)sender {
    
    [self hideKeyboard];
    
    NSString *phoneNumber = _phoneNumberTextfield.text;
    
    if ([phoneNumber length] == 0) {
        [Calculate_frame showWithText:@"请填写手机号码"];
        return;
    }
    
    if ([phoneNumber length] != 11) {
        [Calculate_frame showWithText:@"请输入11位手机号码"];
        return;
    }
    
    NSString *password = _passWordTextfield.text;
    if ([password length] == 0) {
        [Calculate_frame showWithText:@"请设置登录密码"];
        return;
    }
    
    if( _passWordTextfield.text.length < 6 || _passWordTextfield.text.length > 16 ){
        [Calculate_frame showWithText:@"密码为6-16位的数字或字母"];
        return;
    }
    
    if (![_passWordTextfield.text isEqualToString:_againPassWordTextfield.text])
    {
        [Calculate_frame showWithText:@"两次输入的密码不一致"];
        return;
    }
    
    NSString *code = _codeTextfield.text;
    if ([code length] == 0) {
        [Calculate_frame showWithText:@"请输入验证码"];
        return;
    }
    

    //忘记密码接口请求
    [self postRect];

}
#pragma mark - 忘记密码请求
- (void)postRect{
    [Calculate_frame showWithHUD];
    
    NSString * TEACHERreg          = [Calculate_frame md5:_passWordTextfield.text];
    NSString * TEACHERLowerreg     = [TEACHERreg lowercaseString];    //小写
    
    userDefault = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:_phoneNumberTextfield.text forKey:@"Phone"];
    [params setObject:TEACHERLowerreg forKey:@"Pwd"];
    [params setObject:_codeTextfield.text forKey:@"Code"];
    [params setObject:[userDefault objectForKey:@"Token"] forKey:@"Token"];
    NSLog(@"params=%@",params);

    
    [MHNetworkManager postReqeustWithURL:API_SUBMIT_FORGET_PASSWORD_URL params:params successBlock:^(NSDictionary *returnData) {
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
