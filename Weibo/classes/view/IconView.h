//
//  IconView.h
//  Weibo
//
//  Created by jingdongqi on 14-5-6.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class User;

typedef enum {
  IconViewTypeSmall  = 0,
  IconViewTypeDefault,
    IconViewTypeBig
 
}IconViewType;
@interface IconView : UIView

@property(nonatomic,strong) User *user;
@property(nonatomic,assign)IconViewType iconViewType;




//根据头像类型 返回头像尺寸

+(CGSize)iconViewSizeWithType:(IconViewType)type;

@end
