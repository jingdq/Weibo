//
//  StatusCell.m
//  Weibo
//
//  Created by jingdongqi on 14-5-5.
//  Copyright (c) 2014年 jing. All rights reserved.
//
#import "StatusCellFrame.h"
#import "StatusCell.h"
#import "Status.h"
#import "User.h"
#import "StatusCellFrame.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+WebCache.h"
#import "StatusImageListView.h"
#import "IconView.h"
#import "StatusOptionBar.h"
@interface StatusCell ()
{
   StatusOptionBar *_option;
}
@end

@implementation StatusCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       [self addOtherSubviews];
    }
    return self;
}


- (void)setBaseFrame:(BaseFrame *)baseFrame
{
    [super setBaseFrame:baseFrame];
    
    _option.status = baseFrame.status;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    [self unHighlightSubviews:self.contentView];

   
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted) {
        [self unHighlightSubviews:self.contentView];
    }

}

- (void)unHighlightSubviews:(UIView *)parent
{
    NSArray *views = parent.subviews;
    
    for (UIButton *child in views) {
        if ([child respondsToSelector:@selector(setHighlighted:)]) {
            child.highlighted = NO;
        }
        
        [self unHighlightSubviews:child];
    }
}

- (void)addOtherSubviews
{

    CGFloat height = kStatusOptionBarHeight;
    CGFloat y = self.frame.size.height - height;
    CGRect frame = CGRectMake(0, y, self.frame.size.width, height);
    _option = [[StatusOptionBar alloc] initWithFrame:frame];
    _option.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
     [self.contentView addSubview:_option];


}








@end
