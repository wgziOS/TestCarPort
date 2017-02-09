//
//  Calculate_frame.m
//  CircleOfFriend
//
//  Created by qiuchengsong on 14-8-19.
//  Copyright (c) 2014年 qiuchengsong. All rights reserved.
//

#import "Calculate_frame.h"
#import <CommonCrypto/CommonDigest.h>
#import "GiFHUD.h"
#import <AddressBook/AddressBook.h>
#import "SVProgressHUD.h"

@implementation Calculate_frame

+ (CGSize)getText:(NSString *)text andFont:(float)font{
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:font]};
    CGSize size = [text sizeWithAttributes:attributes];
    return size;
}

+ (CGSize)getText_WH:(NSString *)text andWidth:(float)width andFont:(float)font{
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:font]};
    
    CGSize textSize = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return textSize;
}

+ (void)alertViewWithTitle:(NSString *)title andMessage:(NSString *)msg andCancelBtn:(NSString *)cancelBtn andOtherBtn:(NSString *)otherBtn{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:msg delegate:self cancelButtonTitle:cancelBtn otherButtonTitles:otherBtn, nil];
    [alertView show];
}

+ (void)showWithHUD {
    [GiFHUD setGifWithImageName:@"loading_1.gif"];
    [GiFHUD show];
}

+ (void)showWithImage:(NSString *)image{
    [GiFHUD setGifWithImageName:image];
    [GiFHUD show];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [GiFHUD dismiss];
    });
}

+ (void)showWithText:(NSString *)text{
    [SVProgressHUD showImage:nil status:text];
}

+ (void)dismiss {
    [GiFHUD dismiss];
}



+ (UIView *)setUpViewWithFrame:(CGRect)frame{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

+ (UILabel *)setUpLabelWithFrame:(CGRect)frame andText:(NSString *)text andFont:(int)fontSize{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = text;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    label.adjustsFontSizeToFitWidth = YES;
    return label;
}

+ (void)initLabelFromat:(UILabel *)label text:(NSString *)text textColor:(UIColor *)color Font:(NSInteger)fontNumber Alignment:(NSTextAlignment)Alignment bgColor:(UIColor *)bgColor{
    label.text = text;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:fontNumber];
    label.textAlignment = Alignment;
    label.backgroundColor = bgColor;
}

+ (UIImageView *)setUpImageViewFrame:(CGRect)frame andImage:(NSString *)img{
    UIImage *image = [UIImage imageNamed:img];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = image;
    return imageView;
}

+ (UIButton *)setUpButtonWithFrame:(CGRect)frame andTitle:(NSString *)title andBGImg:(NSString *)bgImg andImg:(NSString *)img{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setBackgroundImage:[UIImage imageNamed:bgImg] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    return  button;
}


