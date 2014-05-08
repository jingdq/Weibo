//
//  DockItem.m
//  Weibo
//
//  Created by jingdongqi on 14-5-1.
//  Copyright (c) 2014年 jing. All rights reserved.
//
#define kImageRatio 0.6
#import "DockItem.h"

@implementation DockItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.adjustsImageWhenHighlighted = NO;
        
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar_slider.png"] forState:UIControlStateSelected];
        
        
        
    }
    return self;
}


#pragma mark 重写父类的方法（覆盖父类在高亮时所作的行为）
- (void)setHighlighted:(BOOL)highlighted {}


- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * kImageRatio - 5;
    CGFloat titleHeight = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, contentRect.size.width, titleHeight);

}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{

   return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height * kImageRatio);
}

@end
