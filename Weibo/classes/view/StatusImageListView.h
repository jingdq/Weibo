//
//  StatusImageListView.h
//  Weibo
//
//  Created by jingdongqi on 14-5-5.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatusImageListView : UIView
@property(nonatomic,strong) NSArray *imageUrls;
+ (CGSize)imageSizeWithCount:(int)count;

@end
