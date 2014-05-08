//
//  MainViewController.m
//  Weibo
//
//  Created by jingdongqi on 14-4-26.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import "MainViewController.h"
#import "Dock.h"
#import "HomeViewController.h"
#import "DiscoverViewController.h"
#import "MessageViewController.h"
#import "ProfileViewController.h"
#import "MoreViewController.h"
#import "SlideNavViewController.h"

#define kDockHeight 44
#define kDockFrame CGRectMake(0, self.view.frame.size.height-kDockHeight, self.view.frame.size.width, kDockHeight)
#define kContentFrame CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - kDockHeight)


@interface MainViewController ()
{
    SlideNavViewController *_selectedViewController;
    Dock *_dock;
}
@end

@implementation MainViewController

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
    
    //1.添加dock
    
    [self addDock];
    
    
    //2.创建所有的自控制器
    
    [self createChildViewControllers];
    
    // 3.默认选中第0个控制器
    [self selecteControllerAtIndex:0];
    
    
    
    
    
}


- (void)setNavigationTheme
{
    UINavigationBar *navBar = [UINavigationBar appearance];

    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background.png"] forBarMetrics:UIBarMetricsDefault];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
    
    
    [navBar setTitleTextAttributes:@{
                                     UITextAttributeTextColor:[UIColor darkGrayColor],
                                     UITextAttributeTextShadowOffset:[NSValue valueWithUIOffset:UIOffsetZero]
                                    
                                     }];
    
    
   UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    [barItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [barItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_pushed.png"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [barItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_disable.png"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
 
    
    NSDictionary *barItemTextAttr = @{
                                      UITextAttributeTextColor : [UIColor darkGrayColor],
                                      UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero],
                                      UITextAttributeFont : [UIFont systemFontOfSize:13]
                                      };
    [barItem setTitleTextAttributes:barItemTextAttr forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:barItemTextAttr forState:UIControlStateHighlighted];


}



-(void)addChildViewController:(UIViewController *)childController
{
    SlideNavViewController *nav = [[SlideNavViewController alloc]initWithRootViewController:childController];
    [nav setDelegate:self];
    [super addChildViewController:nav];
}

- (void)createChildViewControllers
{
    //首页
    HomeViewController *home = [[HomeViewController alloc]init];
    [self addChildViewController:home];
    
    //消息
    
    MessageViewController *message = [[MessageViewController alloc]init];
    [self addChildViewController:message];
    
    // 我
    
    ProfileViewController *profile = [[ProfileViewController alloc]init];
    [self addChildViewController:profile];
    
    //广场
    
    DiscoverViewController *discover = [[DiscoverViewController alloc]init];
    [self addChildViewController:discover];
    
    //更多
    
    MoreViewController *more = [[MoreViewController alloc]init];
    [self addChildViewController:more];
    
    

}

- (void)addDock
{
    _dock = [[Dock alloc]init];
    _dock.frame = kDockFrame;
    [self.view addSubview:_dock];
    
    
    
    // 2.添加dock里面的item
    [_dock addDockItemWithIcon:@"tabbar_home.png" title:@"首页"];
    [_dock addDockItemWithIcon:@"tabbar_message_center.png" title:@"消息"];
    [_dock addDockItemWithIcon:@"tabbar_profile.png" title:@"我"];
    [_dock addDockItemWithIcon:@"tabbar_discover.png" title:@"广场"];
    [_dock addDockItemWithIcon:@"tabbar_more.png" title:@"更多"];
    
    __weak MainViewController *mainViewCtrl = self;
    _dock.itemClickBlock = ^(int index){
      
        [mainViewCtrl selecteControllerAtIndex:index];
    
    };

}


-(void)selecteControllerAtIndex:(int)index
{
    SlideNavViewController *new = self.childViewControllers[index];
    if (new == _selectedViewController) {
        return;
    }

    [_selectedViewController.view removeFromSuperview];
    
    new.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - kDockHeight);
    
    [self.view addSubview:new.view];
    
    _selectedViewController = new;
    
}



- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIViewController *root =  navigationController.viewControllers[0];
    if (viewController !=root) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithIcon:@"navigationbar_back.png" target:self action:@selector(back)];
        
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithIcon:@"navigationbar_home.png" target:self action:@selector(home)];
        
        
        navigationController.view.frame = self.view.bounds;
        
        // 让Dock从MainViewController上移除
        [_dock removeFromSuperview];
        
        // 调整Dock的Y值
        CGRect dockFrame = _dock.frame;
        if ([root.view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollview = (UIScrollView *)root.view;
            dockFrame.origin.y = scrollview.contentOffset.y + root.view.frame.size.height - kDockHeight;
        } else {
            dockFrame.origin.y -= kDockHeight;
        }
        _dock.frame = dockFrame;
        
        // 添加dock到根控制器界面
        [root.view addSubview:_dock];

    }


}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    // 根控制器
    UIViewController *root = navigationController.viewControllers[0];
    
    if (viewController == root) {
        // 更改导航控制器view的frame
        navigationController.view.frame = kContentFrame;
        
        // 让Dock从root上移除
        [_dock removeFromSuperview];
        
        // 添加dock到MainViewController
        _dock.frame = kDockFrame;
        [self.view addSubview:_dock];
    }



}


-(void)back
{
    
    [_selectedViewController popViewControllerAnimated:YES];

}


-(void)home
{
     [_selectedViewController popToRootViewControllerAnimated:YES];
}

@end
