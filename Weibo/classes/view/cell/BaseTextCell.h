//
//  BaseTextCell.h
//  Weibo
//
//  Created by jingdongqi on 14-5-15.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseTextCellFrame;
@interface BaseTextCell : UITableViewCell
@property (nonatomic, strong) BaseTextCellFrame *baseTextCellFrame;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end
