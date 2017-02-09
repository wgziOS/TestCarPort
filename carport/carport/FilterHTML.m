//
//  FilterHTML.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/12.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import "FilterHTML.h"

@implementation FilterHTML
+(NSString *)filterHTML:(NSString *)htmlStr
{
    NSScanner * scanner = [NSScanner scannerWithString:htmlStr];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        htmlStr = [htmlStr stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    NSString * regEx = @"<([^>]*)>";
    htmlStr = [htmlStr stringByReplacingOccurrencesOfString:regEx withString:@""];
    return htmlStr;
}
@end
