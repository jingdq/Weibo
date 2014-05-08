//
//  UIImage+Image.m
//  Weibo
//
//  Created by jingdongqi on 14-5-1.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)

+ (UIImage *)fullscreenImageWithName:(NSString *)name
{
    if (iPhone5) {
        
        name = [name filenameAppend:@"-568h@2x"];
    }
  
    return [UIImage imageNamed:name];

}



+ (UIImage *)stretchImageWithName:(NSString *)name
{

    UIImage *image = [UIImage imageNamed:name];
    
   
    
    return [image stretchableImageWithLeftCapWidth:image.size.width *0.5 topCapHeight:image.size.height*0.5];
    
    
}

@end
