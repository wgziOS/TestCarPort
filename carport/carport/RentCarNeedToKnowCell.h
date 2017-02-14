//
//  RentCarNeedToKnowCell.h
//  carport
//
//  Created by 吴桂钊 on 2017/2/14.
//  Copyright © 2017年 86gg.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kRentCarNeedToKnowCell = @"RentCarNeedToKnowCell";
@interface RentCarNeedToKnowCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *ownerPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *needToKnowLabel;

@end
