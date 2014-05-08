//
//  IconView.m
//  Weibo
//
//  Created by jingdongqi on 14-5-6.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import "IconView.h"
#import "User.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+WebCache.h"
@interface IconView ()
{
    UIImageView *_icon;
    UIImageView *_verified;
    NSString *_placehoder;
}
@end


@implementation IconView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _icon = [[UIImageView alloc]init];
        _icon.layer.cornerRadius = 5;
        _icon.layer.masksToBounds = YES;
        [self addSubview:_icon];
    
        _verified = [[UIImageView alloc]init];
        _verified.bounds = CGRectMake(0, 0, kVerifiedWidth, kVerifiedHeight);
        [self addSubview:_verified];
        
        self.iconViewType = IconViewTypeSmall;
    
    }
    return self;
}




-(void)setIconViewType:(IconViewType)iconViewType
{
    _iconViewType = iconViewType;
    
    
    //确定头像的尺寸
    
    CGFloat iconWidth = 0;
    CGFloat iconHeight = 0;
    
    
    switch (iconViewType) {
        case IconViewTypeSmall:
            iconWidth = kIconSmallWidth;
            iconHeight = kIconSmallHeight;
            _placehoder = @"avatar_default_small.png";
            break;
        case IconViewTypeDefault:
            iconWidth = kIconWidth;
            iconHeight = kIconHeight;
            _placehoder = @"avatar_default_big.png";
            
            break;
        case IconViewTypeBig:
            iconWidth = kIconBigWidth;
            iconHeight = kIconBigHeight;
            _placehoder = @"avatar_default_big.png";
            
            
            break;
     
    }

   self.bounds = CGRectMake(0, 0, iconWidth + kVerifiedWidth * 0.5, iconHeight + kVerifiedHeight * 0.5)
    ;
    
    _icon.frame = CGRectMake(0, 0, iconWidth, iconHeight);
    _verified.center = CGPointMake(iconWidth-2, iconHeight-2);


}



-(void)setUser:(User *)user
{
    _user = user;
    
    
    //设置头像
    
    [ _icon setImageWithURL:[NSURL URLWithString:user.profileImageUrl] placeholderImage:[UIImage imageNamed:_placehoder] options:SDWebImageLowPriority|SDWebImageRetryFailed];
    
    //设置认证图标
    
    if (user.verifiedType == VerifiedTypeNone) {
        _verified.hidden = YES;
    }else{
        _verified.hidden = NO;
        
        switch (user.verifiedType) {
            case VerifiedTypeDaren: // 达人
                _verified.image = [UIImage imageNamed:@"avatar_grassroot.png"];
                break;
            case VerifiedTypePersonal: // 个人
                _verified.image = [UIImage imageNamed:@"avatar_vip.png"];
                break;
            default : // 企业
                _verified.image = [UIImage imageNamed:@"avatar_enterprise_vip.png"];
                break;
        }
    }
    
    
}



+ (CGSize)iconViewSizeWithType:(IconViewType)type
{
    
    CGFloat iconWidth = 0;
    CGFloat iconHeight = 0;
    switch (type) {
        case IconViewTypeSmall:
            iconWidth = kIconSmallWidth;
            iconHeight = kIconSmallHeight;
            
            
            break;
            
        case IconViewTypeDefault:
            
            iconWidth = kIconWidth;
            iconHeight = kIconHeight;

            break;
            
        case IconViewTypeBig:
            iconWidth = kIconBigWidth;
            iconHeight = kIconBigHeight;
            break;
            
            
        default:
            break;
    }
    
    
    return CGSizeMake(iconWidth + kVerifiedWidth * 0.5, iconHeight + kVerifiedHeight * 0.5);
}



@end
