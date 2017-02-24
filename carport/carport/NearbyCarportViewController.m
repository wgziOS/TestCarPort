//
//  NearbyCarportViewController.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/7.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import "NearbyCarportViewController.h"
#import "LeftMenuController.h"
#import "NearbyTableViewCell.h"
#import "MJRefresh.h"
#import "NearbyModel.h"
#import "ListImgModel.h"
#import "MJExtension.h"
#import "CarPortDetailViewController.h"
#import "LGViewController.h"
@interface NearbyCarportViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSUserDefaults * userDefault;
    int count;
    UITextField * searchField;
    UIView * bgView;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray * nearbyArray;
@property (assign, nonatomic) NSInteger page; //!< 数据页数.表示下次请求第几页的数据.
@property (strong ,nonatomic) NSString * userLongitude;
@property (strong ,nonatomic) NSString * userLatitude;
@end

@implementation NearbyCarportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    userDefault = [NSUserDefaults standardUserDefaults];
    self.userLongitude = [userDefault objectForKey:@"userLongitude"];
    self.userLatitude = [userDefault objectForKey:@"userLatitude"];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:kNearbyTableViewCell bundle:nil] forCellReuseIdentifier:kNearbyTableViewCell];
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page--;
        if (_page == 0 || _page ==-1) {
            _page = 0;
            [Calculate_frame showWithText:@"已经是第一页"];
            [self endRefresh];
            [self updateData];
        }else{
            [self updateData];
        }
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self updateData];
    }];
    
    [self getToken];
    
    
    
    
    count = 1;//初始化count
    
    //添加搜索栏
    [self addSearchView];
    bgView.hidden = YES;
    
  
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
        
        if (_userLatitude != nil) {
            
            [self postNearPakingWithLongitude:self.userLongitude andLatitude:self.userLatitude andPage:0 andSearchkey:@""];
        }else{//未定位
            [self postNearPakingWithLongitude:@"" andLatitude:@"" andPage:0 andSearchkey:@""];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error %@",error.localizedFailureReason);
    }];
}

#pragma mark - 搜索按钮  参数Searchkey
-(void)searchButtonClick:(id)sender
{
    [self hideKeyboard];
    [self postNearPakingWithLongitude:self.userLongitude andLatitude:self.userLatitude andPage:_page andSearchkey:searchField.text];
    
}
#pragma mark - 右按钮
-(void)rightButtonClick:(id)sender
{
    if (count == 1) {
        count = 2;
        bgView.hidden = NO;
        return;
    }
    if (count == 2) {
        count = 1;
        //隐藏
        bgView.hidden = YES;
        [self hideKeyboard];
        return;
    }
}
#pragma mark - 获取数据
- (void)postNearPakingWithLongitude:(NSString *)longitude andLatitude:(NSString *)latitude andPage:(NSInteger)page andSearchkey:(NSString *)searchkey
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    [params setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"CurrentPage"];
    [params setObject:longitude forKey:@"X"];
    [params setObject:latitude forKey:@"Y"];
    [params setObject:searchkey forKey:@"Searchkey"];
    userDefault = [NSUserDefaults standardUserDefaults];
    [params setObject:[userDefault valueForKey:@"Token"] forKey:@"Token"];
    
    __weak __typeof(self)weakSelf = self;
    
    [MHNetworkManager postReqeustWithURL:API_GETNEARBYNEARPAKING_URL params:params successBlock:^(NSDictionary *returnData) {

        if([returnData isKindOfClass:[NSArray class]])
        {

            NSMutableArray * modelArr = [NSMutableArray array];
            for (NSDictionary * dict in returnData)
            {
                NearbyModel * nearbyModel = [[NearbyModel alloc]initWithInfoDic:dict];
                [modelArr addObject:nearbyModel];
            }
            weakSelf.nearbyArray = modelArr;
            modelArr = nil;
           
            if (weakSelf.nearbyArray.count == 0) {
                [Calculate_frame showWithText:[NSString stringWithFormat:@"暂无数据"]];
            }
            [self updateView];
          
        }else if([returnData isKindOfClass:[NSDictionary class]])
        {
  
            [Calculate_frame showWithText:[returnData objectForKey:@"message"]];
            NSString * str = [NSString stringWithFormat:@"%@",[returnData objectForKey:@"states"]];

            switch ([str intValue]) {
                case 0:
                    //过期
                    [weakSelf getTokenAgain];
                    break;
                case -1:
                     //先登录
                     [weakSelf goLogin];
                    break;
                    
                default:
                    break;
            }
        }
         [self endRefresh];
    
    } failureBlock:^(NSError *error) {
        [Calculate_frame showWithText:@"网络请求失败"];
    } showHUD:YES];
    
}

