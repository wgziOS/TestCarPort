//
//  EditorInfoViewController.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/7.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import "EditorInfoViewController.h"
#import "EditorInfoTableViewCell.h"
#import "EditorSexTableViewCell.h"
@interface EditorInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * array;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headView;

@end

@implementation EditorInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:kEditorInfoTableViewCell bundle:nil] forCellReuseIdentifier:kEditorInfoTableViewCell];
    [self.tableView registerNib:[UINib nibWithNibName:kEditorSexTableViewCell bundle:nil] forCellReuseIdentifier:kEditorSexTableViewCell];
    array = @[@"姓名",@"联系电话",@"车牌号",@"性别",@"我的QQ",@"我的微信",@"车位地址"];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];//添加点击色
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,6)];
    view.backgroundColor = [UIColor colorWithWhite:0.871 alpha:1.000];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    EditorInfoTableViewCell * infocell = [tableView dequeueReusableCellWithIdentifier:kEditorInfoTableViewCell];
    infocell.titleLabel.text = array[indexPath.row];
    
    if (indexPath.row == 3) {
        EditorSexTableViewCell * sexcell = [tableView dequeueReusableCellWithIdentifier:kEditorSexTableViewCell];
        return sexcell;
    }
    
    return infocell;
}

- (IBAction)gobackClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveInfoClick:(id)sender {
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
