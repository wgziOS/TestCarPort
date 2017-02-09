//
//  ImageScrollView.h
//  carport
//
//  Created by 吴桂钊 on 2016/12/12.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
@interface ImageScrollView : UIView <SDCycleScrollViewDelegate>
@property(strong,nonatomic)SDCycleScrollView * scrollview;
-(id)initWithFrame:(CGRect)frame andImageArray:(NSArray *)imageArray;
@end
