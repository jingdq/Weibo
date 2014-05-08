//
//  NSString+File.m
//  Weibo
//
//  Created by jingdongqi on 14-5-1.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import "NSString+File.h"

@implementation NSString (File)
- (NSString *)filenameAppend:(NSString *)append
{
 
    NSString *filename = [self stringByDeletingPathExtension];
    
    filename = [filename stringByAppendingString:append];
    
    NSString *extension = [self pathExtension];
    
    return [filename stringByAppendingPathExtension:extension];
}
@end
