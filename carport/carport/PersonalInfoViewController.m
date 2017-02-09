//
//  PersonalInfoViewController.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/7.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import "PersonalInfoViewController.h"
#import "PresonallTableViewCell.h"
#import "EditorInfoViewController.h"
@interface PersonalInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * array;
}
@property (weak, nonatomic) IBOutlet UIView *headVIew;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    array = @[@"昵称",@"性别",@"联系电话",@"车牌号",@"我的QQ",@"我的微信",@"车位地址"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self.tableView registerNib:[UINib nibWithNibName:kPresonallTableViewCell bundle:nil] forCellReuseIdentifier:kPresonallTableViewCell];
    
    [self headViewSet];
    
}

-(void)headViewSet
{
    
    UIImageView * backlogoimageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 70, 70)];
    backlogoimageView.userInteractionEnabled = YES;
    backlogoimageView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6];
    backlogoimageView.layer.cornerRadius = 35;//设置圆形
    backlogoimageView.layer.masksToBounds = YES;
    [self.headVIew addSubview:backlogoimageView];
    //用户头像
    self.logoImage = [[UIImageView alloc]initWithFrame:CGRectMake(3.5, 3.5, 62, 62)];
    self.logoImage.userInteractionEnabled = YES;
    self.logoImage.layer.cornerRadius = 31.0;//设置圆形
    self.logoImage.layer.masksToBounds = YES;
    self.logoImage.image = [UIImage imageNamed:@"touxiang"];//写死
    [backlogoimageView addSubview:self.logoImage];
    
    UITapGestureRecognizer * logotap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(logoTap)];
    [self.headVIew addGestureRecognizer:logotap];

}
#pragma mark - 头像点击
-(void)logoTap
{
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];//添加点击色
    
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,6)];
    view.backgroundColor = [UIColor colorWithWhite:0.871 alpha:1.000];
    
    return view;
}

#pragma mark - tableView 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PresonallTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kPresonallTableViewCell];
  
    cell.titleLabel.text = array[indexPath.row];
    
    return cell;
}


#pragma mark - 返回
- (IBAction)goBackClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 编辑按钮
- (IBAction)editorButtonClick:(id)sender {
    EditorInfoViewController * EVC = [[EditorInfoViewController alloc]init];
    [self presentViewController:EVC animated:YES completion:nil];
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
