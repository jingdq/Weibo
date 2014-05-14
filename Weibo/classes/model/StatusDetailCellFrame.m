//
//  StatusDetailCellFrame.m
//  Weibo
//
//  Created by jingdongqi on 14-5-11.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import "StatusDetailCellFrame.h"
#import "Status.h"
@implementation StatusDetailCellFrame

-(void)setStatus:(Status *)status
{
  
    [super setStatus:status];
    if (status.retweetedStatus) {
        _retweet.size.height += kStatusOptionBarHeight;
        _cellHeight += kStatusOptionBarHeight;
    }
}

@end
