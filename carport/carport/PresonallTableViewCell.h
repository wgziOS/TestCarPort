//
//  PresonallTableViewCell.h
//  carport
//
//  Created by 吴桂钊 on 2016/12/7.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kPresonallTableViewCell = @"PresonallTableViewCell";
@interface PresonallTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end
