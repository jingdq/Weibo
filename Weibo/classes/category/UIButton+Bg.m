//
//  UIButton+Bg.m
//  Weibo
//
//  Created by jingdongqi on 14-5-1.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import "UIButton+Bg.h"

@implementation UIButton (Bg)
- (CGSize)setAllStateBg:(NSString *)icon
{
  
    UIImage *normal = [UIImage stretchImageWithName:icon];
    UIImage *highlighted = [UIImage stretchImageWithName:[icon filenameAppend:@"_highlighted"]];
    [self setBackgroundImage:normal forState:UIControlStateNormal];
    [self setBackgroundImage:highlighted forState:UIControlStateHighlighted];
    return normal.size;
}
@end
