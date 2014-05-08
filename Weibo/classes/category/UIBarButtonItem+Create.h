//
//  UIBarButtonItem+Create.h
//  Weibo
//
//  Created by jingdongqi on 14-5-2.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Create)
+ (UIBarButtonItem*)barButtonItemWithIcon:(NSString*)icon target:(id)target
                                   action:(SEL)action;

+ (UIBarButtonItem*)barButtonItemWIthBg:(NSString*)bg title:(NSString*)title
                                   size:(CGSize)size target:(id)target actoin:(SEL)action;
@end
