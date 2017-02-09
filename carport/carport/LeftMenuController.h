//
//  LeftMenuController.h
//  YQSlideMenuControllerDemo
//
//  Created by Wang on 15/5/26.
//  Copyright (c) 2015年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftMenuController : UITableViewController
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView * logoImage;

@property (nonatomic, strong) UIButton * moneyButton;
@property (nonatomic, strong) UILabel * nikeNameLabel;
@end
