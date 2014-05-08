//
//  WeiboConfig.h
//  Weibo
//
//  Created by jingdongqi on 14-5-1.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#ifndef Weibo_WeiboConfig_h
#define Weibo_WeiboConfig_h
#define kAppKey @"3593499757"
#define kAppSecret @"3d8214e22cd9a710f7419fcfa39e3fb8"
#define kRedirectURL @"https://api.weibo.com/oauth2/default.html"
#define kAccessToken @"access_token"
#define KUid @"uid"
// 公共请求地址
#define kBaseURL @"https://api.weibo.com/2/"

// 授权地址
#define kOauthURL [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@&display=mobile&response_type=token", kAppKey, kRedirectURL]










#endif
