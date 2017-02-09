//
//  WGZaddCatPortImgView.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/15.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//
#define kAdeleImage @"fbcw-sc-icon.png" // 删除按钮图片
#define deleImageWH 25 // 删除按钮的宽高

#import "WGZaddCatPortImgView.h"
@interface WGZaddCatPortImgView()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    // 标识被编辑的按钮 -1 为添加新的按钮
    NSInteger editTag;
    UIButton *dele;
}
@end

@implementation WGZaddCatPortImgView

- (id)initWithFrame:(CGRect)frame andImageStr:(NSString *)imageStr
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
        self.bottonImage = [UIImage imageNamed:imageStr];
        [self addTarget:self action:@selector(callImagePicker) forControlEvents:UIControlEventTouchUpInside];
        UILongPressGestureRecognizer *gester = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:gester];
    }
    return self;
}
// 长按添加删除按钮
- (void)longPress : (UIGestureRecognizer *)gester
{
    if (gester.state == UIGestureRecognizerStateBegan)
    {
        UIButton *btn = (UIButton *)gester.view;
        
        dele = [UIButton buttonWithType:UIButtonTypeCustom];
        dele.bounds = CGRectMake(0, 0, deleImageWH, deleImageWH);
        [dele setImage:[UIImage imageNamed:kAdeleImage] forState:UIControlStateNormal];
        [dele addTarget:self action:@selector(deletePi:) forControlEvents:UIControlEventTouchUpInside];
        dele.frame = CGRectMake(btn.frame.size.width - dele.frame.size.width, 0, dele.frame.size.width, dele.frame.size.height);
        
        [btn addSubview:dele];
        [self start:btn];
    }
    
}
// 长按开始抖动
- (void)start: (UIButton *)btn {
    double angle1 = -5.0 / 180.0 * M_PI;
    double angle2 = 5.0 / 180.0 * M_PI;
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation";
    
    anim.values = @[@(angle1), @(angle2), @(angle1)];
    anim.duration = 0.25;
    // 动画的重复执行次数
    anim.repeatCount = MAXFLOAT;
    
    // 保持动画执行完毕后的状态
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    
    [btn.layer addAnimation:anim forKey:@"shake"];
}

// 停止抖动
- (void)stop: (UIButton *)btn{
    [btn.layer removeAnimationForKey:@"shake"];
}

// 删除图片
- (void)deletePi:(UIButton *)btn
{
    [self setImage:self.bottonImage forState:UIControlStateNormal];
    [self stop:self];
    dele.hidden = YES;
}

// 调用图片选择器
- (void)callImagePicker
{
    UIImagePickerController *pc = [[UIImagePickerController alloc] init];
    pc.allowsEditing = YES;
    pc.delegate = self;
    [self.window.rootViewController presentViewController:pc animated:YES completion:nil];
}
#pragma mark - UIImagePickerController 代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    self.image = image;
    [self setImage:self.image forState:UIControlStateNormal];
    
    // 退出图片选择控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
}



@end
