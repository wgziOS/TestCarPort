//
//  CarOwnerViewController.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/12.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import "CarOwnerViewController.h"
#import "MyCarPortTableViewCell.h"
#import "PublishCarPortViewController.h"
#import "NearbyModel.h"
#import "MJExtension.h"
#import "FilterHTML.h"
@interface CarOwnerViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSUserDefaults * userDefault;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray * listArray;
@end

@implementation CarOwnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的车位";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:kMyCarPortTableViewCell bundle:nil] forCellReuseIdentifier:kMyCarPortTableViewCell];
    
    [self postPakingSpaceListWithPage:0];
}

#pragma mark - 获取数据
- (void)postPakingSpaceListWithPage:(NSInteger)page
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    [params setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"CurrentPage"];
   
    userDefault = [NSUserDefaults standardUserDefaults];
    [params setObject:[userDefault valueForKey:@"Token"] forKey:@"Token"];
    NSLog(@"参数%@",params);
    __weak __typeof(self)weakSelf = self;
    
    [MHNetworkManager postReqeustWithURL:API_GET_PARKING_SPACE_LIST_URL params:params successBlock:^(NSDictionary *returnData) {
//        [self endRefresh];
        NSLog(@"获取发布数据%@",returnData);
        
        NSMutableArray * modelArr = [NSMutableArray array];
        for (NSDictionary * dict in returnData)
        {
            NearbyModel * nearbyModel = [[NearbyModel alloc]initWithInfoDic:dict];
            [modelArr addObject:nearbyModel];
        }
        weakSelf.listArray = modelArr;
        modelArr = nil;
        [self updateView];
//
        
    } failureBlock:^(NSError *error) {
        
    } showHUD:YES];
    
    
}
/**
 * 更新视图.
 */
- (void) updateView
{
    [self.tableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyCarPortTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kMyCarPortTableViewCell];
    
    NearbyModel *nearbyModel = [NearbyModel mj_objectWithKeyValues:self.listArray[indexPath.row]];
    
    
    //利用工具类转换数据
    NSString * str = [NSString stringWithFormat:@"%@-%@",[TurnDate turnDataWithString:nearbyModel.ParkingSpace.starttime],[TurnDate turnDataWithString:nearbyModel.ParkingSpace.endtime]];
    
    cell.timelabe.text = str;//
    cell.addressLabel.text = nearbyModel.ParkingSpace.user_address;
    cell.portNameLabel.text = nearbyModel.ParkingSpace.title;
    cell.priceLabel.text = nearbyModel.ParkingSpace.park_price;
    cell.describeLabel.text =  [FilterHTML filterHTML:nearbyModel.ParkingSpace.describe];
    
    
    return cell;
    
}



#pragma mark - 发布车位
- (IBAction)publishButtonClick:(id)sender {
    
    PublishCarPortViewController * PVC = [[PublishCarPortViewController alloc]init];
    [self.navigationController pushViewController:PVC animated:YES];
    
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
