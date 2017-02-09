//
//  WGZaddCatPortImgView.h
//  carport
//
//  Created by 吴桂钊 on 2016/12/15.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGZaddCatPortImgView : UIButton
/**
 *  存储所有的照片(UIImage)
 */
@property (nonatomic, strong) NSString *imageStr;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *bottonImage;
- (id)initWithFrame:(CGRect)frame andImageStr:(NSString *)imageStr;
@end
