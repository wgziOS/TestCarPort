//
//  TurnDate.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/9.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import "TurnDate.h"

@implementation TurnDate
+(NSString *)turnDataWithString:(NSString *)string
{
    NSString * astr = [string stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"/Date()/"]];
    NSString * bstr = [astr substringWithRange:NSMakeRange(0,10)];
    
    NSTimeInterval time  = [bstr doubleValue];//因为时差问题要加8小时 == 28800 sec
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:time];
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    NSString * currentDateStr = [dateFormatter stringFromDate:date];
    
    NSLog(@"%@",currentDateStr);
    return currentDateStr;
}
+(NSString *)turToDataWithoutHour:(NSString *)string
{
    NSString * astr = [string stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"/Date()/"]];
    NSString * bstr = [astr substringWithRange:NSMakeRange(0,10)];
    
    NSTimeInterval time  = [bstr doubleValue];//因为时差问题要加8小时 == 28800 sec
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:time];
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"YYYY/MM/dd"];
    NSString * currentDateStr = [dateFormatter stringFromDate:date];
    
    return currentDateStr;
 
}
@end
