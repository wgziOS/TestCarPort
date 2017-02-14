//
//  PublishRentCarViewController.m
//  carport
//
//  Created by 吴桂钊 on 2017/2/13.
//  Copyright © 2017年 86gg.cn. All rights reserved.
//

#import "PublishRentCarViewController.h"
#import "PublishRentCarInfoCell.h"
@interface PublishRentCarViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
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
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
     [self.tableView registerNib:[UINib nibWithNibName:kPublishRentCarInfoCell bundle:nil] forCellReuseIdentifier:kPublishRentCarInfoCell];
    
}
#pragma mark - tableView

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PublishRentCarInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:kPublishRentCarInfoCell];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 500;
}
#pragma mark - publish
- (IBAction)publishBtnClick:(id)sender {
}
//textField 协议
-(void)fun
{
    _ownerNameTextfield.delegate = self;
    _ownerPhoneTextfield.delegate = self;
    _startTimeTextfield.delegate = self;
    _endTimeTextfield.delegate = self;
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
