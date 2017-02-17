//
//  RentResultView.m
//  carport
//
//  Created by 吴桂钊 on 2017/2/17.
//  Copyright © 2017年 86gg.cn. All rights reserved.
//

#import "RentResultView.h"
static CGFloat kTransitionDuration = 0.3;

@implementation RentResultView


-(id)init {
    
    self = [super init];
    if (self) {
    }
    
    return self;
}

-(id)initViewTitleImgString:(NSString *)titleImgString TitleString:(NSString *)titleString SubTitleString:(NSString *)subTitleString BtnImgString:(NSString *)btnImgString
{
    
    self = [super init];
    if (self) {
        
        UIImageView * titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(MyEditorWidth / 2 - 40, 40, 80, 80)];
        titleImageView.image = [UIImage imageNamed:titleImgString];
        [self addSubview:titleImageView];
        //clxq-icon clxq-cxzc
        
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(MyEditorWidth / 2 - 50, 135, 100, 25)];
        label1.text = titleString;
        label1.font = [UIFont systemFontOfSize:18.0f];
        label1.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label1];
        
        UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(MyEditorWidth / 2 - 50, 165, 100, 25)];
        label2.text = subTitleString;
        label2.textColor = [UIColor redColor];
        label2.font = [UIFont systemFontOfSize:13.0f];
        label2.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label2];
        
//        clxq-cxzc
        UIButton * go_onbuuton = [UIButton buttonWithType:UIButtonTypeCustom];
        [go_onbuuton setFrame:CGRectMake(MyEditorWidth / 2 - 65, MyEditorHeight - 60, 130, 45)];
        [go_onbuuton setImage:[UIImage imageNamed:btnImgString] forState:UIControlStateNormal];
        [go_onbuuton addTarget:self action:@selector(goonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:go_onbuuton];
        
    }
    
    return self;
}

//#pragma mark - 稍后继续
//-(void)lateronAction:(UIButton *)sender
//{
//    //代码筷回掉
////    _leaveAlertView = NO;
//    [self dismissAlert];
//    if (self.lateronBlock) {
//        self.lateronBlock();
//    }
//    
//}

#pragma mark - 继续按钮
-(void)goonAction:(UIButton *)sender
{
    //代码筷回掉
//    _leaveAlertView = NO;
    [self dismissAlert];
    if (self.goonBlock) {
        
        
        
        self.goonBlock();
    }
    
}

/*
 * 展示自定义AlertView
 */
- (void)show
{
    UIViewController *topVC = [self appRootViewController];
    self.frame = CGRectMake(SCREENWITH/2-MyEditorWidth/2, SCREENHEIGHT/2-MyEditorHeight*0.5, MyEditorWidth, MyEditorHeight);
    self.backgroundColor = BACKGROUNDCOLOR;
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    [topVC.view addSubview:self];
}

/*
 * 视图的最顶层添加一个视图
 */
- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

/*
 * 在rootViewController顶层添加视图
 */
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    UIViewController *topVC = [self appRootViewController];
    
    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame:topVC.view.bounds];
        self.backImageView.backgroundColor = [UIColor blackColor];
        self.backImageView.alpha = 0.6f;
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    [topVC.view addSubview:self.backImageView];
    
    // 一系列动画效果, 先放大0.1, 在缩小0.1,随后还原原始大小,达到反弹效果
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.05, 0.05);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounceAnimationStopped)];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.3, 1.3);
    [UIView commitAnimations];
    
    [super willMoveToSuperview:newSuperview];
}

#pragma mark - 缩放
- (void)bounceAnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce2AnimationStopped)];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.7, 0.7);
    [UIView commitAnimations];
}

#pragma mark - 缩放
- (void)bounce2AnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    [UIView commitAnimations];
}


- (void)dismissAlert
{
    [self remove];
}


- (void)remove
{
    [self.backImageView removeFromSuperview];

    [self removeFromSuperview];

}


@end
