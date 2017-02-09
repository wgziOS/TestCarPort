//
//  NearbyModel.h
//  carport
//
//  Created by 吴桂钊 on 2016/12/8.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParkingSpaceModel.h"
#import "PageModel.h"
#import "ListImgModel.h"
@interface NearbyModel : NSObject
@property(strong, nonatomic)ParkingSpaceModel * ParkingSpace;
@property(strong, nonatomic)PageModel * page;
@property(strong, nonatomic)NSArray * listImg;

-(id)initWithInfoDic:(NSDictionary *)infoDic;
@end
/*
 {
 1-	listImg =            [
 
 {
	addtime = /Date(1481074359073)/,
	id = 12,
	identifyID = 16efce9e-0367-43a3-b359-a0832a73cc79,
	EntityState = 2,
	imgurl = /upload/2016-12-07/2016120709311041796310.jpg,
 
	EntityKey = {
	EntitySetName = TbPrkingImg,
	EntityContainerName = ParkingEntities,
	EntityKeyValues = [
    { Key = id,Value = 12}
                      ],
	IsTemporary = 0
                    }
 }
                          ],
 
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
 
 3-   page = {CurrentPage = 0,
	PageSize = 10,
	TotalPage = 0,
	ToalRecord = 0
 }
 }*/
