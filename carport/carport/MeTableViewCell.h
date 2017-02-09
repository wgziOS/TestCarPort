//
//  MeTableViewCell.h
//  carport
//
//  Created by 吴桂钊 on 2016/12/2.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kMeTableViewCell = @"MeTableViewCell";
@interface MeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end
