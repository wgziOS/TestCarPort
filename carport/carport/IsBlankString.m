//
//  IsBlankString.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/23.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import "IsBlankString.h"

@implementation IsBlankString
#pragma mark判断字符串是否为空

+(BOOL) isBlankString:(NSString*)string
{
    
    NSString* astring = string;
    
    astring = [astring stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    if(astring ==nil|| astring ==NULL) {
        
        return YES;
        
    }
    
    if([astring isEqualToString:@"\n"]) {
        
        return YES;
        
    }
    
    if([astring isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    if([[astring stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]length]==0) {
        
        return YES;
        
    }
    
    return NO;
    
}
@end
