//
//  StatusDetailViewController.m
//  Weibo
//
//  Created by jingdongqi on 14-5-7.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import "StatusDetailViewController.h"
#import "MJRefresh.h"
#define kOptionHeight 44

@interface StatusDetailViewController ()<MJRefreshBaseViewDelegate>
{
    UITableView *_tableView;
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
}
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
    self.view.backgroundColor = kGlobalBg;

    [self createSubviews];
    
    
    
}


- (void)createSubviews
{
    CGSize size = self.view.frame.size;
  
    
    _tableView = [[UITableView alloc]init];
    _tableView.frame =CGRectMake(0, 0, size.width,size.height - kOptionHeight );
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = kGlobalBg;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_tableView];
    
    
    
    UIImageView *option = [[UIImageView alloc]init];
    option.image = [UIImage stretchImageWithName:@"toolbar_background.png"];
    option.frame = CGRectMake(0, size.height - kOptionHeight, size.width,kOptionHeight );
    option.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:option];
    
    _header = [[MJRefreshHeaderView alloc]init];
    _header.scrollView = _tableView;
    _header.delegate = self;
    _footer = [[MJRefreshFooterView alloc]init];
    _footer.scrollView = _tableView;
    _footer.delegate = self;
    
}



#pragma mark TableView DataSource Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return 0;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
  
    return cell;
}


#pragma mark MJRefresh Delegate

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
 

}

@end
