//
//  NSURLRequest+Url.m
//  Weibo
//
//  Created by jingdongqi on 14-5-2.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import "NSURLRequest+Url.h"
#import "AccountTool.h"
#import "Account.h"
@implementation NSURLRequest (Url)
+ (NSURLRequest*)requestWithPath:(NSString *)path params:(NSDictionary *)params
{
    NSMutableString *urlStr = [NSMutableString stringWithFormat:@"%@%@",kBaseURL,path];
    
    if (params) {
        [urlStr appendString:@"?"];
        
        [urlStr appendFormat:@"%@=%@", kAccessToken, [AccountTool sharedAccountTool].currentAccount.accessToken];
        
        [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [urlStr appendFormat:@"&%@=%@",key,obj];
        }];
       
    }
    
    
    
    return [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
}
@end
