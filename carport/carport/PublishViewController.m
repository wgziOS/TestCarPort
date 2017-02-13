//
//  PublishViewController.m
//  carport
//
//  Created by 吴桂钊 on 2017/2/13.
//  Copyright © 2017年 86gg.cn. All rights reserved.
//

#import "PublishViewController.h"
#import "MasterOrderViewController.h"
#import "WGZTitleLabel.h"
#import "UIView+GFFrame.h"
#import "PublishCarPortViewController.h"
#import "PublishRentCarViewController.h"//
#import "MasterThirdViewController.h"
#import "MasterFourViewController.h"
#import "MasterFiveViewController.h"

@interface PublishViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@end

@implementation PublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信息发布";

    _contentScrollView.delegate = self;
    
    
    [self setupChildVc];
    
    
    [self setupTitle];
    
    
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
    
}

- (void)setupChildVc
{
    PublishCarPortViewController *social0 = [[PublishCarPortViewController alloc] init];
    social0.title = @"找车位";
    [self addChildViewController:social0];
    
    PublishRentCarViewController *social1 = [[PublishRentCarViewController alloc] init];
    social1.title = @"租车";
    [self addChildViewController:social1];
    
    MasterThirdViewController *social2 = [[MasterThirdViewController alloc] init];
    social2.title = @"货车";
    [self addChildViewController:social2];
    
    MasterFourViewController *social3 = [[MasterFourViewController alloc] init];
    social3.title = @"客车";
    [self addChildViewController:social3];
    
    MasterFiveViewController *social4 = [[MasterFiveViewController alloc] init];
    social4.title = @"打车";
    [self addChildViewController:social4];
    
    
}


- (void)setupTitle
{
    //    WGZTitleLabel * firstLabel= [WGZTitleLabel new];
    
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
        //        if (label.tag == 0) {
        //            firstLabel = label;
        //        }
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
    
    //    //控制状态
    //    self.selectTitleButton.selected = NO;
    //    titleButton.selected = YES;
    //    self.selectTitleButton = titleButton;
    
    ////    指示器
    //    [UIView animateWithDuration:0.25 animations:^{
    //
    //        self.indicatorView.gf_width = 60;
    //        self.indicatorView.gf_centerX = tap.view.gf_centerX;
    //        switch (index) {
    //            case 2:
    //            {NSLog(@"%f",self.indicatorView.gf_x);
    //                self.indicatorView.gf_centerX = tap.view.gf_centerX-40;
    //            }
    //                break;
    //            case 3:
    //            {NSLog(@"%f",self.indicatorView.gf_x);
    //                self.indicatorView.gf_centerX = tap.view.gf_centerX-70;
    //            }
    //                break;
    //            case 4:
    //            {NSLog(@"%f",self.indicatorView.gf_x);
    //                self.indicatorView.gf_centerX = tap.view.gf_centerX-70;
    //            }
    //                break;
    //            default:
    //                break;
    //        }
    //    }];
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