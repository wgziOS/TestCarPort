//
//  PageModel.h
//  carport
//
//  Created by 吴桂钊 on 2016/12/9.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PageModel : NSObject

@property(strong, nonatomic)NSString *  CurrentPage;
@property(strong, nonatomic)NSString *  PageSize;
@property(strong, nonatomic)NSString *  TotalPage;
@property(strong, nonatomic)NSString *  ToalRecord;
-(id)initWithInfoDic:(NSDictionary *)infoDic;
@end
/*
page = {CurrentPage = 0,
    PageSize = 10,
    TotalPage = 0,
    ToalRecord = 0
}
*/
