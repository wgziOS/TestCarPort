//
//  ParkingSpaceModel.h
//  carport
//
//  Created by 吴桂钊 on 2016/12/9.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EntityKeyModel.h"

@interface ParkingSpaceModel : NSObject
@property(strong, nonatomic)EntityKeyModel *  EntityKey;
@property(strong, nonatomic)NSString *  id;
@property(strong, nonatomic)NSString *  user_address;
@property(strong, nonatomic)NSString *  park_price;
@property(strong, nonatomic)NSString *  X_coordinate;
@property(strong, nonatomic)NSString *  starttime;
@property(strong, nonatomic)NSString *  endtime;
@property(strong, nonatomic)NSString *  userid;
@property(strong, nonatomic)NSString *  Y_coordinate;
@property(strong, nonatomic)NSString *  describe;
@property(strong, nonatomic)NSString *  addtime;
@property(strong, nonatomic)NSString *  title;
@property(strong, nonatomic)NSString *  EntityState;
@property(strong, nonatomic)NSString *  plate_number;
@property(strong, nonatomic)NSString *  username;
@property(strong, nonatomic)NSString *  remarks;
@property(strong, nonatomic)NSString *  status;
@property(strong, nonatomic)NSString *  identifyID;
@property(strong, nonatomic)NSString *  phone;

@property(strong, nonatomic)NSString * navigation_imgurl;
@property(strong, nonatomic)NSString *  imgurl;
@property(assign, nonatomic)int hours;
@property(assign, nonatomic)float discount;
@property(assign, nonatomic)int parking_manage;
@property(assign, nonatomic)int entry_mode;
@property(strong, nonatomic)NSString * parking_entrance;

@property(strong, nonatomic)NSString * ordercount;//订单数量 车主看发布过的车位才有

-(id)initWithInfoDic:(NSDictionary *)infoDic;

@end
/*
 2-	ParkingSpace =
 {
	id = 6,
	user_address = 厦门湖里区五通小区,
	park_price = 1,
	X_coordinate = 118.198671,
	starttime = /Date(1481245260000)/,
	endtime = /Date(1481367600000)/,
	userid = 2,
	Y_coordinate = 24.51415,
	describe = <p>膏早膏早膏早膏早</p>,
	addtime = /Date(1481074359057)/,
 
 2-1  EntityKey =
 {
	EntitySetName = TbPrkingSpace,
	EntityContainerName = ParkingEntities,
	EntityKeyValues =  [
 { Key = id,Value = 6 }
 ],
	IsTemporary = 0
 },
 
	title = 膏早膏早膏早膏早,
	EntityState = 2,
	plate_number = 闽E122s,
	username = mier沈,
	remarks = <null>,
	status = 1,
	identifyID = 16efce9e-0367-43a3-b359-a0832a73cc79
 },

*/
