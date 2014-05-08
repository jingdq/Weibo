//
//  SlideNavViewController.m
//  Weibo
//
//  Created by jingdongqi on 14-5-7.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import "SlideNavViewController.h"
#define kDefaultScale 0.4
#define kDefaultAlpha 0.7
@interface SlideNavViewController ()
{
    UIImageView *_imageView;
    UIView *_cover;
}
@end

@implementation SlideNavViewController

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
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragView:)]];
    _imageView = [[UIImageView alloc] init];
    _imageView.frame = [UIScreen mainScreen].applicationFrame;
    _cover = [[UIView alloc] init];
    _cover.frame = _imageView.frame;
    _cover.backgroundColor = [UIColor blackColor];
}




- (void)cut
{
  //拿到首页的View
    UIView *cutView = self.view.window.rootViewController.view;
   //开启上下文
    UIGraphicsBeginImageContext(cutView.frame.size);
    //讲 cutView的图层渲染到上下文中
    
    [cutView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    //取出Image
    
    _imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    
    //结束上下文
    
    UIGraphicsEndImageContext();
    

}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self cut];
    [super pushViewController:viewController animated:animated];
}



-(void)dragView:(UIPanGestureRecognizer*)pan
{
    
    //如果是根视图控制器则直接返回
    if (self.topViewController == self.viewControllers[0]) {
        return;
    }
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            [self beganDrag];

            break;
            
        case UIGestureRecognizerStateEnded:
             [self endedDrag];
            break;
        default:
            [self dragging:pan];
            break;
    }
    


}



-(void)beganDrag
{
    [self.view.window insertSubview:_imageView atIndex:0];
//    [self.view.window insertSubview:_cover aboveSubview:_imageView];
}
-(void)endedDrag
{
    
}
-(void)dragging:(UIPanGestureRecognizer*)pan
{
    // 挪动整个导航view
    
    
    CGFloat tx = [pan translationInView:self.view].x;
    if (tx < 0) {
        tx = 0;
    }
    self.view.transform=CGAffineTransformMakeTranslation(tx, 0);
    
    
    
}





@end
