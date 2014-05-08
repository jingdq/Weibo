//
//  StatusDetailViewController.m
//  Weibo
//
//  Created by jingdongqi on 14-5-7.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import "StatusDetailViewController.h"

@interface StatusDetailViewController ()

@end

@implementation StatusDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"微博正文";
    
    // 2.背景颜色
    self.view.backgroundColor = kGlobalBg;}


@end
