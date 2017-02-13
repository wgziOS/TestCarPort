//
//  UserInfoModel.m
//  carport
//
//  Created by 吴桂钊 on 2017/2/13.
//  Copyright © 2017年 86gg.cn. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel
-(id)initWithInfoDic:(NSDictionary *)infoDic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:infoDic];
    }
    return self;
    
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
