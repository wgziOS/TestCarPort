//
//  NearbyTableViewCell.h
//  carport
//
//  Created by 吴桂钊 on 2016/12/8.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kNearbyTableViewCell = @"NearbyTableViewCell";
@interface NearbyTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *portNameLabel;//停车场名称
//@property (weak, nonatomic) IBOutlet UILabel *describeLabel;//车位描述
@property (weak, nonatomic) IBOutlet UILabel *timelabe;//车位时间
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;//详细地址
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;//车位价格
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;//距离

@property (weak, nonatomic) IBOutlet UIImageView *portImageView;

@end
