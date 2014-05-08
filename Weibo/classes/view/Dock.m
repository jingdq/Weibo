//
//  Dock.m
//  Weibo
//
//  Created by jingdongqi on 14-5-1.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import "Dock.h"
#import "DockItem.h"
@interface Dock(){

    // 当前选中了哪个item
    DockItem *_currentItem;
}
@end

@implementation Dock

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background.png"]];
        
    }
    return self;
}


-(void)addDockItemWithIcon:(NSString *)icon title:(NSString *)title
{
    // 1.创建item
    DockItem *item = [DockItem buttonWithType:UIButtonTypeCustom];
    [self addSubview:item];
    
    // 2.设置文字
    [item setTitle:title forState:UIControlStateNormal];
    
    // 3.设置图片
    [item setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [item setImage:[UIImage imageNamed:[icon filenameAppend:@"_selected"]] forState:UIControlStateSelected];
    
    // 4.监听点击
    [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchDown];

    // 5.调整item的边框
    [self adjustDockItemsFrame];
    
    
    
}

- (void)adjustDockItemsFrame
{
    int count = self.subviews.count;
    // 0.算出item的尺寸
    CGFloat itemWidth = self.frame.size.width / count;
    CGFloat itemHeight = self.frame.size.height;

    for (int i  = 0; i<count; i++) {
        DockItem *item = self.subviews[i];
        item.frame = CGRectMake(i*itemWidth, 0, itemWidth, itemHeight);
        if (i == 0) { // 3.第0个item选中
            item.selected = YES;
            _currentItem = item;
        }

        
        item.tag = i;
    }
    
    
    
}


-(void)setSelectedIndex:(int)selectedIndex
{
   if (selectedIndex < 0 || selectedIndex >= self.subviews.count) return;
    _selectedIndex = selectedIndex;
    DockItem *item = self.subviews[selectedIndex];
    
    [self itemClick:item];

}

-(void)itemClick:(DockItem*)button
{
    NSLog(@"itemClick %d",button.tag);
    
    _currentItem.selected = NO;
    
    button.selected = YES;
    
    _currentItem = button;
    
    if (_itemClickBlock) {
        _itemClickBlock(button.tag);
    }
}

@end
