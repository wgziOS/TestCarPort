//
//  EntityKeyModel.h
//  carport
//
//  Created by 吴桂钊 on 2016/12/8.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EntityKeyModel : NSObject
@property(strong, nonatomic)NSString * EntitySetName;
@property(strong, nonatomic)NSString * EntityContainerName;
@property(strong, nonatomic)NSString * IsTemporary;
@property(strong, nonatomic)NSArray *  EntityKeyValues;
-(id)initWithInfoDic:(NSDictionary *)infoDic;
@end
/*
 

 
 
 EntityKey = {
 EntitySetName = TbPrkingSpace,
 EntityContainerName = ParkingEntities,
 EntityKeyValues = [
 {
 Key = id,
 Value = 1
 }
 ],
 IsTemporary = 0
 },
 
 
 EntityKey =      {
 EntityContainerName = YSPmallEntities;
 EntityKeyValues =             (
 {
 Key = id;
 Value = 2;
 }
 );
*/
