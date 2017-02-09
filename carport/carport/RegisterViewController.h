//
//  RegisterViewController.h
//  carport
//
//  Created by 吴桂钊 on 2016/12/5.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import "ViewController.h"

@interface RegisterViewController : ViewController

@property (strong, nonatomic) NSTimer *codeTimer;
@property (assign) int codeTimerCount;

@property (assign) BOOL isRequestRunning;
@property (assign) BOOL enableRegister;
@property (assign) BOOL enableLogin;

- (void)onGetCodeAction:(id)sender;

@end
