//
//  BaseFrame.m
//  Weibo
//
//  Created by jingdongqi on 14-5-11.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import "BaseFrame.h"
#import "Status.h"
#import "IconView.h"
#import "StatusImageListView.h"
#import "User.h"

@implementation BaseFrame
-(void)setStatus:(Status *)status
{
    _status = status;
    
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width - 2 * kTableBorderWidth;

    
    CGFloat iconX = kCellBorderWidth;
    CGFloat iconY = kCellBorderWidth;
    
     _icon = (CGRect){{iconX, iconY},  [IconView iconViewSizeWithType:IconViewTypeSmall]};
    CGFloat screenNameX = CGRectGetMaxX(_icon) + kCellBorderWidth;
    CGFloat screenNameY = iconY;
    CGSize screenNameSize = [status.user.screenName sizeWithFont:kScreenNameFont];
    _screenName = (CGRect){ {screenNameX, screenNameY}, screenNameSize};
 
    CGFloat mbIconX = CGRectGetMaxX(_screenName) + kCellBorderWidth;
    CGFloat mbIconY = CGRectGetMidY(_screenName) - kMBIconHeight * 0.5;
    _mbIcon = CGRectMake(mbIconX, mbIconY, kMBIconWidth, kMBIconHeight);

    CGFloat contentX = iconX;
    CGFloat contentY = CGRectGetMaxY(_icon) + kCellBorderWidth;
    CGFloat contentMaxWdith = cellWidth - 2 * kCellBorderWidth;
    CGSize contentSize = [status.text sizeWithFont:kContentFont constrainedToSize:CGSizeMake(contentMaxWdith, MAXFLOAT)];
    _content = (CGRect){ {contentX, contentY}, contentSize};

    if (status.picUrls.count) {
        CGFloat imageX = contentX;
        CGFloat imageY = CGRectGetMaxY(_content) + kCellBorderWidth;
        
        CGSize imageSize = [StatusImageListView imageSizeWithCount:status.picUrls.count];
        
        _image = (CGRect){{imageX, imageY}, imageSize};
    }

    if (status.retweetedStatus) {
        CGFloat retweetX = contentX;
        CGFloat retweetY = CGRectGetMaxY(_content) + kCellBorderWidth;
        CGFloat retweetWidth = cellWidth - 2 * kCellBorderWidth;
        CGFloat retweetHeight = kCellBorderWidth;
        
        // 1.昵称
        CGFloat retweetScreenNameX = kCellBorderWidth;
        CGFloat retweetScreenNameY = kCellBorderWidth;
        NSString *retweetScreenName = [NSString stringWithFormat:@"@%@", status.retweetedStatus.user.screenName];
        CGSize retweetScreenNameSize = [retweetScreenName sizeWithFont:kRetweetScreenNameFont];
        _retweetScreenName = (CGRect){ {retweetScreenNameX, retweetScreenNameY}, retweetScreenNameSize};
        
        // 2.文本
        CGFloat retweetContentX = retweetScreenNameX;
        CGFloat retweetContentY = CGRectGetMaxY(_retweetScreenName) + kCellBorderWidth;
        CGFloat retweetContentMaxWidth = retweetWidth - 2 * kCellBorderWidth;
        CGSize retweetContentSize = [status.retweetedStatus.text sizeWithFont:kRetweetContentFont constrainedToSize:CGSizeMake(retweetContentMaxWidth, MAXFLOAT)];
        
        _retweetContent = (CGRect){ {retweetContentX, retweetContentY}, retweetContentSize};
        
        // 3.配图
        if (status.retweetedStatus.picUrls.count) {
            CGFloat retweetImageX = retweetContentX;
            CGFloat retweetImageY = CGRectGetMaxY(_retweetContent) + kCellBorderWidth;
            CGSize imageSize = [StatusImageListView imageSizeWithCount:status.retweetedStatus.picUrls.count];
            
            _retweetImage = (CGRect){{retweetImageX, retweetImageY}, imageSize};
            
            retweetHeight += CGRectGetMaxY(_retweetImage);
        } else { // 没有配图
            retweetHeight += CGRectGetMaxY(_retweetContent);
        }
        
        // 4.被转发微博总体的高度
        _retweet = CGRectMake(retweetX, retweetY, retweetWidth, retweetHeight);
    
    }
    
    _cellHeight = kCellBorderWidth + kTableViewCellMargin;
    if (status.retweetedStatus) { // 有转发
        _cellHeight += CGRectGetMaxY(_retweet);
    } else if (status.picUrls.count) { // 有配图
        _cellHeight += CGRectGetMaxY(_image);
    } else { // 只有文本
        _cellHeight += CGRectGetMaxY(_content);
    }


}
@end
