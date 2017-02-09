//
//  DicToJson.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/20.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import "DicToJson.h"

@implementation DicToJson
+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

@end
