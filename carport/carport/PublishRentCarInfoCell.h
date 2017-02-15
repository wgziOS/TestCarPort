//
//  PublishRentCarInfoCell.h
//  carport
//
//  Created by 吴桂钊 on 2017/2/14.
//  Copyright © 2017年 86gg.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kPublishRentCarInfoCell = @"PublishRentCarInfoCell";
@interface PublishRentCarInfoCell : UITableViewCell
{
    WGZToggleButton * boxButton;
    WGZToggleButton * displacementButton;
    WGZToggleButton * configurationButton;
}
@property (weak, nonatomic) IBOutlet UITextField *carSizeTextfield;
@property (weak, nonatomic) IBOutlet UITextField *plateNumTextfield;
@property (weak, nonatomic) IBOutlet UITextField *seatCountTextfield;
@property (weak, nonatomic) IBOutlet UITextField *buyCarYearTextfield;
@property (weak, nonatomic) IBOutlet UITextField *kilometersTraveledTextfield;

@property(nonatomic,strong) void (^carSizeBlock)(NSString *);
@property(nonatomic,strong) void (^plateNumBlock)(NSString *);
@property(nonatomic,strong) void (^seatCountBlock)(NSString *);
@property(nonatomic,strong) void (^buyCarYearBlock)(NSString *);
@property(nonatomic,strong) void (^kmBlock)(NSString *);

@property (weak, nonatomic) IBOutlet UILabel *boxLabel;
@property (weak, nonatomic) IBOutlet UILabel *displacementLabel;
@property (weak, nonatomic) IBOutlet UILabel *configurationLabel;

//
@property (nonatomic, strong)NSString * boxValue;
@property(nonatomic,strong) void (^boxBtnBlock)();
@property (nonatomic, strong)NSString * displacementValue;
@property(nonatomic,strong) void (^displacementBtnBlock)();
@property (nonatomic, strong)NSString * configurationValue;
@property(nonatomic,strong) void (^configurationBtnBlock)();

@end
