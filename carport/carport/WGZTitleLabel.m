//
//  WGZTitleLabel.m
//  1026仿网易新闻首页
//
//  Created by 吴桂钊 on 2016/10/26.
//  Copyright © 2016年 吴桂钊. All rights reserved.
//

#import "WGZTitleLabel.h"

@implementation WGZTitleLabel

#define RGBRed 0
#define  RGBGreen 0
#define RGBBlue 0
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:15];
        self.textColor = [UIColor colorWithRed:RGBRed green:RGBGreen blue:RGBBlue alpha:1.0];
        self.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    
    CGFloat red = RGBRed + (0.164 - RGBRed) * scale;
    CGFloat green = RGBGreen + (0.678 - RGBGreen) * scale;
    CGFloat blue = RGBBlue + (0.91 - RGBBlue) * scale;
//    CGFloat red = 42.0f;
//    CGFloat green = 173.0f;
//    CGFloat blue = 234.0f;
    self.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    // 大小缩放比例
    CGFloat transformScale = 1 + scale * 0.3; // [1, 1.3]
    self.transform = CGAffineTransformMakeScale(transformScale, transformScale);
}

@end
