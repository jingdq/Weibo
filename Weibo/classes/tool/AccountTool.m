//
//  AccountTool.m
//  Weibo
//
//  Created by jingdongqi on 14-5-2.
//  Copyright (c) 2014年 jing. All rights reserved.
//


#define kFileName @"/accounts.data"
#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:kFileName]
#define kCurrentName @"/currentAccount.data"
#define kCurrentFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:kCurrentName]

#import "AccountTool.h"

@interface AccountTool()
{
    NSMutableArray *_accouts;
}
@end

@implementation AccountTool
singleton_implementation(AccountTool)
- (id)init
{
    if (self = [super init]) {
        
        _accouts = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
        _currentAccount = [NSKeyedUnarchiver unarchiveObjectWithFile:kCurrentFilePath];
        if (_accouts == nil) {
            _accouts = [NSMutableArray array];
            
        }
    
    }
    
    
    return self;

}


- (void)addAccount:(Account *)account
{
    [_accouts addObject:account];
    
    _currentAccount = account;
    
    [NSKeyedArchiver archiveRootObject:_accouts toFile:kFilePath];
    [NSKeyedArchiver archiveRootObject:_currentAccount toFile:kCurrentFilePath];

}


@end
