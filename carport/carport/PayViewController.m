//
//  PayViewController.m
//  carport
//
//  Created by 吴桂钊 on 2017/3/25.
//  Copyright © 2017年 86gg.cn. All rights reserved.
//

#import "PayViewController.h"
#import "PayVCCell.h"
@interface PayViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    int way;//支付方式
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UIView *footView;
@property (weak, nonatomic) IBOutlet UILabel *sumMoneyLabel;//总额
@property (weak, nonatomic) IBOutlet UILabel *yajinLabel;
@property (weak, nonatomic) IBOutlet UILabel *danjiaLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ZFBImg;//支付宝图
@property (weak, nonatomic) IBOutlet UIImageView *WeiXinImg;//微信图


@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    way = 1;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:kPayVCCell bundle:nil] forCellReuseIdentifier:kPayVCCell];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PayVCCell * cell = [tableView dequeueReusableCellWithIdentifier:kPayVCCell];
    
    return  cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
}
//支付宝点击
- (IBAction)ZFBBtnClick:(id)sender {
    way = 1;
    _ZFBImg.image = [UIImage imageNamed:@"选中"];
    _WeiXinImg.image = [UIImage imageNamed:@"weidianji"];
}
- (IBAction)WXBtnClick:(id)sender {
    way = 2;
    _ZFBImg.image = [UIImage imageNamed:@"weidianji"];
    _WeiXinImg.image = [UIImage imageNamed:@"选中"];
}

//确认支付
- (IBAction)payBtnClick:(id)sender {
    
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