-(void)getTokenAgain
{
    //串行队列
    dispatch_sync(dispatch_queue_create("zz", DISPATCH_QUEUE_SERIAL), ^{
        // 1
//        [self getToken];
        [GetToken getToken];
        // 2 重新获取后 请求
        [self postNearPakingWithLongitude:self.userLongitude andLatitude:self.userLatitude andPage:0 andSearchkey:@""];
    });
    
}
-(void)goLogin
{
    LGViewController *LGVC = [[LGViewController alloc]init];
    [self.navigationController pushViewController:LGVC animated:YES];
}

- (void)updateData
{
    [self postNearPakingWithLongitude:self.userLongitude andLatitude:self.userLatitude andPage:_page andSearchkey:@""];
}
/**
 * 更新视图.
 */
- (void) updateView
{
    [self.tableView reloadData];
}
/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
#pragma mark - tableView代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];//添加点击色
    
    NearbyModel *nearbyModel = [NearbyModel mj_objectWithKeyValues:self.nearbyArray[indexPath.row]];
    
    CarPortDetailViewController * CDVC = [[CarPortDetailViewController alloc]init];
    CDVC.nearbyModel = nearbyModel;
    [self.navigationController pushViewController:CDVC animated:YES];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.nearbyArray.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NearbyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kNearbyTableViewCell];

    NearbyModel *nearbyModel = [NearbyModel mj_objectWithKeyValues:self.nearbyArray[indexPath.row]];
    
    //利用工具类转换数据
    NSString * str = [NSString stringWithFormat:@"%@-%@",[TurnDate turnDataWithString:nearbyModel.ParkingSpace.starttime],[TurnDate turnDataWithString:nearbyModel.ParkingSpace.endtime]];
    
    cell.timelabe.text = str;//
    cell.addressLabel.text = nearbyModel.ParkingSpace.user_address;
    cell.portNameLabel.text = nearbyModel.ParkingSpace.title;
    cell.priceLabel.text = nearbyModel.ParkingSpace.park_price;
//    cell.distanceLabel.text  //距离
    
    NSString * imgUrl =[NSString stringWithFormat:@"http://parking.86gg.cn%@",nearbyModel.ParkingSpace.imgurl];
//     NSString * imgUrl =[NSString stringWithFormat:@"http://192.168.123.73:8090%@",nearbyModel.ParkingSpace.navigation_imgurl];
    NSURL * url = [NSURL URLWithString:imgUrl];
    NSLog(@"%@",url);
    [cell.portImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"picture-wait@3x"]];
       
    return cell;
    
}

#pragma mark - 过滤html标签
-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    NSString * regEx = @"<([^>]*)>";
    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
    
}
#pragma mark - 搜索栏
-(void)addSearchView
{
    bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    bgView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:.5f];
    [self.view addSubview:bgView];
    
    UIImageView * barView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 7, SCREEN_WIDTH-20, 35)];
    barView.image = [UIImage imageNamed:@"czcw-ssk"];
    [bgView addSubview:barView];
    
    searchField = [[UITextField alloc]initWithFrame:CGRectMake(20, 8, SCREEN_WIDTH-100, 35)];
    searchField.placeholder = @"请输入地名或者停车场名称";  // 提示文本

    [searchField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    searchField.borderStyle = UITextBorderStyleNone;//
    searchField.keyboardType = UIKeyboardTypeDefault;
    [bgView addSubview:searchField];
    
    UIButton * searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton setImage:[UIImage imageNamed:@"czcw-ss-icon"] forState:UIControlStateNormal];
    [searchButton setImage:[UIImage imageNamed:@"czcw-ss-dj-icon"] forState:UIControlStateHighlighted];
    searchButton.frame = CGRectMake(SCREEN_WIDTH-100, 7, 90, 35);
    [searchButton addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:searchButton];
    
}
#pragma mark 隐藏软键盘
- (void)hideKeyboard
{
    [searchField resignFirstResponder];
}
#pragma mark -
-(void)viewWillAppear:(BOOL)animated
{
    [self beginAppearanceTransition: YES animated: animated];
    
    //右按钮
    UIView * rightButtonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 25)];
    UIButton * rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 25)];
    
    [rightButton setImage:[UIImage imageNamed:@"czcw--search-icon@3x"] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightButtonView addSubview:rightButton];
    UIBarButtonItem *rightCunstomButtonView = [[UIBarButtonItem alloc]initWithCustomView:rightButtonView];
    self.navigationItem.rightBarButtonItem = rightCunstomButtonView;
    
    userDefault = [NSUserDefaults standardUserDefaults];
    self.userLongitude = [userDefault objectForKey:@"userLongitude"];
    self.userLatitude = [userDefault objectForKey:@"userLatitude"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
