//
//  NewFeatureViewController.m
//  Weibo
//
//  Created by jingdongqi on 14-4-26.
//  Copyright (c) 2014年 jing. All rights reserved.
//
#define kCount 4
#import "NewFeatureViewController.h"

@interface NewFeatureViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIButton *_share;
    UIPageControl *_pageControl;
   
}

@end

@implementation NewFeatureViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
    }
    return self;
}


-(void)loadView{
    
    //1.设置视图控制器的View
    
    
//
    
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = [UIScreen mainScreen].bounds;
    imageView.image = [UIImage fullscreenImageWithName:@"new_feature_background.png"];
    imageView.userInteractionEnabled = YES;
    self.view = imageView;

    CGSize viewSize = self.view.bounds.size;
    
    //2.创建scrollView
    _scrollView = [[UIScrollView alloc]init];
    [_scrollView setPagingEnabled:YES];
    [_scrollView setFrame:self.view.bounds];
    [_scrollView setContentSize:CGSizeMake(kCount*viewSize.width, viewSize.height)];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    [_scrollView setBounces:NO];
    [_scrollView setDelegate:self];
        [self.view addSubview:_scrollView];
    
    
    //3.添加UIImageView
    
    
    for (int i = 0; i<kCount; i++) {
     
        [self addImageViewAtIndex:i inView:_scrollView];
        
    
        
    }
    
   
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, 100, 0)];
    _pageControl.center = CGPointMake(viewSize.width * 0.5, viewSize.height * 0.95);
    _pageControl.numberOfPages = kCount;
    _pageControl.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_point.png"]];
    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_checked_point.png"]];
    _pageControl.userInteractionEnabled = NO;
    [self.view addSubview:_pageControl];
    
    


    
    }



- (void)addImageViewAtIndex:(int)index inView:(UIView*)view
{
    CGSize viewSize = self.view.frame.size;
    
    // 1.创建imageview
    UIImageView *imageView = [[UIImageView alloc] init];

    imageView.frame = (CGRect){{index * viewSize.width,0},viewSize};
    
    NSString *name = [NSString stringWithFormat:@"new_feature_%d.png", index + 1];
    imageView.image = [UIImage fullscreenImageWithName:name];
    if (index == (kCount -1)) {
        [self addBtnInView:imageView];
    }

    [view addSubview:imageView];
    
    
    
 }

- (void)addBtnInView:(UIView*)view
{
    view.userInteractionEnabled = YES;
    CGSize viewSize = view.bounds.size;
  
    UIButton *start = [UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:start];
    
    CGSize startSize = [start setAllStateBg:@"new_feature_finish_button.png"];
    
    start.center = CGPointMake(viewSize.width * 0.5, viewSize.height * 0.85);
    
    start.bounds = (CGRect){CGPointZero, startSize};
    [start addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    UIButton *share = [UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:share];
    // 2.2.设置背景图片
    UIImage *shareNormal = [UIImage imageNamed:@"new_feature_share_false.png"];
    [share setBackgroundImage:shareNormal forState:UIControlStateNormal];
    [share setBackgroundImage:[UIImage imageNamed:@"new_feature_share_true.png"] forState:UIControlStateSelected];
    // 2.3.边框
    share.center = CGPointMake(viewSize.width * 0.5, viewSize.height * 0.75);
    share.bounds = (CGRect){CGPointZero, shareNormal.size};
    // 2.4.监听
    [share addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    // 2.5.高亮状态下不要改变图片颜色
    share.adjustsImageWhenHighlighted = NO;
    // 2.6.默认选中
    share.selected = YES;
    
    _share = share;
}


- (void)share:(UIButton*)btn
{
   btn.selected = ! btn.isSelected;
}

- (void)start
{
    NSLog(@"start >>> ");
    
    if (_startBlock) {
        _startBlock(_share.isSelected);
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageControl.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;

}

@end
