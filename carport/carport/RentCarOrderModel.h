//
//  RentCarOrderModel.h
//  carport
//
//  Created by 吴桂钊 on 2017/2/21.
//  Copyright © 2017年 86gg.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarRentalOrdersModel.h"

@interface RentCarOrderModel : NSObject

@property(strong, nonatomic)CarRentalOrdersModel * CarRentalOrders;
@property(strong, nonatomic)NSArray * listImg;



-(id)initWithInfoDic:(NSDictionary *)infoDic;
@end
