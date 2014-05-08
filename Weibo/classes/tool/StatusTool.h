//
//  StatusTool.h
//  Weibo
//
//  Created by jingdongqi on 14-5-2.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatusTool : NSObject

+ (void)statusesWithSinceId:(NSString*)sinceId maxId:(NSString*)maxId success:(void(^)(NSMutableArray* statuses))success fail:(void(^)())fail;



@end
