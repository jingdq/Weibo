//
//  BaseTextCell.m
//  Weibo
//
//  Created by jingdongqi on 14-5-15.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import "BaseTextCell.h"
#import "IconView.h"
#import "BaseTextCellFrame.h"
#import "BaseTextModel.h"
#import "User.h"
@interface BaseTextCell()
{
    // 1.头像
    IconView *_icon;
    
    // 2.昵称
    UILabel *_screenName;
    
    // 3.会员皇冠图标
    UIImageView *_mbIcon;
    
    // 4.时间
    UILabel *_time;
    
    // 5.正文
    UILabel *_content;
    
    // 6.背景
    UIImageView *_bg;
    UIImageView *_selectedBg;

}
@end
@implementation BaseTextCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubviews];
        [self setBg];
    }
    return self;
}
- (void)addSubviews
{
    // 1.头像
    _icon = [[IconView alloc] init];
    _icon.iconViewType = IconViewTypeSmall;
    [self.contentView addSubview:_icon];
    
    // 2.昵称
    _screenName = [[UILabel alloc] init];
    _screenName.font = kScreenNameFont;
    _screenName.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_screenName];
    
    // 3.会员皇冠图标
    _mbIcon = [[UIImageView alloc] init];
    _mbIcon.image = [UIImage imageNamed:@"common_icon_membership.png"];
    [self.contentView addSubview:_mbIcon];
    
    // 4.时间
    _time = [[UILabel alloc] init];
    _time.font = kTimeFont;
    _time.textColor = kTimeColor;
    _time.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_time];
    
    // 5.正文
    _content = [[UILabel alloc] init];
    _content.textColor = kContentColor;
    _content.numberOfLines = 0;
    _content.font = kContentFont;
    _content.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_content];
}

- (void)setBg
{
    // 1.默认的背景
    _bg = [[UIImageView alloc] init];
    self.backgroundView = _bg;
    
    // 2.选中的背景
    _selectedBg = [[UIImageView alloc] init];
    self.selectedBackgroundView = _selectedBg;
}

- (void)setBaseTextCellFrame:(BaseTextCellFrame *)baseTextCellFrame
{
    _baseTextCellFrame = baseTextCellFrame;
    
    BaseTextModel *textModel = baseTextCellFrame.baseTextModel;
    User *user = textModel.user;
    
    // 1.头像
    _icon.frame = baseTextCellFrame.icon;
    _icon.user = user;
    
    // 2.昵称
    _screenName.frame = baseTextCellFrame.screenName;
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
    _mbIcon.frame = baseTextCellFrame.mbIcon;
    
    // 4.时间
    _time.frame = baseTextCellFrame.time;
    _time.text = textModel.createdAt;
    
    // 5.正文
    _content.frame = baseTextCellFrame.content;
    _content.text = textModel.text;
}

- (void)setFrame:(CGRect)frame
{
    // 更改x、宽度
    frame.origin.x = kTableBorderWidth;
    frame.size.width -= kTableBorderWidth * 2;
    
    [super setFrame:frame];
}


@end
