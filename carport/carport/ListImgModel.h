//
//  ListImgModel.h
//  carport
//
//  Created by 吴桂钊 on 2016/12/9.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EntityKeyModel.h"
@interface ListImgModel : NSObject

@property(strong, nonatomic)NSString *  addtime;
@property(strong, nonatomic)NSString *  id;
@property(strong, nonatomic)NSString *  identifyID;
@property(strong, nonatomic)NSString *  EntityState;
@property(strong, nonatomic)NSString *  imgurl;
@property(strong, nonatomic)EntityKeyModel *  EntityKey;

-(id)initWithInfoDic:(NSDictionary *)infoDic;

@end
/*
 listImg =            [
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
                     ]
*/
