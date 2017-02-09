//
//  MasterOrderTableViewCell.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/22.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import "MasterOrderTableViewCell.h"

@implementation MasterOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    _headBottonView.layer.cornerRadius = 20;//设置圆形
//    _headBottonView.layer.masksToBounds = YES;
//    _headImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//    _headImgView.layer.cornerRadius = 20;//设置圆形
//    _headImgView.layer.masksToBounds = YES;
//    _headImgView.image = [UIImage imageNamed:@"picture"];
//    [_headBottonView addSubview:_headImgView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)cBtnClick:(id)sender {
    if (self.complaintButton) {
        self.complainBtnBlock();
    }
}

- (IBAction)sureBtnClcik:(id)sender {
    if (self.sureButton) {
        self.sureBtnBlock();
    }
}


@end
