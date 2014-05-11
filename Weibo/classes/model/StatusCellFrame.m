//
//  StatusCellFrame.m
//  Weibo
//
//  Created by jingdongqi on 14-5-5.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import "StatusCellFrame.h"
#import "Status.h"
#import "User.h"
#import "StatusImageListView.h"
@implementation StatusCellFrame
- (void)setStatus:(Status *)status
{
    [super setStatus:status];
    _cellHeight +=kStatusOptionBarHeight;
   
}

@end
