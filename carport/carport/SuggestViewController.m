//
//  SuggestViewController.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/23.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import "SuggestViewController.h"

@interface SuggestViewController ()<UITextViewDelegate>
{
    NSUserDefaults * userDefault;
}
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) UILabel *residuLabel;
@property (strong, nonatomic) UILabel * placeHolderLabel;
@end

@implementation SuggestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"建议反馈";
    
    _textView.layer.backgroundColor = [[UIColor clearColor] CGColor];
    _textView.layer.borderColor = [[UIColor colorWithRed:77.0/255.0 green:175.0/255.0 blue:252.0/255.0 alpha:1.0]CGColor];
    _textView.layer.borderWidth = 1.0;
    [_textView.layer setMasksToBounds:YES];
    
    _textView.delegate = self;
    //再创建个可以放置默认字的lable
    self.placeHolderLabel = [[UILabel alloc]initWithFrame:CGRectMake(3,3,SCREEN_WIDTH-50,20)];
    self.placeHolderLabel.numberOfLines = 0;
    self.placeHolderLabel.text = @"请输入你的建议，最多200字";
    self.placeHolderLabel.textColor = [UIColor grayColor];
    self.placeHolderLabel.font = [UIFont systemFontOfSize:11.f];
    self.placeHolderLabel.backgroundColor =[UIColor clearColor];
    
    //多余的一步不需要的可以不写  计算textview的输入字数
    self.residuLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-120, 120, 80, 20)];
    self.residuLabel.backgroundColor = [UIColor clearColor];
    self.residuLabel.font = [UIFont systemFontOfSize:11.f];
    self.residuLabel.text =[NSString stringWithFormat:@"200/200个字"];
    self.residuLabel.textColor = [UIColor grayColor];
    [self.textView addSubview:_placeHolderLabel];
    [self.textView addSubview:_residuLabel];
    
}

//  提交按钮
- (IBAction)commitButtonClick:(id)sender
{
    [self hideKeyboard];
    
    NSString *contentStr = _textView.text;
    NSLog(@"内容=%@",contentStr);
    if ([contentStr length] == 0) {
        [Calculate_frame showWithText:@"请填写反馈内容"];
        return;
    }
    [self postSubmitProposedWithContent:contentStr];
}
#pragma mark - 下架车位数据请求
- (void)postSubmitProposedWithContent:(NSString *)content
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:content forKey:@"RecommendedContent"];
    __weak __typeof(self)weakSelf = self;
    userDefault = [NSUserDefaults standardUserDefaults];
    [params setObject:[userDefault valueForKey:@"Token"] forKey:@"Token"];
    NSLog(@"%@",params);
    [MHNetworkManager postReqeustWithURL:API_SUBMIT_PROPOSED_FEEDBACK_URL params:params successBlock:^(NSDictionary *returnData) {
        
        NSLog(@"提交反馈返回数据%@",returnData);
        NSLog(@"%@",returnData[@"message"]);
        if ([[returnData objectForKey:@"states"] integerValue] == 1) {
            
            NSString * mess = [[returnData objectForKey:@"message"]description];
            [Calculate_frame showWithText:mess];
            
        }else{
            NSString * error = [[returnData objectForKey:@"message"]description];
            [Calculate_frame showWithText:error];
        }
        NSString * str = [NSString stringWithFormat:@"%@",[returnData objectForKey:@"states"]];
        if ([str intValue] == -1) {
            //先登录
            [weakSelf goLogin];
        }
        
    } failureBlock:^(NSError *error) {
        NSString * err = [NSString stringWithFormat:@"%@",error];
        [Calculate_frame showWithText:err];
    } showHUD:YES];
}
-(void)goLogin
{
    LGViewController *LGVC = [[LGViewController alloc]init];
    [self.navigationController pushViewController:LGVC animated:YES];
}
- (void)hideKeyboard
{
    [self.textView resignFirstResponder];
    
}
#pragma mark - 通过textView的代理方法实现textfield的点击置空默认自负效果
-(void)textViewDidChange:(UITextView*)textView
{
    if([textView.text length] == 0){
        self.placeHolderLabel.text = @"请输入你的建议，最多200字";
    }else{
        self.placeHolderLabel.text = @"";//这里给空
    }
    //计算剩余字数   不需要的也可不写
    NSString *nsTextCotent = textView.text;
    int existTextNum = (int)[nsTextCotent length];
    int remainTextNum = 200 - existTextNum;
    self.residuLabel.text = [NSString stringWithFormat:@"%d/200个字",remainTextNum];
}
#pragma mark - 设置超出最大字数（200字）即不可输入 也是textview的代理方法
-(BOOL)textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range
replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"])
    {  //这里"n"对应的是键盘的 return 回收键盘之用
        [textView resignFirstResponder];
        return YES;
    }
    if (range.location >= 200)
    {
        return NO;
    }else
    {
        return YES;
    }
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
