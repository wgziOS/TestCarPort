//
//  XMGTabBar.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/5.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import "XMGTabBar.h"

@interface XMGTabBar()

@end

@implementation XMGTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置tabbar的背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
//        [self setBackgroundColor:[UIColor whiteColor]];
        

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    CGFloat width = 40;
//    CGFloat height = 40;
    
//    // 设置发布按钮的frame
//    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
//    
//    // 设置其他UITabBarButton的frame
//    CGFloat buttonY = 0;
//    CGFloat buttonW = width / 5;
//    CGFloat buttonH = height;
//    NSInteger index = 0;
//    for (UIView *button in self.subviews) {
//        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) continue;
//        
//        // 计算按钮的x值
//        CGFloat buttonX = buttonW * ((index > 1)?(index + 1):index);
//        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
//        
//        // 增加索引
//        index++;
//    }
//    NSInteger index = 0;
//for (UIView *button in self.subviews) {
//    button.frame.size = CGSizeMake(width, height);
//    index++;
//}
    
}

@end
