//
//  ClientOrderMainViewController.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/27.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import "ClientOrderMainViewController.h"
#import "WGZTitleLabel.h"
#import "ClientOrderViewController.h"
#import "ClientOrderSecondViewController.h"
#import "ClientOrderThirdViewController.h"
#import "ClientOrderFourViewController.h"
#import "ClientOrderFiveViewController.h"
@interface ClientOrderMainViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
/*标题按钮地下的指示器*/
@property (weak ,nonatomic) UIView *indicatorView ;
@end

@implementation ClientOrderMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"客户订单";
    
//    _titleScrollView.delegate = self;
    _contentScrollView.delegate = self;
    
    [self setupChildVc];
    
    [self setupTitle];
    
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
    
    //    底部指示器
    UIView *indicatorView = [[UIView alloc]init];
    self.indicatorView = indicatorView;
    indicatorView.backgroundColor = [UIColor colorWithRed:42.0/255.0 green:173.0/255.0 blue:234.0/255.0 alpha:1.0f];
    
    indicatorView.gf_height = 2;
    indicatorView.gf_y = 33;
    indicatorView.gf_width = SCREEN_WIDTH/5;
    indicatorView.gf_x = 0;
    [self.view addSubview:indicatorView];
}
- (void)setupChildVc
{
    ClientOrderViewController *social0 = [[ClientOrderViewController alloc] init];
    social0.title = @"找车位";
    [self addChildViewController:social0];
    
    ClientOrderSecondViewController *social1 = [[ClientOrderSecondViewController alloc] init];
    social1.title = @"租车";
    [self addChildViewController:social1];
    
    ClientOrderThirdViewController *social2 = [[ClientOrderThirdViewController alloc] init];
    social2.title = @"货车";
    [self addChildViewController:social2];
    
    ClientOrderFourViewController *social3 = [[ClientOrderFourViewController alloc] init];
    social3.title = @"客车";
    [self addChildViewController:social3];
    
    ClientOrderFiveViewController *social4 = [[ClientOrderFiveViewController alloc] init];
    social4.title = @"打车";
    [self addChildViewController:social4];
    
    
}

- (void)setupTitle
{

    CGFloat labelW = SCREEN_WIDTH/5;
    CGFloat labelY = 0;
    CGFloat labelH = self.titleScrollView.frame.size.height;
    

    for (NSInteger i = 0; i<5; i++) {
        WGZTitleLabel *label = [[WGZTitleLabel alloc] init];
        label.text = [self.childViewControllers[i] title];
        CGFloat labelX = i * labelW;
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
        label.tag = i;
        [self.titleScrollView addSubview:label];
        
        if (i == 0) {
            label.scale = 1.0;
        }
    }
    
    self.titleScrollView.contentSize = CGSizeMake(5 * labelW, 0);
    self.contentScrollView.contentSize = CGSizeMake(5 * [UIScreen mainScreen].bounds.size.width, 0);
}


- (void)labelClick:(UITapGestureRecognizer *)tap
{
 
    NSInteger index = tap.view.tag;
    
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = index * self.contentScrollView.frame.size.width;
    [self.contentScrollView setContentOffset:offset animated:YES];
    
    WGZTitleLabel *label = self.titleScrollView.subviews[index];
    [UIView animateWithDuration:0.25 animations:^{
        
        self.indicatorView.gf_centerX = label.center.x;
    }];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    CGFloat width = scrollView.frame.size.width;
    CGFloat height = scrollView.frame.size.height;
    CGFloat offsetX = scrollView.contentOffset.x;
    
    NSInteger index = offsetX / width;
    
    WGZTitleLabel *label = self.titleScrollView.subviews[index];
    CGPoint titleOffset = self.titleScrollView.contentOffset;
    titleOffset.x = label.center.x - width * 0.5;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.indicatorView.gf_centerX = label.center.x;
    }];
    
    if (titleOffset.x < 0) titleOffset.x = 0;

    CGFloat maxTitleOffsetX = self.titleScrollView.contentSize.width - width;
    if (titleOffset.x > maxTitleOffsetX) titleOffset.x = maxTitleOffsetX;
    
    [self.titleScrollView setContentOffset:titleOffset animated:YES];
    

    for (WGZTitleLabel *otherLabel in self.titleScrollView.subviews) {
        if (otherLabel != label) otherLabel.scale = 0.0;
    }
    
    UIViewController *willShowVc = self.childViewControllers[index];
    

    if ([willShowVc isViewLoaded]) return;
    
    willShowVc.view.frame = CGRectMake(offsetX, 0, width, height);
    [scrollView addSubview:willShowVc.view];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scale = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (scale < 0 || scale > self.titleScrollView.subviews.count - 1) return;
    
    NSInteger leftIndex = scale;
    WGZTitleLabel *leftLabel = self.titleScrollView.subviews[leftIndex];
    
    NSInteger rightIndex = leftIndex + 1;
    WGZTitleLabel *rightLabel = (rightIndex == self.titleScrollView.subviews.count) ? nil : self.titleScrollView.subviews[rightIndex];
    
    CGFloat rightScale = scale - leftIndex;
    
    CGFloat leftScale = 1 - rightScale;
    

    leftLabel.scale = leftScale;
    rightLabel.scale = rightScale;
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
