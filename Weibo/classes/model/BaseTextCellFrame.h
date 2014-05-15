//
//  BaseTextCellFrame.h
//  Weibo
//
//  Created by jingdongqi on 14-5-14.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BaseTextModel;
@interface BaseTextCellFrame : NSObject
@property (nonatomic, strong) BaseTextModel *baseTextModel;

/*
 cell的高度
 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

/*
 微博本身所有子控件的frame
 */
// 1.头像
@property (nonatomic, assign, readonly) CGRect icon;
// 2.昵称
@property (nonatomic, assign, readonly) CGRect screenName;
// 3.会员皇冠图标
@property (nonatomic, assign, readonly) CGRect mbIcon;
// 4.正文
@property (nonatomic, assign, readonly) CGRect content;
// 5.时间
@property (nonatomic, assign, readonly) CGRect time;

@end
