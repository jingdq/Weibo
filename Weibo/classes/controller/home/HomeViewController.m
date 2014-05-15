//
//  HomeViewController.m
//  Weibo
//
//  Created by jingdongqi on 14-5-1.
//  Copyright (c) 2014年 jing. All rights reserved.
//
#import "UIImageView+WebCache.h"
#import "HomeViewController.h"
#import "SendStatusViewController.h"
#import "Status.h"
#import "StatusTool.h"
#import "MJRefresh.h"
#import "StatusCell.h"
#import "User.h"
#import "StatusCellFrame.h"
#import "StatusDetailViewController.h"


@interface HomeViewController ()<MJRefreshBaseViewDelegate>
{
//    NSMutableArray *_statuses;
    
    
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    
    
    NSMutableArray *_statusCellFrames;
    
    
    MBProgressHUD *_hud;
}
@end

@implementation HomeViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"主页";
    
    _statusCellFrames = [NSMutableArray array];
    //刷新 跟加载更多
    
    _header = [[MJRefreshHeaderView alloc]init];
    _header.delegate = self;
    _header.scrollView = self.tableView;
    
  
    
    
    _footer = [[MJRefreshFooterView alloc]init];
    _footer.delegate = self;
    _footer.scrollView = self.tableView;
    
      [_header beginRefreshing];
    
//    _statuses = [NSMutableArray array];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithIcon:@"navigationbar_compose.png" target:self action:@selector(sendStatus)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithIcon:@"navigationbar_pop.png" target:self action:@selector(popMenu)];
    
    
    self.tableView.backgroundColor = kGlobalBg;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}


- (void)sendStatus
{
    SendStatusViewController *send = [[SendStatusViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:send];
    [self presentViewController:nav animated:YES completion:nil];

}

- (void)popMenu
{
 

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [_statusCellFrames count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    
    StatusCellFrame *frame = _statusCellFrames[indexPath.row];
    
    return frame.cellHeight;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *cellId = @"cellId";
    
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell ) {
        cell = [[StatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }


    cell.baseFrame = _statusCellFrames[indexPath.row];
    
    return cell;
    
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 

    StatusDetailViewController *detail = [[StatusDetailViewController alloc] init];
    
    StatusCellFrame *frame = _statusCellFrames[indexPath.row];
    detail.status = frame.status;
    
    [self.navigationController pushViewController:detail animated:YES];
    
}

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView == _header) {
        NSLog(@"下拉刷新>>>>");
        
        
        [self refreshData];
        
    }else{
        NSLog(@"加载更多>>>");
        [self loadMoreData];
    }

}

#pragma mark 下拉动作
-(void)refreshData
{
    NSString *sinceId = nil;
    

    
    if (_statusCellFrames.count) {
        StatusCellFrame *firstStatusCellFrame = _statusCellFrames[0];
        Status *first = firstStatusCellFrame.status;
        sinceId = first.idstr;
    }
    
    
    [StatusTool statusesWithSinceId:sinceId maxId:nil success:^(NSMutableArray *statuses) {
        
        [self showNewStatusCount:statuses.count];
       
        // 计算所有新微博的frame
        NSMutableArray *newFrames = [NSMutableArray array];
        for (Status *s in statuses) {
            StatusCellFrame *frame = [[StatusCellFrame alloc] init];
            frame.status = s;
            [newFrames addObject:frame];
        }
        
        // 1.将旧数据添加到新数据的最后面
        [newFrames addObjectsFromArray:_statusCellFrames];
        _statusCellFrames = newFrames;
              [self.tableView reloadData];
        [_header endRefreshing];
    } fail:^{
        [_header endRefreshing];
    }];

}

#pragma mark 上拉动作

-(void)loadMoreData
{
    NSString *maxId = nil;

    if (_statusCellFrames.count) {
        StatusCellFrame *lastStatusCellFrame = [_statusCellFrames lastObject];
        Status *lastStatus = lastStatusCellFrame.status;
        maxId =lastStatus.idstr;
    }
    
    
    long long lastll = [maxId longLongValue];
    lastll--;
    
    maxId = [NSString stringWithFormat:@"%lld",lastll];
    
    
    [StatusTool statusesWithSinceId:nil maxId:maxId success:^(NSMutableArray *statuses) {
        
        NSMutableArray *newFrames = [NSMutableArray array];
        for (Status *s in statuses) {
            StatusCellFrame *frame = [[StatusCellFrame alloc] init];
            frame.status = s;
            [newFrames addObject:frame];
        }
        
        // 1.将新数据添加到旧数据的后面
        [_statusCellFrames addObjectsFromArray:newFrames];

        
        [_footer endRefreshing];
        [self.tableView reloadData];
        
    } fail:^{
        [_footer endRefreshing];
    }];
    
    
}

#pragma mark 显示最近刷新的微博数量

-(void)showNewStatusCount:(int)count
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.userInteractionEnabled = NO;
    [button setBackgroundImage:[UIImage stretchImageWithName:@"timeline_new_status_background.png"] forState:UIControlStateNormal];
    CGFloat btnWidth = self.view.frame.size.width;
    CGFloat btnHeight = 44;
    button.frame = CGRectMake(0, 0, btnWidth, btnHeight);
    
    [self.navigationController.view insertSubview:button belowSubview:self.navigationController.navigationBar];
    
    NSString *text = @"没有新的微博";
    
    if (count) {
        text = [NSString stringWithFormat:@"共有%d条微博",count];
    }
    
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.3 animations:^{
        button.transform=CGAffineTransformMakeTranslation(0, btnHeight);
      
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.7 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
            button.transform= CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [button removeFromSuperview];
        }];

        
    }];


}


-(void)dealloc
{

    [_header free];
    [_footer free];
}


@end
