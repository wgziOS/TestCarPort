//
//  LGViewController.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/5.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import "LGViewController.h"
#import "ForgetPassWordViewController.h"

@interface LGViewController ()<UITextFieldDelegate>
{
    NSUserDefaults * userDefault;
    int clickCount;
}
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UIButton *rememberButton;


@end

@implementation LGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(restoredAndHiedBoard)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
    
    //获取token
    [self getToken];
    clickCount = 1;
    [self.rememberButton setBackgroundImage:[UIImage imageNamed:@"denglu_92"] forState:UIControlStateNormal];
    userDefault = [NSUserDefaults standardUserDefaults];
    _phoneNumber.text = [userDefault objectForKey:@"phoneNumber"];

    
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
//        NSLog(@"dic -------------------%@",[dic valueForKey:@"Token"]);
        userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:[dic valueForKey:@"Token"] forKey:@"Token"];
        [userDefault synchronize];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error %@",error.localizedFailureReason);

    }];
    
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
    [self.phoneNumber resignFirstResponder];
    [self.passWord resignFirstResponder];
}
#pragma mark - 记住信息
- (IBAction)rememberButtonClick:(id)sender {
    if (clickCount == 1) {
        [self.rememberButton setBackgroundImage:[UIImage imageNamed:@"denglu_91"] forState:UIControlStateNormal];
        //记住信息
        userDefault = [NSUserDefaults standardUserDefaults];
//        _phoneNumber.text = [userDefault objectForKey:@"phoneNumber"];
        [userDefault setObject:_phoneNumber.text forKey:@"phoneNumber"];
        [userDefault synchronize];
        NSLog(@"6666%@",[userDefault objectForKey:@"phoneNumber"]);
        clickCount =2;
        return;
    }
    if (clickCount ==2) {
        [self.rememberButton setBackgroundImage:[UIImage imageNamed:@"denglu_92"] forState:UIControlStateNormal];
        userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault removeObjectForKey:@"phoneNumber"];
        [userDefault synchronize];
        clickCount = 1;
        return;
    }
}

#pragma mark - 获取数据
- (void)postLoginMobile:(NSString *)mobile andUserPassWord:(NSString *)password
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:mobile forKey:@"Phone"];
    [params setObject:password forKey:@"Password"];
    userDefault = [NSUserDefaults standardUserDefaults];
    [params setObject:[userDefault valueForKey:@"Token"] forKey:@"Token"];
    NSLog(@"%@",params);
    [MHNetworkManager postReqeustWithURL:API_LOGIN_URL params:params successBlock:^(NSDictionary *returnData) {
        
        NSLog(@"登录获取数据%@",returnData);
        NSLog(@"登录%@",returnData[@"message"]);
        if ([[returnData objectForKey:@"states"] integerValue] == 1) {
  
            /*记住登陆的账号。下次进入这个页面时，直接读取账号*/
            userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:_phoneNumber.text forKey:@"phoneNumber"];

            [userDefault setObject:@"1" forKey:@"logState"];//1表示已登录
            [userDefault synchronize];
            NSString * mess = [[returnData objectForKey:@"message"]description];
            [Calculate_frame showWithText:mess];
            //登入成功，跳转到首页
            [self pushToMain];
        }else{
            NSString * error = [[returnData objectForKey:@"message"]description];
            [Calculate_frame showWithText:error];
        }
    } failureBlock:^(NSError *error) {
        NSString * err = [NSString stringWithFormat:@"%@",error];
        [Calculate_frame showWithText:err];
    } showHUD:YES];
}
-(void)pushToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 登录
- (IBAction)loginClick:(id)sender {
    
    [self restoredAndHiedBoard];
    if (_phoneNumber.text.length != 11){
        [Calculate_frame showWithText:@"请输入11位手机号码"];
        return;
    }
    if( _passWord.text.length < 5 || _passWord.text.length > 16 ){
        [Calculate_frame showWithText:@"密码为6-16位的数字或字母"];
        return;
    }

    NSString * TEACHER = [Calculate_frame md5:_passWord.text];
    NSString * TEACHERLower = [TEACHER lowercaseString];    //小写
    [self postLoginMobile:_phoneNumber.text andUserPassWord:TEACHERLower];
}

#pragma mark - 注册
- (IBAction)joinClick:(id)sender {
    RegisterViewController * RVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:RVC animated:YES];
}
#pragma mark - 忘记密码
- (IBAction)forgetClick:(id)sender {
    
    ForgetPassWordViewController * forgetVC = [[ForgetPassWordViewController alloc]init];
    [self.navigationController pushViewController:forgetVC animated:YES];
    
}


#pragma mark - qq登录
- (IBAction)QQLogin:(id)sender {
    
}
#pragma mark 微信登录
- (IBAction)WeChatLogin:(id)sender {
    
}
#pragma mark 微博登录
- (IBAction)weiboLogin:(id)sender {
    
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
