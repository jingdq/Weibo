//
//  AccountTool.h
//  Weibo
//
//  Created by jingdongqi on 14-5-2.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@class Account;
@interface AccountTool : NSObject
singleton_interface(AccountTool)
@property(nonatomic,strong,readonly)Account *currentAccount;
- (void)addAccount:(Account *)account;

@end
