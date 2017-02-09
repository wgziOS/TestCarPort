//
//  WGZToggleButton.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/16.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import "WGZToggleButton.h"
@interface WGZToggleButton ()

@property (nonatomic, retain) UIImage *onImage;
@property (nonatomic, retain) UIImage *offImage;

@end
@implementation WGZToggleButton
@synthesize onImage = _onImage;
@synthesize offImage = _offImage;

@synthesize on = _on;
@synthesize autotoggleEnabled = _autotoggleEnabled;

+ (id)buttonWithOnImage:(UIImage *)onImage offImage:(UIImage *)offImage highlightedImage:(UIImage *)highlightedImage{
    WGZToggleButton *button;
    button = [WGZToggleButton buttonWithType:UIButtonTypeCustom];
    button.onImage = onImage;
    button.offImage = offImage;
    [button setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    
    [button setBackgroundImage:offImage forState:UIControlStateNormal];
    button.autotoggleEnabled = YES;
    
    return button;
}


- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    
    [super endTrackingWithTouch:touch withEvent:event];
    if (self.touchInside && self.autotoggleEnabled) {
        [self toggle];
    }
}


- (BOOL)toggle{
    self.on = !self.on;
    return self.on;
}


- (void)setOn:(BOOL)on{
    if (_on != on) {
        _on = on;
        [self setBackgroundImage:(_on ? self.onImage : self.offImage) forState:UIControlStateNormal];
    }
}


////添加对IB的支持
//#pragma mark - initFromNib
//- (void)awakeFromNib{
//    self.autotoggleEnabled = YES;
//    self.onImage = [self backgroundImageForState:UIControlStateSelected];
//    self.offImage = [self backgroundImageForState:UIControlStateNormal];
//    [self setBackgroundImage:nil forState:UIControlStateSelected];
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
