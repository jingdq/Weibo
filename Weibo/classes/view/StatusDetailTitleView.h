//
//  StatusDetailTitleView.h
//  Weibo
//
//  Created by jingdongqi on 14-5-14.
//  Copyright (c) 2014年 jing. All rights reserved.
//
typedef enum {
    TitleViewBtnTypeComment,
    TitleViewBtnTypeRepost,
    TitleViewBtnTypeAttitude
} TitleViewBtnType;
#import <UIKit/UIKit.h>
@class Status;
@interface StatusDetailTitleView : UIView
@property(nonatomic,strong)Status *status;
@property(nonatomic,assign,readonly)TitleViewBtnType type;
@property(nonatomic,copy) void(^btnClickBlock)();

@end
