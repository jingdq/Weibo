//
//  StatusImageView.m
//  Weibo
//
//  Created by jingdongqi on 14-5-5.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import "StatusImageView.h"
#import "UIImageView+WebCache.h"
@implementation StatusImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setUrl:(NSString *)url
{
    _url = url;
    
    [self setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder.png"] options:SDWebImageLowPriority | SDWebImageRetryFailed];

}

@end
