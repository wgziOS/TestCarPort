//
//  PublishRentCarViewController.h
//  carport
//
//  Created by 吴桂钊 on 2017/2/13.
//  Copyright © 2017年 86gg.cn. All rights reserved.
//

#import "ViewController.h"
#import "WGZaddCatPortImgView.h"
#import "PublishRentCarInfoCell.h"

@interface PublishRentCarViewController : ViewController
@property (strong, nonatomic) WGZaddCatPortImgView * carImgView;
@property (strong, nonatomic) WGZaddCatPortImgView * papersImgView;
@property (strong, nonatomic) NSString * carImgString;//车照片str
@property (strong, nonatomic) NSString * papersImgString;//
@property(nonatomic,strong) NSString * id;
@end
