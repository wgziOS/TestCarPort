//
//  ClientOrderTableViewCell.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/27.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import "ClientOrderTableViewCell.h"

@implementation ClientOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)payBtnClick:(id)sender {
    if (self.payButton) {
        self.payBtnBlock();
    }
}
- (IBAction)complaintBtnClick:(id)sender {
    if (self.complainBtnBlock) {
        self.complainBtnBlock();
    }
}
- (IBAction)chargeBackBtnClick:(id)sender {
    if (self.chargeBackButton) {
        self.chargeBackBtnBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
