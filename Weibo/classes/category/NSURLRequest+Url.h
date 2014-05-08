//
//  NSURLRequest+Url.h
//  Weibo
//
//  Created by jingdongqi on 14-5-2.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (Url)
+ (NSURLRequest*)requestWithPath:(NSString*)path params:(NSDictionary*)params;
@end
