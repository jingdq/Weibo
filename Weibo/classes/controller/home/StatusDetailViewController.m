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
#import "StatusTool.h"
#import "Status.h"
#import "BaseTextModel.h"
#import "BaseTextCellFrame.h"
#define kOptionHeight 44
#define kTitleViewHeiht 50
@interface StatusDetailViewController ()<MJRefreshBaseViewDelegate>
{
    UITableView *_tableView;
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    StatusDetailTitleView *_titleView;
    StatusDetailCellFrame *_statusFrame;
    
    
    // 所有的评论frame数据
    NSMutableArray *_commentFrames;
    
    // 所有的转发数据
    NSMutableArray *_repostFrames;
    
    // 评论数据是否为最后一页
    BOOL _commentLastPage;
    
    // 转发数据是否为最后一页
    BOOL _repostLastPage;

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
    __unsafe_unretained StatusDetailViewController *detail = self;
    _titleView.btnClickBlock = ^{
       [detail loadAllNewData];
       [detail->_tableView reloadData];
    };
 
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
#pragma mark 刷新所有的数据
- (void)loadAllNewData
{
    // 1.刷新微博数据
    [self loadNewStatus];
    
    // 2.根据状态刷新对应的表格数据（评论、转发）
    if (_titleView.type == TitleViewBtnTypeRepost) {
        [self loadNewReposts];
    } else if (_titleView.type == TitleViewBtnTypeComment) {
        [self loadNewComments];
    }
}

#pragma mark 加载最新的微博数据
- (void)loadNewStatus{
    [StatusTool statusWithId:_status.idstr success:^(Status *status) {
        // 1.刷新titleView
        _titleView.status = status;
        
        // 2.刷新tableView
        [_statusFrame.status update:status];
        [_tableView reloadData];
        
        // 3.隐藏头部控件
        [_header endRefreshing];
    } fail:^{
        [_header endRefreshing];
    }];

}

#pragma mark 返回当前状态对应的frame数据
- (NSMutableArray *)currentFrames
{
    if (_titleView.type == TitleViewBtnTypeComment) {
        return _commentFrames;
    } else if (_titleView.type == TitleViewBtnTypeRepost) {
        return _repostFrames;
    }
    return nil;
}
#pragma mark 获得maxId
- (NSString *)maxId
{
    NSString *maxId = nil;
    if ([self currentFrames].count) { // 取出最后面那条评论的id - 1
        BaseTextCellFrame *last = [[self currentFrames] lastObject];
        
        // 这里一定要用long long
        long long lastll = [last.baseTextModel.idstr longLongValue];
        lastll--;
        
        maxId = [NSString stringWithFormat:@"%lld", lastll];
    }
    
    return maxId;
}

#pragma mark 获得sinceId
- (NSString *)sinceId
{
    NSString *sinceId = nil;
    if ([self currentFrames].count) { // 取出最前面那条评论的id
        BaseTextCellFrame *cellFrame = [self currentFrames][0];
        sinceId = cellFrame.baseTextModel.idstr;
    }
    return sinceId;
}

#pragma mark 最新的加载转发列表
- (void)loadNewReposts{
    // 加载ID>sinceId的转发
    NSString *sinceId = [self sinceId];
    
    [StatusTool repostsWithId:_status.idstr sinceId:sinceId maxId:nil success:^(NSMutableArray *reposts, int totalNum, NSString *nextCursor) {
        // 0.如果刚开始没有数据，就初始化
        if (_repostFrames == nil) {
            _repostFrames = [NSMutableArray array];
        }
        
        // 1.计算最新的frame数据
        NSMutableArray *newFrames = [self newFramesWithData:reposts];
        
        // 2.先讲旧数据添加到新数据的后面
        [newFrames addObjectsFromArray:_repostFrames];
        // 3.设置当前的所有数据
        _repostFrames = newFrames;
        
        // 4.判断有没有下一页数据
        _repostLastPage= [@"0" isEqualToString:nextCursor];
        
        // 5.刷新表格
        // 更新微博的转发数
        _status.repostsCount = totalNum;
        [_tableView reloadData];
    } fail:^{
        
    }];


}

#pragma mark 将所有的数据转为frame数据
- (NSMutableArray *)newFramesWithData:(NSArray *)data
{
    NSMutableArray *newFrames = [NSMutableArray array];
    for (BaseTextModel *c in data) {
        BaseTextCellFrame *f = [[BaseTextCellFrame alloc] init];
        f.baseTextModel = c;
        [newFrames addObject:f];
    }
    return newFrames;
}

#pragma mark 最新的加载评论列表
- (void)loadNewComments{
    
    // 加载ID>sinceId的评论
    NSString *sinceId = [self sinceId];
    
    [StatusTool commentsWithId:_status.idstr sinceId:sinceId maxId:nil success:^(NSMutableArray *comments, int totalNum, NSString *nextCursor) {
        // 0.如果刚开始没有数据，就初始化
        if (_commentFrames == nil) {
            _commentFrames = [NSMutableArray array];
        }
        
        // 1.计算最新的frame数据
        NSMutableArray *newFrames = [self newFramesWithData:comments];
        
        // 2.先讲旧数据添加到新数据的后面
        [newFrames addObjectsFromArray:_commentFrames];
        
        // 3.设置当前的所有数据
        _commentFrames = newFrames;
        
        // 4.判断有没有下一页数据
        _commentLastPage = [@"0" isEqualToString:nextCursor];
        
        // 5.刷新表格
        // 更新微博的评论数
        _status.commentsCount = totalNum;
        [_tableView reloadData];
    } fail:^{
        
    }];

}



-(void)dealloc
{

    [_header free];
    [_footer free];
    
}


@end
