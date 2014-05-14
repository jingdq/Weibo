//
//  StatusDetailViewController.m
//  Weibo
//
//  Created by jingdongqi on 14-5-7.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import "StatusDetailTitleView.h"
#import "MJRefresh.h"
#import "StatusDetailCell.h"
#import "StatusDetailCellFrame.h"
#import "StatusDetailViewController.h"
#define kOptionHeight 44
#define kTitleViewHeiht 50
@interface StatusDetailViewController ()<MJRefreshBaseViewDelegate>
{
    UITableView *_tableView;
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    StatusDetailTitleView *_titleView;
    StatusDetailCellFrame *_statusFrame;
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
    _statusFrame = [[StatusDetailCellFrame alloc] init];
    _statusFrame.status = _status;
    
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
    if (section == 0) {
        return 1;
    }
    return 20;

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    
    if (indexPath.section == 0) {
        
        static NSString *id1 = @"StatusDetailCell";
        StatusDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:id1];
        if (cell == nil) {
            cell = [[StatusDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:id1];
        }
        
        cell.baseFrame = _statusFrame;
        
        return cell;

        
        
    }else {
     
        static NSString *cellID = @"cellID";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.textLabel.text = @"4324234324";

         return cell;
    
    }
    
    
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if (indexPath.section == 0) {
        return _statusFrame.cellHeight;
    }else{
        return 44;
    }
    
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        if (_titleView == nil) {
            CGRect frame = CGRectMake(0, 0, tableView.frame.size.width, kTitleViewHeiht);
            _titleView = [[StatusDetailTitleView alloc]initWithFrame:frame];
            _titleView.status = _status;
        }
    }
 
    return _titleView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return kTitleViewHeiht;
    }
    return 0;
}

#pragma mark MJRefresh Delegate

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
 

}



-(void)dealloc
{

    [_header free];
    [_footer free];
    
}


@end
