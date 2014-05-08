//
//  UIBarButtonItem+Create.m
//  Weibo
//
//  Created by jingdongqi on 14-5-2.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import "UIBarButtonItem+Create.h"

@implementation UIBarButtonItem (Create)

+ (UIBarButtonItem*)barButtonItemWithIcon:(NSString *)icon target:(id)target action:(SEL)action
{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize btnSize=[button setAllStateBg:icon];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    button.bounds=(CGRect){CGPointZero,btnSize};
    return [[UIBarButtonItem alloc]initWithCustomView:button];
    
    
}

+ (UIBarButtonItem*)barButtonItemWIthBg:(NSString *)bg title:(NSString *)title size:(CGSize)size target:(id)target actoin:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    CGSize btnSize = [button setAllStateBg:bg];
    button.bounds = (CGRect){CGPointZero,size};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];

}

@end
