//
//  StatusTool.m
//  Weibo
//
//  Created by jingdongqi on 14-5-2.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import "StatusTool.h"
#import "AccountTool.h"
#import "Account.h"
#import "Status.h"
#import "Comment.h"
// 单条微博
#define kStatusPath @"statuses/show.json"
// 多条微博
#define kStatusesPath @"statuses/friends_timeline.json"
// 多条评论
#define kCommentsPath @"comments/show.json"
// 多条转发
#define kRepostsPath @"statuses/repost_timeline.json"

@implementation StatusTool
+(void)statusesWithSinceId:(NSString *)sinceId maxId:(NSString *)maxId success:(void (^)(NSMutableArray *))success fail:(void (^)())fail
{

    sinceId = sinceId==nil?@"0":sinceId;
    maxId = maxId==nil?@"0":maxId;
    
    
    NSURLRequest *request = [NSURLRequest requestWithPath:kStatusesPath params:@{
                                                                                 @"since_id" : sinceId,
                                                                                 @"max_id" : maxId
                                                                                 }];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSArray *array = JSON[@"statuses"];
        
        // 2.解析数据为模型(每个dict都代表一条微博)
        NSMutableArray *statuses = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            Status *s = [[Status alloc] initWithDict:dict];
            [statuses addObject:s];
        }
        
        // 3.回调
        if (success) {
            success(statuses);
        }

    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        if (fail) {
            fail();
        }

    }];

    
      [operation start];
}



+ (void)statusWithId:(NSString *)idstr success:(void (^)(Status *))success fail:(void (^)())fail
{
    // 创建一个请求对象
    NSURLRequest *request = [NSURLRequest requestWithPath:kStatusPath params:@{
                                                                               @"id" : idstr
                                                                               }];
    
    AFJSONRequestOperation *op = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        if (success) {
            success([[Status alloc] initWithDict:JSON]);
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        if (fail) {
            fail();
        }
    }];
    
    [op start];
}


+ (void)commentsWithId:(NSString *)idstr sinceId:(NSString *)sinceId maxId:(NSString *)maxId success:(void (^)(NSMutableArray *, int, NSString *))success fail:(void (^)())fail {
    sinceId = sinceId==nil?@"0":sinceId;
    maxId = maxId==nil?@"0":maxId;
    
    // 创建一个请求对象
    NSURLRequest *request = [NSURLRequest requestWithPath:kCommentsPath params:@{
                                                                                 @"since_id" : sinceId,
                                                                                 @"max_id" : maxId,
                                                                                 @"id" : idstr
                                                                                 }];
    
    AFJSONRequestOperation *op = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if (success) {
            NSArray *commentsArray = JSON[@"comments"];
            
            NSMutableArray *comments = [NSMutableArray array];
            for (NSDictionary *dict in commentsArray) {
                Comment *c = [[Comment alloc] initWithDict:dict];
                [comments addObject:c];
            }
            
            success(comments, [JSON[@"total_number"] intValue], [JSON[@"next_cursor"] description]);
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        if (fail) {
            fail();
        }
    }];
    
    [op start];
}

+ (void)repostsWithId:(NSString *)idstr sinceId:(NSString *)sinceId maxId:(NSString *)maxId success:(void (^)(NSMutableArray *, int, NSString *))success fail:(void (^)())fail
{
    sinceId = sinceId==nil?@"0":sinceId;
    maxId = maxId==nil?@"0":maxId;
    
    // 创建一个请求对象
    NSURLRequest *request = [NSURLRequest requestWithPath:kRepostsPath params:@{
                                                                                @"since_id" : sinceId,
                                                                                @"max_id" : maxId,
                                                                                @"id" : idstr
                                                                                }];
    
    AFJSONRequestOperation *op = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if (success) {
            NSArray *commentsArray = JSON[@"reposts"];
            
            NSMutableArray *reposts = [NSMutableArray array];
            for (NSDictionary *dict in commentsArray) {
                Status *s = [[Status alloc] initWithDict:dict];
                [reposts addObject:s];
            }
            
            success(reposts, [JSON[@"total_number"] intValue], [JSON[@"next_cursor"] description]);
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        if (fail) {
            fail();
        }
    }];
    
    [op start];
}



@end
