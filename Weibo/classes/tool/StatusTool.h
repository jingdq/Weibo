//
//  StatusTool.h
//  Weibo
//
//  Created by jingdongqi on 14-5-2.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Status;
@interface StatusTool : NSObject
// 加载多条微博
+ (void)statusesWithSinceId:(NSString*)sinceId maxId:(NSString*)maxId success:(void(^)(NSMutableArray* statuses))success fail:(void(^)())fail;

// 加载单条微博
+ (void)statusWithId:(NSString *)idstr success:(void (^)(Status *status))success fail:(void (^)())fail;

// 加载评论列表
+ (void)commentsWithId:(NSString *)idstr sinceId:(NSString *)sinceId maxId:(NSString *)maxId success:(void (^)(NSMutableArray *comments, int totalNum, NSString *nextCursor))success fail:(void (^)())fail;

// 加载转发列表
+ (void)repostsWithId:(NSString *)idstr sinceId:(NSString *)sinceId maxId:(NSString *)maxId success:(void (^)(NSMutableArray *comments, int totalNum, NSString *nextCursor))success fail:(void (^)())fail;



@end
