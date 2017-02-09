//
//  MeIsOwnerTableViewCell.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/21.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import "MeIsOwnerTableViewCell.h"

@implementation MeIsOwnerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)changeBtnClick:(id)sender {
    if (self.changeBtnBlock) {
        self.changeBtnBlock();
    }
}
- (IBAction)delectBtnClick:(id)sender {
    if (self.delectBtnBlock) {
        self.delectBtnBlock();
    }
}

@end
