//
//  BaseFrame.h
//  Weibo
//
//  Created by jingdongqi on 14-5-11.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Status;
@interface BaseFrame : NSObject
{
    CGFloat _cellHeight;
     CGRect _retweet;
    
}
@property (nonatomic, strong) Status *status;
@property (nonatomic, assign, readonly) CGFloat cellHeight;
// 1.头像
@property (nonatomic, assign, readonly) CGRect icon;
// 2.昵称
@property (nonatomic, assign, readonly) CGRect screenName;
// 3.会员皇冠图标
@property (nonatomic, assign, readonly) CGRect mbIcon;
// 6.正文
@property (nonatomic, assign, readonly) CGRect content;
// 7.配图
@property (nonatomic, assign, readonly) CGRect image;




@property (nonatomic, assign, readonly) CGRect retweet;
// 2.昵称
@property (nonatomic, assign, readonly) CGRect retweetScreenName;
// 3.正文
@property (nonatomic, assign, readonly) CGRect retweetContent;
// 4.配图
@property (nonatomic, assign, readonly) CGRect retweetImage;





@end
