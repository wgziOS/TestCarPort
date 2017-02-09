//
//  SubmitPassWordViewController.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/14.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import "SubmitPassWordViewController.h"

@interface SubmitPassWordViewController ()
{
    NSUserDefaults * userDefault;
}
@property (weak, nonatomic) IBOutlet UITextField *oldPassWordTextfield;

@property (weak, nonatomic) IBOutlet UITextField *passWordTextfield;

@property (weak, nonatomic) IBOutlet UITextField *againNewTextField;


@end

@implementation SubmitPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"修改密码";
}

- (IBAction)goButtonCilck:(id)sender {
    [self hideKeyboard];
    
    NSString *password = _oldPassWordTextfield.text;
    if ([password length] == 0) {
        [Calculate_frame showWithText:@"请输入登录密码"];
        return;
    }
    
    if( _passWordTextfield.text.length < 6 || _passWordTextfield.text.length > 16 ){
        [Calculate_frame showWithText:@"密码为6-16位的数字或字母"];
        return;
    }
    
    if (![_passWordTextfield.text isEqualToString:_againNewTextField.text])
    {
        [Calculate_frame showWithText:@"两次输入的密码不一致"];
        return;
    }
    
    
    //修改密码接口请求
    [self postRect];
}
#pragma mark - 修改密码请求
- (void)postRect{
    [Calculate_frame showWithHUD];
    NSString * Rreg          = [Calculate_frame md5:_oldPassWordTextfield.text];
    NSString * Lowerreg     = [Rreg lowercaseString];
    
    NSString * TEACHERreg          = [Calculate_frame md5:_passWordTextfield.text];
    NSString * TEACHERLowerreg     = [TEACHERreg lowercaseString];    //小写
    
    userDefault = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:TEACHERLowerreg forKey:@"NewPwd"];
    [params setObject:Lowerreg forKey:@"OldPwd"];
    [params setObject:[userDefault objectForKey:@"Token"] forKey:@"Token"];
    NSLog(@"params=%@",params);
    
    
    [MHNetworkManager postReqeustWithURL:API_SUBMIT_USERPWD_URL params:params successBlock:^(NSDictionary *returnData) {
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


- (void)hideKeyboard
{
    [self.oldPassWordTextfield resignFirstResponder];
    [self.passWordTextfield resignFirstResponder];
    [self.againNewTextField resignFirstResponder];
    
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
