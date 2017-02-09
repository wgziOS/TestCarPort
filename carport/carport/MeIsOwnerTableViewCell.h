//
//  MeIsOwnerTableViewCell.h
//  carport
//
//  Created by 吴桂钊 on 2016/12/21.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kMeIsOwnerTableViewCell = @"MeIsOwnerTableViewCell";
@interface MeIsOwnerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *plantNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *pricelabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;
@property (weak, nonatomic) IBOutlet UIButton *delectButton;
@property(nonatomic,strong) void (^changeBtnBlock)();
@property(nonatomic,strong) void (^delectBtnBlock)();
@end
