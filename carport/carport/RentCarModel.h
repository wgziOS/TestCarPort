//
//  RentCarModel.h
//  carport
//
//  Created by 吴桂钊 on 2017/2/14.
//  Copyright © 2017年 86gg.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VehicleInformationModel.h"
#import "ListImgModel.h"
@interface RentCarModel : NSObject

@property(strong, nonatomic)VehicleInformationModel *  VehicleInformation;
@property(strong, nonatomic)NSArray *  listImg;

-(id)initWithInfoDic:(NSDictionary *)infoDic;
@end
