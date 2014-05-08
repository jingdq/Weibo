//
//  Account.m
//  Weibo
//
//  Created by jingdongqi on 14-5-2.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import "Account.h"

@implementation Account


- (id)initWithCoder:(NSCoder*)decoder
{
  
    if (self = [super init]) {
        self.accessToken = [decoder decodeObjectForKey:kAccessToken];
        self.uid = [decoder decodeObjectForKey:KUid];
        self.screenName = [decoder decodeObjectForKey:@"screen_name"];
    }
    
    
    return self;
}



- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.accessToken forKey:kAccessToken];
    [encoder encodeObject:self.uid forKey:KUid];
    [encoder encodeObject:self.screenName forKey:@"screen_name"];
}

@end
