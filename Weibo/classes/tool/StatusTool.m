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
#define kStatusesPath @"statuses/friends_timeline.json"

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

@end
