//
//  WGZToggleButton.h
//  carport
//
//  Created by 吴桂钊 on 2016/12/16.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGZToggleButton : UIButton
@property (nonatomic, getter = isOn) BOOL on;
@property (nonatomic, getter = isAutotoggleEnabled) BOOL autotoggleEnabled;

+ (id)buttonWithOnImage:(UIImage *)onImage
               offImage:(UIImage *)offImage
       highlightedImage:(UIImage *)highlightedImage;

- (BOOL)toggle;
@end
