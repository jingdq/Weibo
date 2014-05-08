//
//  StatusImageListView.m
//  Weibo
//
//  Created by jingdongqi on 14-5-5.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import "StatusImageListView.h"
#import "StatusImageView.h"
#import "UIImageView+WebCache.h"
#define kStatusOneImageWidth 120
#define kStatusOneImageHeight 120

#define kStatusImageWidth 80
#define kStatusImageHeight 80

#define kStatusImageMargin 10

@implementation StatusImageListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        for (int i = 0; i<9; i++) {
            StatusImageView *imageView  = [[StatusImageView alloc]init];
            [self addSubview:imageView];
        }
        
        
    }
    return self;
}

- (void)setImageUrls:(NSArray *)imageUrls
{
    
    
    
    _imageUrls = imageUrls;
    
    int imageCount = imageUrls.count;
    int subCount = self.subviews.count;
    
    // 遍历所有的ImageView
    for (int i = 0; i<subCount;  i++) {
        // 1.取出i位置对应的图片控件
        StatusImageView *child = self.subviews[i];
        
        // 2.i位置对应的图片控件 没有 图片
        if (i >= imageCount) {
            child.hidden = YES;
        } else {
            child.hidden = NO;
            
            // 只有一张配图
            if (imageCount == 1) {
                child.frame = CGRectMake(0, 0, kStatusOneImageWidth, kStatusOneImageHeight);
                
                child.contentMode = UIViewContentModeScaleAspectFit;
            } else {
                // 3.设置frame
                // 列数
                int divisor = (imageCount == 4)?2:3;
                
                int column = i%divisor;
                // 行数
                int row = i/divisor;
                // 很据列数和行数算出x、y
                int childX = column * (kStatusImageWidth + kStatusImageMargin);
                int childY = row * (kStatusImageHeight + kStatusImageMargin);
                child.frame = CGRectMake(childX, childY, kStatusImageWidth, kStatusImageHeight);
                
                child.contentMode = UIViewContentModeScaleToFill;
            }
            
            // 4.设置图片url
            child.url = imageUrls[i][@"thumbnail_pic"];
        }
    }
    
}


+ (CGSize)imageSizeWithCount:(int)count
{

    
    if (count == 1) {
        return CGSizeMake(kStatusOneImageWidth, kStatusOneImageHeight);
    }else{
        
        // 1.总行数
        int rows = (count + 2)/3;
        
        // 2.总高度
        CGFloat height = rows * kStatusImageHeight + (rows - 1) * kStatusImageMargin;
        
        // 3.总列数
        int columns = (count>=3) ? 3 : count;
        
        // 4.总宽度
        CGFloat width = columns * kStatusImageWidth + (columns - 1) * kStatusImageMargin;
        
        return CGSizeMake(width, height);
        
    }
   
    
}


@end
