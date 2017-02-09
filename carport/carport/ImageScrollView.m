//
//  ImageScrollView.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/12.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import "ImageScrollView.h"

@implementation ImageScrollView
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        NSArray * imagesarray = @[@"fjcw_09.jpg",@"20141223.jpg",@"fjcw_09.jpg"];
        _scrollview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,140) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        _scrollview.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot@2x"];
        _scrollview.pageDotImage = [UIImage imageNamed:@"pageControlDot@2x"];
        _scrollview.localizationImageNamesGroup = imagesarray;
        _scrollview.autoScrollTimeInterval = 2.0;
        _scrollview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_scrollview];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame andImageArray:(NSArray *)imageArray
{
    if (self = [super initWithFrame:frame])
    {
        
        _scrollview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,120) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        _scrollview.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot@2x"];
        _scrollview.pageDotImage = [UIImage imageNamed:@"pageControlDot@2x"];
        _scrollview.localizationImageNamesGroup = imageArray;
        _scrollview.autoScrollTimeInterval = 2.0;
        _scrollview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_scrollview];
    }
    return self;
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;
{
   
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
