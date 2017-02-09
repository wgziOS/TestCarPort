//
//  OrderListModel.h
//  carport
//
//  Created by 吴桂钊 on 2016/12/26.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EntityKeyModel.h"
@interface OrderListModel : NSObject
@property(strong, nonatomic)EntityKeyModel *  EntityKey;
@property(strong, nonatomic)NSString *  navigation_imgurl;
@property(strong, nonatomic)NSString *  userid;
@property(strong, nonatomic)NSString *  user_address;
@property(strong, nonatomic)NSString *  status;
@property(strong, nonatomic)NSString *  title;
@property(strong, nonatomic)NSString *  updatetime;
@property(strong, nonatomic)NSString *  owner;
@property(strong, nonatomic)NSString *  starttime;
@property(strong, nonatomic)NSString *  endtime;
@property(strong, nonatomic)NSString *  truename;
@property(strong, nonatomic)NSString *  adtime;
@property(strong, nonatomic)NSString *  id;
@property(strong, nonatomic)NSString *  pay_price;
@property(strong, nonatomic)NSString *  identifyID;
@property(strong, nonatomic)NSString *  plate_number;
@property(strong, nonatomic)NSString *  phone;
@property(strong, nonatomic)NSString *  remarks;
@property(strong, nonatomic)NSString *  EntityState;
@property(strong, nonatomic)NSString *  prkid;
@property(strong, nonatomic)NSString *  park_price;
@property(strong, nonatomic)NSString *  username;
-(id)initWithInfoDic:(NSDictionary *)infoDic;
@end
/*
 navigation_imgurl = <null>,
	userid = 1,
	user_address = 厦门思明区观音山国际运营中心9号楼2F,
	status = 1,
	title = 思明区观音山国际运营中心,
	updatetime = /Date(1482460685937)/,
	owner = 16,
	starttime = /Date(1482455400000)/,
	endtime = /Date(1482490440000)/,
	truename = 林森,
	adtime = /Date(1482460685937)/,
 
	EntityKey = {
	EntitySetName = view_OrdersOwner,
	EntityContainerName = ParkingEntities,
	EntityKeyValues = [
 {
	Key = id,
	Value = 37
 }
 ],
	IsTemporary = 0
 },
 
	id = 37,
	pay_price = 1,
	identifyID = 49abe480-392a-425b-a884-a626afa81f88,
	plate_number = D529Z,
	phone = 15880056064,
	remarks = <null>,
	EntityState = 2,
	prkid = 1
*/
