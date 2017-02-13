//
//  RentCarDetailViewController.m
//  carport
//
//  Created by 吴桂钊 on 2017/2/13.
//  Copyright © 2017年 86gg.cn. All rights reserved.
//

#import "RentCarDetailViewController.h"
#import <SDCycleScrollView.h>
@interface RentCarDetailViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *pledgeMoneyLabel;//押金
@property (nonatomic, strong)SDCycleScrollView * scrollView;

@end

@implementation RentCarDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"车辆详情";
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 233) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
//    _scrollView.imageURLStringsGroup = _slideImgArray;
    _scrollView.imageURLStringsGroup = @[@"http://parking.86gg.cn/upload/2016121311585013444131.jpg",@"http://parking.86gg.cn/upload/2016121311564957280977.jpg"];
    _scrollView.pageControlDotSize = CGSizeMake(8.0, 8.0);
    _scrollView.autoScrollTimeInterval = 2.0;
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [_headView addSubview:_scrollView];
    

}

#pragma mark - tableView 代理
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
    switch (indexPath.row) {
        case 0:
        {
        
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - 立即租用按钮
- (IBAction)rentBtnClick:(id)sender {
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
