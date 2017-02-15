//
//  TurnDate.h
//  carport
//
//  Created by 吴桂钊 on 2016/12/9.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TurnDate : NSObject
+(NSString *)turnDataWithString:(NSString *)string;
+(NSString *)turToDataWithoutHour:(NSString *)string;
@end
