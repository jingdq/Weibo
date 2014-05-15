//
//  BaseTextCellFrame.m
//  Weibo
//
//  Created by jingdongqi on 14-5-14.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import "BaseTextCellFrame.h"
#import "BaseTextModel.h"
#import "IconView.h"
#import "User.h"
@implementation BaseTextCellFrame
- (void)setBaseTextModel:(BaseTextModel *)baseTextModel
{
    _baseTextModel = baseTextModel;
    
    // 一个cell的宽度
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width - 2 * kTableBorderWidth;
    
    /*
     微博本身的子控件
     */
    // 1.头像
    CGFloat iconX = kCellBorderWidth;
    CGFloat iconY = kCellBorderWidth;
    _icon = (CGRect){{iconX, iconY},  [IconView iconViewSizeWithType:IconViewTypeSmall]};
    
    // 2.昵称
    CGFloat screenNameX = CGRectGetMaxX(_icon) + kCellBorderWidth;
    CGFloat screenNameY = iconY;
    CGSize screenNameSize = [baseTextModel.user.screenName sizeWithFont:kScreenNameFont];
    _screenName = (CGRect){ {screenNameX, screenNameY}, screenNameSize};
    
    // 3.会员图标
    CGFloat mbIconX = CGRectGetMaxX(_screenName) + kCellBorderWidth;
    CGFloat mbIconY = CGRectGetMidY(_screenName) - kMBIconHeight * 0.5;
    _mbIcon = CGRectMake(mbIconX, mbIconY, kMBIconWidth, kMBIconHeight);
    
    // 6.正文
    CGFloat contentX = screenNameX;
    CGFloat contentY = CGRectGetMaxY(_screenName) + kCellBorderWidth;
    CGFloat contentMaxWdith = cellWidth - kCellBorderWidth - contentX;
    CGSize contentSize = [baseTextModel.text sizeWithFont:kContentFont constrainedToSize:CGSizeMake(contentMaxWdith, MAXFLOAT)];
    _content = (CGRect){ {contentX, contentY}, contentSize};
    
    // 7.时间
    CGFloat timeX = contentX;
    CGFloat timeY = CGRectGetMaxY(_content) + kCellBorderWidth;
    // lineHeight 使用这种字体显示出来的文字，一行有多高
    _time = CGRectMake(timeX, timeY, 200, kTimeFont.lineHeight);
    
    // 8.整个cell的高度
    _cellHeight = CGRectGetMaxY(_time) + kCellBorderWidth;
}

@end
