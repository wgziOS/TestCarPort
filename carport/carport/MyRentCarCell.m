//
//  MyRentCarCell.m
//  carport
//
//  Created by 吴桂钊 on 2017/2/23.
//  Copyright © 2017年 86gg.cn. All rights reserved.
//

#import "MyRentCarCell.h"

@implementation MyRentCarCell

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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
