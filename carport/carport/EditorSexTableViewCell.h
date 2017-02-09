//
//  EditorSexTableViewCell.h
//  carport
//
//  Created by 吴桂钊 on 2016/12/7.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kEditorSexTableViewCell = @"EditorSexTableViewCell";
@interface EditorSexTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *manButton;
@property (weak, nonatomic) IBOutlet UIButton *womanButton;

@end
