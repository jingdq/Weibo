//
//  MoreViewController.m
//  Weibo
//
//  Created by jingdongqi on 14-5-1.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()
{
    NSArray *dataArray;
}

@end

@implementation MoreViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"更多";
    
    NSURL *fileUrl = [[NSBundle mainBundle]URLForResource:@"more" withExtension:@"plist"];
    
    NSDictionary *data = [NSDictionary dictionaryWithContentsOfURL:fileUrl];
    
    dataArray = data[@"zh_CN"];
    
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = kGlobalBg;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    UIButton *btnExit = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btnExit.frame = CGRectMake(10, 5, 300, 40);
    btnExit.titleLabel.font = [UIFont systemFontOfSize:17];
    
    [btnExit addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    NSString *text = [dataArray lastObject][0][@"name"];
    
    [btnExit setAllStateBg:@"common_button_red.png"];
    [btnExit setTitle:text forState:UIControlStateNormal];
    
    UIView *footer = [[UIView alloc] init];
    footer.userInteractionEnabled = YES;
    footer.frame = CGRectMake(0, 0, 0, 70);
    [footer addSubview:btnExit];
    
    self.tableView.tableFooterView = footer;
    


}

-(void)exit{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"确定退出此账号？" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"退出" otherButtonTitles:nil, nil];
    [sheet showInView:self.tableView.window];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataArray.count - 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray *sectionArray = dataArray[section];
    
    return sectionArray.count;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *cellId = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.highlightedTextColor =cell.textLabel.textColor;
        // 1.3.设置cell的背景view
        UIImageView *bg = [[UIImageView alloc] init];
        cell.backgroundView = bg;
        UIImageView *selectedBg = [[UIImageView alloc] init];
        cell.selectedBackgroundView = selectedBg;

    }
    
    
    cell.textLabel.text =  dataArray[indexPath.section][indexPath.row][@"name"];

    UIImageView *bg = (UIImageView *)cell.backgroundView;
    UIImageView *selectedBg = (UIImageView *)cell.selectedBackgroundView;
   
    NSArray *sectionArray = dataArray[indexPath.section];
    int count = sectionArray.count;
    NSString *name = nil;
    if (count == 1) { // 只有1个
        name = @"common_card_background.png";
    } else if (indexPath.row == 0) { // 顶部
        name = @"common_card_top_background.png";
    } else if (indexPath.row == count - 1) { // 底部
        name = @"common_card_bottom_background.png";
    } else { // 中间
        name = @"common_card_middle_background.png";
    }
    
    // 3.3.设置背景图片
    bg.image = [UIImage stretchImageWithName:name];
    selectedBg.image = [UIImage stretchImageWithName:[name filenameAppend:@"_highlighted"]];

    
    
    if (indexPath.section == 2) { // 阅读模式 - 主题
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor]; // 清除背景色
        label.font = [UIFont systemFontOfSize:13]; // 文字大小
        label.textColor = [UIColor grayColor]; // 文字颜色
        label.textAlignment = NSTextAlignmentRight; // 文字靠右
        label.bounds = CGRectMake(0, 0, 100, 30); // 文字的边框
        label.text = (indexPath.row == 0) ? @"有图模式" : @"经典主题"; // 文字内容
        cell.accessoryView = label;
    } else {
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow.png"]];
    }
    
  
    return cell;

}


@end
