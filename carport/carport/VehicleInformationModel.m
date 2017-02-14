//
//  VehicleInformationModel.m
//  carport
//
//  Created by 吴桂钊 on 2017/2/14.
//  Copyright © 2017年 86gg.cn. All rights reserved.
//

#import "VehicleInformationModel.h"

@implementation VehicleInformationModel
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
