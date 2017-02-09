//
//  EntityKeyModel.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/8.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import "EntityKeyModel.h"

@implementation EntityKeyModel
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
