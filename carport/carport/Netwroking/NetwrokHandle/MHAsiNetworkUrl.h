//
//  MHAsiNetworkUrl.h
//  MHProject
//
//  Created by MengHuan on 15/4/23.
//  Copyright (c) 2015年 MengHuan. All rights reserved.
//

#ifndef MHProject_MHAsiNetworkUrl_h
#define MHProject_MHAsiNetworkUrl_h
///**
// *  正式环境
// */
//

//获取token
#define APP_TOKEN [[NSUserDefaults standardUserDefaults]objectForKey:@"token"]

//获取图片url
#define LOAD_IMAGE(url) [NSURL URLWithString:[NSString stringWithFormat:@"%@&token=%@",url,APP_TOKEN]]

//获取默认图片
#define PLACEHOLDER_IMAGE [UIImage imageNamed:@"load_fail"]

//分享列表
#define SHARE_LIST @"http://120.24.12.114:8080/api/share-list.action"

//分享详情
#define SHARE_DETAIL @"http://120.24.12.114:8080/api/share-detail.action"

//发布分享
#define SEND_SHARE @"http://120.24.12.114:8080/api/share-add.action"

//分享评论
#define SHARE_COMMENT @"http://120.24.12.114:8080/api/share-comment-add.action"

//分享点赞
#define SHARE_LIKE @"http://120.24.12.114:8080/api/share-like.action"


//用户评论
#define USER_COMMENT @"http://120.24.12.114:8080/api/share-comment-add.action"

//商家列表
#define SHOPS_LIST @"http://120.24.12.114:8080/api/seller-list.action"

//商家详情
#define SHOPS_DETAIL @"http://120.24.12.114:8080/api/seller-detail.action"

//商家点赞
#define SHOPS_COMMENT @"http://120.24.12.114:8080/api/seller-comment-add.action"

//商家点赞
#define SHOP_LIKE @"http://120.24.12.114:8080/api/seller-like.action"

//商家评论点赞
#define SHOP_COMMENT_LIKE @"http://120.24.12.114:8080/api/seller-comment-like.action"

#endif
