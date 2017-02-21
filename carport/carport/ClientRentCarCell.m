//
//  ClientRentCarCell.m
//  carport
//
//  Created by 吴桂钊 on 2017/2/21.
//  Copyright © 2017年 86gg.cn. All rights reserved.
//

#import "ClientRentCarCell.h"

@implementation ClientRentCarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)firstBtnClick:(id)sender {
    if (self.firstButton) {
        self.firstBtnBlock();
    }
}
- (IBAction)secondBtnClick:(id)sender {
    if (self.secondButton) {
        self.secondBtnBlock();
    }
}
- (IBAction)thirdBtnClick:(id)sender {
    if (self.thirdButton) {
        self.thirdBtnBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
