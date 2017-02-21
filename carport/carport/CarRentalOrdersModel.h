//
//  CarRentalOrdersModel.h
//  carport
//
//  Created by 吴桂钊 on 2017/2/21.
//  Copyright © 2017年 86gg.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EntityKeyModel.h"
@interface CarRentalOrdersModel : NSObject

@property(strong, nonatomic)EntityKeyModel * EntityKey;
@property(strong, nonatomic)NSString * Id;
@property(strong, nonatomic)NSString * Carid;
@property(strong, nonatomic)NSString * Serial_number;
@property(strong, nonatomic)NSString * remarks;
@property(strong, nonatomic)NSString * updatetime;
@property(strong, nonatomic)NSString * addtime;
@property(strong, nonatomic)NSString * Pay_price;
@property(strong, nonatomic)NSString * Status;
@property(strong, nonatomic)NSString * Endtime;
@property(strong, nonatomic)NSString * EntityState;
@property(strong, nonatomic)NSString * Starttime;
@property(strong, nonatomic)NSString * take_car;
@property(strong, nonatomic)NSString * car_address;
@property(strong, nonatomic)NSString * deposited_price;
@property(strong, nonatomic)NSString * holiday_prie;
@property(strong, nonatomic)NSString * on_holiday_prie;
@property(strong, nonatomic)NSString * identifyID;
@property(strong, nonatomic)NSString * engine_displacement;
@property(strong, nonatomic)NSString * variable_box;
@property(strong, nonatomic)NSString * kilometers_traveled;
@property(strong, nonatomic)NSString * buy_car_year;
@property(strong, nonatomic)NSString * seat_count;
@property(strong, nonatomic)NSString * car_size;
@property(strong, nonatomic)NSString * plate_number ;
@property(strong, nonatomic)NSString * owner_phone;
@property(strong, nonatomic)NSString * owner_name;
@property(strong, nonatomic)NSString * Owner;
@property(strong, nonatomic)NSString * Userid;



-(id)initWithInfoDic:(NSDictionary *)infoDic;
@end