+(NSString *)timeFromString:(NSString *)str andBySymbol:(NSString *)symbol{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyyMMddHHmmss"];
    [formater setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSDate* date = [[NSDate alloc]init];
    date = [formater dateFromString:str];
    
    NSDateFormatter * formater2 = [[NSDateFormatter alloc] init];
    
    if ([symbol isEqualToString:@"-"]) {
        [formater2 setDateFormat:@"yyyy-MM-dd_HH:mm:ss"];
    } else {
        [formater2 setDateFormat:@"yyyy:MM:dd_HH:mm:ss"];
    }
    
    
    NSString * str1 = [formater2 stringFromDate:date];
    return str1;
}

//+ (NSData *)timeData:(NSString *)timedata
//{
//    NSDateFormatter * formatter = [[NSDateFormatter alloc] init] ;
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//    NSDate * date = [formatter dateFromString:timedata];
//    return date;
//}

#pragma mark token失效时调重新登录
+ (void)againLogin
{
//    NSString * mobile = [[Iffomation userIffoModel] saveiphone];
//    
//    NSString * TEACHER           = [Calculate_frame md5:[[Iffomation userIffoModel] savePassWord]];
//    NSString * TEACHERLower      = [TEACHER lowercaseString];    //小写
//
//    NSMutableDictionary * params = [NSMutableDictionary dictionary];
//    if (mobile.length != 0 && TEACHERLower.length != 0) {
//        [params setObject:mobile forKey:@"mobile"];
//        [params setObject:TEACHERLower forKey:@"password"];
//    }
//    
//    [MHNetworkManager postReqeustWithURL:API_LOGIN_URL params:params successBlock:^(NSDictionary *returnData) {
//        
//        if ([[returnData objectForKey:@"return_code"] integerValue] == RETURN_CODE) {
//            
//            NSDictionary * userCommonMsgdic = [returnData objectForKey:@"userCommonMsg"];
//            NSDictionary * userSecureMsgdic = [returnData objectForKey:@"userSecureMsg"];
//            //将用户信息存放到静态变量，便于取用
//            //将用户信息存放到本地
//            UserCommonMsgModel * userCommonMsg = [UserCommonMsgModel userCommonMsgWithDict:userCommonMsgdic];
//            UserSecureMsgModel * userSecureMsg = [UserSecureMsgModel userSecureMsgWithDict:userSecureMsgdic];
//            [[Iffomation userIffoModel] saveUserCommonMSg:userCommonMsg saveUserSecureMsg:userSecureMsg];
//            
//            NSString * token = [returnData objectForKey:@"token"];
//            [[Iffomation userIffoModel] saveToken:token];
//            
//            //保存登录时间
//            NSString * time = [returnData objectForKey:@"loginTime"];
//            [[Iffomation userIffoModel] saveLoginTime:time];
//            
//        }else if ([[returnData objectForKey:@"return_code"] integerValue] == API_STATUS_NETWORK){
//            
//            
//        }else{
//            
//        }
//    
//    } failureBlock:^(NSError *error) {
//        
//    } showHUD:NO];
}

//+ (NSString *) getCurrentTime{
//    NSDate *senddate=[NSDate date];
//    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
//    [dateformatter setDateFormat:@"YYYYMMddHHmmss"];
//    NSString *timeStr = [dateformatter stringFromDate:senddate];
//    return timeStr;
//}

+ (NSString *)getCurrentTime:(NSString *)time{
    
    NSDateFormatter * inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * inputDate = [inputFormatter dateFromString:time];
    
    NSDate * senddate = inputDate;
    NSDateFormatter * dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYYMMddHHmmss"];//大写为24小时制
    NSString * timeStr = [dateformatter stringFromDate:senddate];
    return timeStr;
}

+ (NSString *)getAllowkey{
    NSDate *senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-M-d-H"];
    NSString *timeStr = [dateformatter stringFromDate:senddate];
    NSString *allkeyStr = [NSString stringWithFormat:@"%@dianzijingjijulebu", timeStr];
    allkeyStr = [[Calculate_frame md5:allkeyStr] lowercaseString];
    return allkeyStr;
}
                 
                
+ (NSString *) md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


+ (NSString *)timeStrFromDuration:(NSString *)duration{
    long hour, minute, second, durations;
    durations = [duration longLongValue];
    
    hour = durations/3600;
    minute = durations%3600/60;
    second =durations%60;
    NSString *timeStr = [NSString stringWithFormat:@"%.2ld:%.2ld:%.2ld",hour, minute, second];
    
    return timeStr;
}


+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}


//    按钮下拉动画
+ (void)buttonAnimationFromValuePoint:(CGPoint)fromValuePoint buttonAnimationToValuePoint:(CGPoint)toValuePoint target:(UIView *)view{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = 0.3;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.fromValue = [NSValue valueWithCGPoint:fromValuePoint];
    animation.toValue = [NSValue valueWithCGPoint:toValuePoint];
    [view.layer addAnimation:animation forKey:nil];
}


+ (id)viewShadow:(UIView *)viewLayer{
    viewLayer.layer.shadowOpacity = 0.3; //阴影透明度，默认0
    viewLayer.layer.shadowOffset = CGSizeMake(0.5, 0.5);
    viewLayer.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    viewLayer.layer.cornerRadius = 5;
    viewLayer.layer.shouldRasterize = YES;
    viewLayer.layer.rasterizationScale = [UIScreen mainScreen].scale;
    return viewLayer;
}


@end
