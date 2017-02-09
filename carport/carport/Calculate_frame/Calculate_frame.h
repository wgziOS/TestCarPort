//
//  Calculate_frame.h
//  CircleOfFriend
//
//  Created by qiuchengsong on 14-8-19.
//  Copyright (c) 2014年 qiuchengsong. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Calculate_frame : NSObject

+ (CGSize)getText:(NSString *)text andFont:(float)font;

+ (CGSize)getText_WH:(NSString *)text andWidth:(float)width andFont:(float)font;

+ (void)alertViewWithTitle:(NSString *)title andMessage:(NSString *)msg andCancelBtn:(NSString *)cancelBtn andOtherBtn:(NSString *)otherBtn;

+ (void)showWithHUD;

+ (void)showWithImage:(NSString *)image;

+ (void)showWithText:(NSString *)text;

+ (void)dismiss;

+ (void)againLogin;//重新登录


+ (UIView *)setUpViewWithFrame:(CGRect)frame;
+ (UILabel *)setUpLabelWithFrame:(CGRect)frame andText:(NSString *)text andFont:(int)fontSize;
+ (void)initLabelFromat:(UILabel *)label text:(NSString *)text textColor:(UIColor *)color Font:(NSInteger)fontNumber Alignment:(NSTextAlignment)Alignment bgColor:(UIColor *)bgColor;
+ (UIImageView *)setUpImageViewFrame:(CGRect)frame andImage:(NSString *)img;
+ (UIButton *)setUpButtonWithFrame:(CGRect)frame andTitle:(NSString *)title andBGImg:(NSString *)bgImg andImg:(NSString *)img;

/**
 *  通过symbol，把“20140716155436”转换成“2014-07-16_15:54:36”
 或者  把“20140716155436”转换成“2014:07:16_15:54:36”
 */
+(NSString *)timeFromString:(NSString *)str andBySymbol:(NSString *)symbol;
/**
 *  获取 系统当前时间
 */
//+ (NSString *)getCurrentTime;
+ (NSString *)getCurrentTime:(NSString *)time;

//“key”为allowkey，value为：当前时间（例如：（2016-5-1-15，年月日时）+签约者（“dianzijingjijulebu”））小写32位md5加密
+ (NSString *)getAllowkey;

//32位md5加密
+ (NSString *) md5:(NSString *)str;

/**
 *  把时间(70)秒 转化为 00:10:00
 (3601)秒 转化为 01:00:01
 */
+ (NSString *)timeStrFromDuration:(NSString *)duration;

/**
 *  判断 表情符号
 YES:有表情
 */
+ (BOOL)stringContainsEmoji:(NSString *)string;


/**
 *  动画效果
 *
 *  @param fromValuePoint 开始位置
 *  @param toValuePoint   结束位置
 *  @param view           在哪个视图上显示
 */
+ (void)buttonAnimationFromValuePoint:(CGPoint)fromValuePoint buttonAnimationToValuePoint:(CGPoint)toValuePoint target:(UIView *)view;

+ (id)viewShadow:(UIView *)viewLayer;




@end
