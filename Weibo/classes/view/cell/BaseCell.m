//
//  BaseCell.m
//  Weibo
//
//  Created by jingdongqi on 14-5-11.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import "Status.h"
#import <QuartzCore/QuartzCore.h>
#import "User.h"
#import "IconView.h"
#import "StatusImageListView.h"
#import "BaseFrame.h"
#import "BaseCell.h"

@interface BaseCell ()
{

    // 1.头像
    IconView *_icon;
    
    // 2.昵称
    UILabel *_screenName;
    
    // 3.会员皇冠图标
    UIImageView *_mbIcon;
    
    // 4.时间
    UILabel *_time;
    
    // 5.来源
    UILabel *_source;
    
    // 6.正文
    UILabel *_content;
    
    // 7.配图
    StatusImageListView *_image;
    
    
    UILabel *_retweetScreenName;
    
    // 3.正文
    UILabel *_retweetContent;
    
    // 4.配图
    StatusImageListView *_retweetImage;


}
@end

@implementation BaseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBg];
        [self addStatusSubviews];
        [self addRetweetStatusSubviews];

        
    }
    return self;
}

- (void)setBg
{
    UIImageView *bg = [[UIImageView alloc] init];
    bg.image = [UIImage stretchImageWithName:@"common_card_background.png"];
    self.backgroundView = bg;
    
    UIImageView *selectedBg = [[UIImageView alloc] init];
    selectedBg.image = [UIImage stretchImageWithName:@"common_card_background_highlighted.png"];
    self.selectedBackgroundView = selectedBg;

}
- (void)addStatusSubviews
{
    _icon = [[IconView alloc] init];
    _icon.iconViewType = IconViewTypeSmall;
    [self.contentView addSubview:_icon];
    
    
    _screenName = [[UILabel alloc] init];
    _screenName.font = kScreenNameFont;
    _screenName.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_screenName];
    
    _mbIcon = [[UIImageView alloc] init];
    _mbIcon.image = [UIImage imageNamed:@"common_icon_membership.png"];
    [self.contentView addSubview:_mbIcon];
    
    
    _time = [[UILabel alloc] init];
    _time.font = kTimeFont;
    _time.textColor = kTimeColor;
    _time.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_time];
    
    _source = [[UILabel alloc] init];
    _source.textColor = kSourceColor;
    _source.font = kSourceFont;
    _source.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_source];
    
    _content = [[UILabel alloc] init];
    _content.textColor = kContentColor;
    _content.numberOfLines = 0;
    _content.font = kContentFont;
    _content.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_content];
    
    _image = [[StatusImageListView alloc] init];
    _image.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_image];



}

- (void)setFrame:(CGRect)frame
{
    // 更改x、宽度
    frame.origin.x = kTableBorderWidth;
    frame.size.width -= kTableBorderWidth * 2;
    
    // 更改顶部间距、每个cell之间的间距
    frame.origin.y += kTableTopBorderWidth;
    frame.size.height -= kTableViewCellMargin;
    
    [super setFrame:frame];
}


- (void)addRetweetStatusSubviews
{
    _retweet = [[UIImageView alloc] init];
    UIImage *retweetImage = [UIImage imageNamed:@"timeline_retweet_background.png"];
    retweetImage = [retweetImage stretchableImageWithLeftCapWidth:retweetImage.size.width * 0.9 topCapHeight:retweetImage.size.height * 0.5];
    _retweet.image = retweetImage;
    [self.contentView addSubview:_retweet];
    _retweetScreenName = [[UILabel alloc] init];
    _retweetScreenName.textColor = kRetweetScreenNameColor;
    _retweetScreenName.font = kRetweetScreenNameFont;
    _retweetScreenName.backgroundColor = [UIColor clearColor];
    [_retweet addSubview:_retweetScreenName];
   
    _retweetContent = [[UILabel alloc] init];
    _retweetContent.textColor = kRetweetContentColor;
    _retweetContent.font = kRetweetContentFont;
    _retweetContent.numberOfLines = 0;
    _retweetContent.backgroundColor = [UIColor clearColor];
    [_retweet addSubview:_retweetContent];
   
    _retweetImage = [[StatusImageListView alloc] init];
    _retweetImage.contentMode = UIViewContentModeScaleAspectFit;
    [_retweet addSubview:_retweetImage];

}


-(void)setBaseFrame:(BaseFrame *)baseFrame
{
    _baseFrame = baseFrame;
    
    Status *status = baseFrame.status;
    User *user = status.user;
    
    // 1.头像
    _icon.frame = baseFrame.icon;
    _icon.user = user;
    
    // 2.昵称
    _screenName.frame = baseFrame.screenName;
    _screenName.text = user.screenName;
    
    if (user.mbtype == MBTypeNone) {
        // 隐藏会员皇冠
        _mbIcon.hidden = YES;
        _screenName.textColor = kScreenNameColor;
    } else {
        // 显示会员皇冠
        _mbIcon.hidden = NO;
        _screenName.textColor = kMBScreenNameColor;
    }
    
    // 3.会员皇冠图标
    _mbIcon.frame = baseFrame.mbIcon;
    
    // 4.时间
    _time.text = status.createdAt;
    
    /*
     每次重新计算时间和来源的尺寸
     */
    CGFloat timeX = baseFrame.screenName.origin.x;
    CGFloat timeY = CGRectGetMaxY(baseFrame.screenName) + kCellBorderWidth * 0.5;
    CGSize timeSize = [_time.text sizeWithFont:kTimeFont];
    _time.frame = (CGRect){ {timeX, timeY}, timeSize};
    
    // 5.来源
    _source.text = status.source;
    CGFloat sourceX = CGRectGetMaxX(_time.frame) + kCellBorderWidth;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [_source.text sizeWithFont:kSourceFont];
    _source.frame = (CGRect){ {sourceX, sourceY}, sourceSize};
    // 6.正文
    _content.frame = baseFrame.content;
    _content.text = status.text;
    // 7.配图
    if (status.picUrls.count) {
        _image.hidden = NO;
        
        _image.frame = baseFrame.image;
        
        // 设置图片列表数据
        _image.imageUrls = status.picUrls;
    } else {
        _image.hidden = YES;
    }
    
    /*
     被转发微博
     */
    if (status.retweetedStatus) {
        _retweet.hidden = NO;
        
        // 1.被转发微博的整体结构
        _retweet.frame = baseFrame.retweet;
        
        // 2.昵称
        _retweetScreenName.frame = baseFrame.retweetScreenName;
        _retweetScreenName.text = [NSString stringWithFormat:@"@%@", status.retweetedStatus.user.screenName];
        
        // 3.正文
        _retweetContent.frame = baseFrame.retweetContent;
        _retweetContent.text = status.retweetedStatus.text;
        
        // 4.配图
        if (status.retweetedStatus.picUrls.count) {
            _retweetImage.hidden = NO;
            
            _retweetImage.frame = baseFrame.retweetImage;
            _retweetImage.imageUrls = status.retweetedStatus.picUrls;
        } else {
            _retweetImage.hidden = YES;
        }
    } else {
        _retweet.hidden = YES;
    }

}


@end
