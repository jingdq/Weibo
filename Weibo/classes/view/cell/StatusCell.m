//
//  StatusCell.m
//  Weibo
//
//  Created by jingdongqi on 14-5-5.
//  Copyright (c) 2014年 jing. All rights reserved.
//
#import "StatusCellFrame.h"
#import "StatusCell.h"
#import "Status.h"
#import "User.h"
#import "StatusCellFrame.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+WebCache.h"
#import "StatusImageListView.h"
#import "IconView.h"
#import "StatusOptionBar.h"
@interface StatusCell ()
{
    /*
     微博本身的子控件
     */
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
    
    
    /*
     被转发微博的子控件
     */
    // 1.被转发微博的整体结构
    UIImageView *_retweet;
    
    // 2.昵称
    UILabel *_retweetScreenName;
    
    // 3.正文
    UILabel *_retweetContent;
    
    // 4.配图
    StatusImageListView *_retweetImage;

    
    //操作条
    
    StatusOptionBar *_optionBar;
}
@end

@implementation StatusCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 0.设置背景
        [self setBg];
        
        // 1.添加微博本身的子控件
        [self addStatusSubviews];
        
        // 2.添加被转发微博的子控件
        [self addRetweetStatusSubviews];
        
        // 3.添加其他
        [self addOtherSubviews];

    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark setBackground

- (void)setBg
{
    
    UIImageView *bg = [[UIImageView alloc]init];
    bg.image = [UIImage stretchImageWithName:@"common_card_background.png"];
    self.backgroundView = bg;
    
    UIImageView *selectBg = [[UIImageView alloc]init];
    selectBg.image = [UIImage stretchImageWithName:@"common_card_background_highlighted.png"];
    self.selectedBackgroundView = selectBg;
    
  
}

#pragma mark 1.添加微博本身的子控件
- (void)addStatusSubviews
{
    // 添加头像
    
    _icon = [[IconView alloc]init];

    [self.contentView addSubview:_icon];
    
    // 昵称
    
    _screenName = [[UILabel alloc]init];

    _screenName.font =kScreenNameFont;
    
    _screenName.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:_screenName];
    
    
    
    // 会员皇冠图标
    
    _mbIcon = [[UIImageView alloc]init];
    
    [self.contentView addSubview:_mbIcon];
    // 时间
    
    _time = [[UILabel alloc] init];
    _time.font = kTimeFont;
    _time.textColor = kTimeColor;
    _time.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_time];

    
    // 来源
    _source = [[UILabel alloc] init];
    _source.textColor = kSourceColor;
    _source.font = kSourceFont;
    _source.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_source];
    
    
    //正文
    _content = [[UILabel alloc] init];
    _content.textColor = kContentColor;
    _content.numberOfLines = 0;
    _content.font = kContentFont;
    _content.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_content];

    
    //配图
    
    
    _image = [[StatusImageListView alloc] init];
    
    [self.contentView addSubview:_image];

}

#pragma mark 添加被转发微博的子控件
- (void)addRetweetStatusSubviews
{
 
    
    // 1.被转发微博的整体结构
    _retweet = [[UIImageView alloc] init];
    [self.contentView addSubview:_retweet];
    
    // 2.昵称
    _retweetScreenName = [[UILabel alloc] init];
    _retweetScreenName.textColor = kRetweetScreenNameColor;
    _retweetScreenName.font = kRetweetScreenNameFont;
    _retweetScreenName.backgroundColor = [UIColor clearColor];
    [_retweet addSubview:_retweetScreenName];
    
    // 3.正文
    _retweetContent = [[UILabel alloc] init];
    _retweetContent.textColor = kRetweetContentColor;
    _retweetContent.font = kRetweetContentFont;
    _retweetContent.numberOfLines = 0;
    _retweetContent.backgroundColor = [UIColor clearColor];
    [_retweet addSubview:_retweetContent];
    
    // 4.配图
    _retweetImage = [[StatusImageListView alloc] init];
    [_retweet addSubview:_retweetImage];

  
}


-(void)setFrame:(CGRect)frame
{
    frame.origin.x = kTableBorderWidth;
    frame.size.width-=2*kTableBorderWidth;
    
    
    frame.origin.y+=5;
    frame.size.height-=5;
    
    [super setFrame:frame];
}

#pragma  mark 添加其他

- (void)addOtherSubviews
{
 
    CGFloat height = kStatusOptionBarHeight;
    
    CGFloat y = self.frame.size.height - height;
    
    CGRect frame = CGRectMake(0, y, self.frame.size.width, height);
    
    _optionBar = [[StatusOptionBar alloc]initWithFrame:frame];
//    [_optionBar setStatus:self.statusCellFrame.status];
    _optionBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    [self.contentView addSubview:_optionBar];
    
    
}



- (void)setStatusCellFrame:(StatusCellFrame *)statusCellFrame
{
    _statusCellFrame = statusCellFrame;
    
    Status *status = statusCellFrame.status;
    User *user = status.user;
    
    /*
     微博本身
     */
    // 1.头像
    _icon.frame = statusCellFrame.icon;
    [_icon setUser:user];
    // 2.昵称
    _screenName.frame = statusCellFrame.screenName;
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
    _mbIcon.frame = statusCellFrame.mbIcon;
    _mbIcon.image = [UIImage imageNamed:@"common_icon_membership.png"];
    
    // 4.时间
    _time.frame = statusCellFrame.time;
    _time.text = status.createdAt;
    
    // 5.来源
    _source.frame = statusCellFrame.source;
    _source.text = status.source;
    
    // 6.正文
    _content.frame = statusCellFrame.content;
    _content.text = status.text;
    
    // 7.配图
    _image.frame = statusCellFrame.image;
    NSLog(@"status.picUrls %@",status.picUrls);
    _image.imageUrls = status.picUrls;
    
    /*
     被转发微博
     */
    // 1.被转发微博的整体结构
    
    if (status.retweetedStatus) {
        _retweet.hidden = NO;
        _retweet.frame = statusCellFrame.retweet;
        UIImage *retweetImage = [UIImage imageNamed:@"timeline_retweet_background.png"];
        retweetImage = [retweetImage stretchableImageWithLeftCapWidth:retweetImage.size.width * 0.9 topCapHeight:retweetImage.size.height * 0.5];
        _retweet.image = retweetImage;
        
        // 2.昵称
        _retweetScreenName.frame = statusCellFrame.retweetScreenName;
        _retweetScreenName.text = [NSString stringWithFormat:@"@%@", status.retweetedStatus.user.screenName];
        
        // 3.正文
        _retweetContent.frame = statusCellFrame.retweetContent;
        _retweetContent.text = status.retweetedStatus.text;
        
        // 4.配图
        
        if (status.retweetedStatus.picUrls.count) {
            _retweetImage.hidden = NO;
            _retweetImage.frame = statusCellFrame.retweetImage;
            
            
            _retweetImage.imageUrls = status.retweetedStatus.picUrls;
            
        }else{
          
            _retweetImage.hidden = YES;
            
        }
        
        
    }else{
      _retweet.hidden = YES;
        
     }
   
    _optionBar.status = status;
    
}


@end
