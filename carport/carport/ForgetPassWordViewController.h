//
//  ForgetPassWordViewController.h
//  carport
//
//  Created by 吴桂钊 on 2016/12/14.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPassWordViewController : UIViewController
@property (strong, nonatomic) NSTimer *codeTimer;
@property (assign) int codeTimerCount;
@end
