//
//  BaseTextModel.h
//  Weibo
//
//  Created by jingdongqi on 14-5-14.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;
@interface BaseTextModel : NSObject
@property (nonatomic, copy) NSString *idstr; // ID
@property (nonatomic, copy) NSString *text; // 内容
@property (nonatomic, copy) NSString *createdAt; // 创建时间
@property (nonatomic, strong) User *user; // 微博发送者

- (id)initWithDict:(NSDictionary *)dict;

@end
