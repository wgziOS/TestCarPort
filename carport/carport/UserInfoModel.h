//
//  UserInfoModel.h
//  carport
//
//  Created by 吴桂钊 on 2017/2/13.
//  Copyright © 2017年 86gg.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EntityKeyModel.h"
@interface UserInfoModel : NSObject
@property(strong, nonatomic)EntityKeyModel * EntityKey;
@property(strong, nonatomic)NSString * id;
@property(strong, nonatomic)NSString * truename;
@property(strong, nonatomic)NSString * phone;
@property(strong, nonatomic)NSString * sex;
@property(strong, nonatomic)NSString * userAddress;
@property(strong, nonatomic)NSString * addtime;
@property(strong, nonatomic)NSString * lasttime;
@property(strong, nonatomic)NSString * balance;
@property(strong, nonatomic)NSString * weixin;
@property(strong, nonatomic)NSString * EntityState;
@property(strong, nonatomic)NSString * headimg;
@property(strong, nonatomic)NSString * plate_number;
@property(strong, nonatomic)NSString * pwd;
@property(strong, nonatomic)NSString * qq;
@property(strong, nonatomic)NSString * remarks;
@property(strong, nonatomic)NSString * status;
@property(strong, nonatomic)NSString * IDcard;


-(id)initWithInfoDic:(NSDictionary *)infoDic;
@end
