//
//  Dock.h
//  Weibo
//
//  Created by jingdongqi on 14-5-1.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Dock : UIView
@property(nonatomic,copy)void(^itemClickBlock)(int index);
@property(nonatomic,assign) int selectedIndex;
-(void)addDockItemWithIcon:(NSString*)icon title:(NSString*)title;
@end
