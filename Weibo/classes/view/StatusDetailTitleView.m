//
//  StatusDetailTitleView.m
//  Weibo
//
//  Created by jingdongqi on 14-5-14.
//  Copyright (c) 2014年 jing. All rights reserved.
//
#import "Status.h"
#import "StatusDetailTitleView.h"
#define kBtnWidth 80
@interface StatusDetailTitleView()
{
    UIImageView *_bg;
    UIButton *_selectionBtn;
    UIImageView *_indicator;
    
    
    UIButton *_repost;
    UIButton *_comment;
    UIButton *_attitude;


}

@end

@implementation StatusDetailTitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = kGlobalBg;
        _bg = [[UIImageView alloc] init];
        _bg.userInteractionEnabled = YES;
        _bg.image = [UIImage stretchImageWithName:@"statusdetail_comment_top_background.png"];
        CGFloat bgX = kTableBorderWidth;
        CGFloat bgY = 10;
        CGFloat bgWidth = frame.size.width - 2 * bgX;
        CGFloat bgHeight = frame.size.height - bgY;
        _bg.frame = CGRectMake(bgX, bgY, bgWidth, bgHeight);
        [self addSubview:_bg];
        
        _indicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"statusdetail_comment_top_arrow.png"]];
        _indicator.center = CGPointMake(0, _bg.frame.size.height - _indicator.frame.size.height * 0.5);
        [_bg addSubview:_indicator];
         [self addBtns];

        UIImage *image = [UIImage imageNamed:@"statusdetail_comment_top_rule.png"];
        UIImageView *divider = [[UIImageView alloc] initWithImage:image];
        divider.center = CGPointMake(kBtnWidth, _bg.frame.size.height * 0.5);
        [_bg addSubview:divider];

    }
    return self;
}


- (void)addBtns
{
    // 1.转发
    _repost = [self addBtnWithTitle:@"转发" x:0];
    
    // 2.评论
    _comment = [self addBtnWithTitle:@"评论" x:kBtnWidth];
    [self btnClick:_comment];
    
    // 3.赞
    _attitude = [self addBtnWithTitle:@"赞" x:_bg.frame.size.width - kBtnWidth];
    _attitude.enabled = NO;
}

- (UIButton *)addBtnWithTitle:(NSString *)title x:(CGFloat)x
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 文字颜色
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    // 宽高
    btn.frame = CGRectMake(x, 0, kBtnWidth, _bg.frame.size.height);
    
    [btn setTitle:title forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    [_bg addSubview:btn];
    
    return btn;
}
- (void)setBtn:(UIButton *)btn placeholder:(NSString *)placeholder count:(int)count
{
    if (count == 0) {
        [btn setTitle:@"0" forState:UIControlStateNormal];
    } else if (count%10000 == 0) { // 整万
        NSString *title = [NSString stringWithFormat:@"%d万", count/10000];
        [btn setTitle:title forState:UIControlStateNormal];
    } else { // 非整万
        double result = (count / 1000) * 0.1;
        
        NSString *title = nil;
        if (((int)result) == 0) { // 不超过1W
            title = [NSString stringWithFormat:@"%d", count];
        } else { // 超过1W
            title = [NSString stringWithFormat:@"%.1f万", result];
        }
        [btn setTitle:title forState:UIControlStateNormal];
    }
    
    
    NSString *title = [btn titleForState:UIControlStateNormal];
    title = [title stringByAppendingFormat:@" %@", placeholder];
    [btn setTitle:title forState:UIControlStateNormal];
}

- (void)setStatus:(Status *)status
{
    _status = status;
    
    [self setBtn:_repost placeholder:@"转发" count:status.repostsCount];
    [self setBtn:_comment placeholder:@"评论" count:status.commentsCount];
    [self setBtn:_attitude placeholder:@"赞" count:status.attitudesCount];
}

- (void)btnClick:(UIButton *)btn
{
    _selectionBtn.selected = NO;
    btn.selected = YES;
    _selectionBtn = btn;
    
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint center = _indicator.center;
        center.x = btn.center.x;
        _indicator.center = center;
    }];
    
    

}

@end
