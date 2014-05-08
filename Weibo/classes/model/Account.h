//
//  Account.h
//  Weibo
//
//  Created by jingdongqi on 14-5-2.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject<NSCoding>
@property(nonatomic,strong) NSString *accessToken;

@property(nonatomic,strong) NSString *uid;

@property(nonatomic,strong) NSString *screenName;


@end
