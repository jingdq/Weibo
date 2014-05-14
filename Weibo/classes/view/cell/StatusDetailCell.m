//
//  StatusDetailCell.m
//  Weibo
//
//  Created by jingdongqi on 14-5-11.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import "StatusDetailCell.h"
#import "StatusRetweetOptionBar.h"
#import "MainViewController.h"
#import "StatusDetailViewController.h"
#import "BaseFrame.h"
#import "Status.h"

@interface StatusDetailCell ()
{
 StatusRetweetOptionBar *_option;
}
@end
@implementation StatusDetailCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
         [self addOption];
        
        _retweet.userInteractionEnabled = YES;
        [_retweet addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(retweetClick)]];
        
    }
    return self;
}



//- (void)setFrame:(CGRect)frame
//{
//    [super setFrame:frame];
//    _option.status = baseFrame.status.retweetedStatus;
//}

-(void)setBaseFrame:(BaseFrame *)baseFrame
{
    [super setBaseFrame:baseFrame];
    
    _option.status = baseFrame.status.retweetedStatus;
}


- (void)addOption
{
    CGFloat retweetWidth = [UIScreen mainScreen].bounds.size.width - 2 * (kTableBorderWidth + kTableViewCellMargin);
    
    // 添加操作条
    CGFloat optionHeight = kStatusOptionBarHeight;
    CGFloat optionWidth = 200;
    CGFloat optionY = _retweet.frame.size.height - optionHeight;
    CGFloat optionX = retweetWidth - optionWidth - 20;
    CGRect frame = CGRectMake(optionX, optionY, optionWidth, optionHeight);
    _option = [[StatusRetweetOptionBar alloc] initWithFrame:frame];
    _option.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [_retweet addSubview:_option];
}



- (void)retweetClick
{
  

}



@end
