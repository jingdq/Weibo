//
//  StatusDetailViewController.h
//  Weibo
//
//  Created by jingdongqi on 14-5-7.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Status;
@interface StatusDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) Status *status;
@end
