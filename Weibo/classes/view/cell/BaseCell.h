//
//  BaseCell.h
//  Weibo
//
//  Created by jingdongqi on 14-5-11.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseFrame;
@interface BaseCell : UITableViewCell
{
    UIImageView *_retweet;
    BaseFrame *_baseFrame;
}
@property (nonatomic, strong) BaseFrame *baseFrame;
@end
