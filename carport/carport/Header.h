//
//  Header.h
//  carport
//
//  Created by 吴桂钊 on 2016/12/5.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#ifndef Header_h
#define Header_h


#define URLHTTP @"http://192.168.123.73:8090"
//通用接口地址
#define API_LOGIN_URL                   [NSString stringWithFormat:@"%@/API/Login",URLHTTP]//登录

#define API_SEND_PHONE_CODE_URL        [NSString stringWithFormat:@"%@/API/SendPhoneCode",URLHTTP]//验证码接口

#define API_REGISTER_URL                [NSString stringWithFormat:@"%@/API/Register",URLHTTP]     //用户注册

#define API_SUBMIT_FORGET_PASSWORD_URL  [NSString stringWithFormat:@"%@/API/SubmitForgetPassword",URLHTTP]     //用户找密码

#define API_SUBMIT_USERPWD_URL          [NSString stringWithFormat:@"%@/API/SubmitUserPwd",URLHTTP]      //用户更改密码

#define API_SUBMIT_PROPOSED_FEEDBACK_URL        [NSString stringWithFormat:@"%@/API/SubmitProposedFeedback",URLHTTP]      //建议反馈的接口 (string Token, string RecommendedContent)

#define API_TOKEN_URL        [NSString stringWithFormat:@"%@/API/GetToken",URLHTTP]//token

#define API_GETNEARBYNEARPAKING_URL        [NSString stringWithFormat:@"%@/API/GetNearbyNearPaking",URLHTTP]//附近车位

#define API_USER_BESPEAK_SPACE_URL        [NSString stringWithFormat:@"%@/API/UserBespeakSpace",URLHTTP]//预约车位(string Token, int Parkid)

#define API_SUBMIT_PARKING_SPACE_URL        [NSString stringWithFormat:@"%@/API/SubmitParkingSpace",URLHTTP]//发布车位(string Token, string Joson)

#define API_OWNER_PARKING_SPACE_DELETE_URL        [NSString stringWithFormat:@"%@/API/OwnerParkingSpaceDelete",URLHTTP]//下架车位(string Token, int Spaceid)

#define API_OWNER_ORDERS_LIST_URL        [NSString stringWithFormat:@"%@/API/OwnerOrdersList",URLHTTP]//我的订单（车主）(string Token, int? Prkid)

#define API_USER_ORDERS_LIST_URL        [NSString stringWithFormat:@"%@/API/UserOrdersList",URLHTTP]//用户查看订单列表 (string Token)

#define API_USER_ORDERS_CANCEL_URL        [NSString stringWithFormat:@"%@/API/UserOrderCancel",URLHTTP]//用户取消订单 (string Token, int Orderid)


//#define API_GETPARKINGIMGLIST_URL        [NSString stringWithFormat:@"%@/API/GetParkingImgList",URLHTTP]//停车照片
#define API_GET_PARKING_SPACE_LIST_URL        [NSString stringWithFormat:@"%@/API/GetParkingSpaceList",URLHTTP]//查询发布的车位

#define API_GET_USER_BASE_INFO_URL        [NSString stringWithFormat:@"%@/API/GetUserBaseInfo",URLHTTP]//GetUserBaseInfo 个人中心(string Token)


#define API_GET_VEHICLE_INFOMATION_URL       [NSString stringWithFormat:@"%@/API/GetVehicleInformation",URLHTTP]//获取租车订单列表(string Token, int? CurrentPage)



//车主发布车辆信息 SubmitVehicleInformation(string Token, string Json)
//用户租车  UserCarRental(string Token, int VehicleId)

//主题蓝色
#define BLUECOLOR [UIColor colorWithRed:77.0/255.0 green:175.0/255.0 blue:252.0/255.0 alpha:1]

//屏幕物理高度
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

//屏幕物理高度
#define SCREENWITH   [UIScreen mainScreen].bounds.size.width

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//定义一个define函数
#define TT_RELEASE_CF_SAFELY(__REF) { if (nil != (__REF)) { CFRelease(__REF); __REF = nil; } }

//NavBar高度
#define NavigationBar_HEIGHT 44

//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]

//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//导航栏的高度
#define STATUS_HEIGHT ([[UIDevice currentDevice].systemVersion doubleValue] < 7.0 ? 44.0 : 64.0)

#endif /* Header_h */
