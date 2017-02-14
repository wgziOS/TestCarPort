//
//  VehicleInformationModel.h
//  carport
//
//  Created by 吴桂钊 on 2017/2/14.
//  Copyright © 2017年 86gg.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EntityKeyModel.h"

@interface VehicleInformationModel : NSObject

@property(strong, nonatomic)EntityKeyModel *  EntityKey;
@property(strong, nonatomic)NSString *  Id;
@property(strong, nonatomic)NSString *  userid;
@property(strong, nonatomic)NSString *  owner_name;
@property(strong, nonatomic)NSString *  owner_phone;
@property(strong, nonatomic)NSString *  plate_number;
@property(strong, nonatomic)NSString *  car_size;
@property(strong, nonatomic)NSString *  seat_count;
@property(strong, nonatomic)NSString *  buy_car_year;
@property(strong, nonatomic)NSString *  kilometers_traveled;
@property(strong, nonatomic)NSString *  variable_box;
@property(strong, nonatomic)NSString *  engine_displacement;
@property(strong, nonatomic)NSString *  identifyID;
@property(strong, nonatomic)NSString *  starttime;
@property(strong, nonatomic)NSString *  endtime;
@property(strong, nonatomic)NSString *  non_holiday_prie;
@property(strong, nonatomic)NSString *  holiday_prie;
@property(strong, nonatomic)NSString *  deposited_price;
@property(strong, nonatomic)NSString *  car_address;
@property(strong, nonatomic)NSString *  take_car;
@property(strong, nonatomic)NSString *  status;
@property(strong, nonatomic)NSString *  descinfo;
@property(strong, nonatomic)NSString *  remarks;
@property(strong, nonatomic)NSString *  addtime;
@property(strong, nonatomic)NSString *  EntityState;

-(id)initWithInfoDic:(NSDictionary *)infoDic;

@end
