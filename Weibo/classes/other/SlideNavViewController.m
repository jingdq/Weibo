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
    [self.view.window insertSubview:_cover aboveSubview:_imageView];
}
-(void)endedDrag
{
    // 取出挪动的距离
    CGFloat tx = self.view.transform.tx;
    // 取出宽度
    CGFloat width = self.view.frame.size.width;
    
    if (tx <= width * 0.5) { // 往左边挪
        [UIView animateWithDuration:0.3 animations:^{
            // 清空transform
            self.view.transform = CGAffineTransformIdentity;
            
            // 让imageView恢复默认的scale
            _imageView.transform = CGAffineTransformMakeScale(kDefaultScale, kDefaultScale);
            
            // 让遮盖恢复默认的alpha
            _cover.alpha = kDefaultAlpha;
        } completion:^(BOOL finished) {
            // 移除两个view
            [_imageView removeFromSuperview];
            [_cover removeFromSuperview];
        }];
    } else { // 往右边挪
        [UIView animateWithDuration:0.3 animations:^{
            // 挪到最右边
            self.view.transform = CGAffineTransformMakeTranslation(width, 0);
            
            // 让imageView缩放为1
            _imageView.transform = CGAffineTransformMakeScale(1, 1);
            
            // 让遮盖alpha变为0
            _cover.alpha = 0;
        } completion:^(BOOL finished) {
            // 清空transform
            self.view.transform = CGAffineTransformIdentity;
            
            // 移除两个view
            [_imageView removeFromSuperview];
            [_cover removeFromSuperview];
            
            // 移除栈顶控制器
            [self popViewControllerAnimated:NO];
        }];
    }

}
-(void)dragging:(UIPanGestureRecognizer*)pan
{
    // 挪动整个导航view
    
    
    // 挪动整个导航view  判断挪动的方向 如果起初往左挪动 则重置 == 不能向左挪动
    CGFloat tx = [pan translationInView:self.view].x;
    if (tx < 0) tx = 0;
    self.view.transform = CGAffineTransformMakeTranslation(tx, 0);
    
    // 计算拖动距离的比例
    double txScale = tx/self.view.frame.size.width;
    
    // 让imageview缩放
    double scale = kDefaultScale + (txScale/0.5) * (1 - kDefaultScale);
    if (scale > 1) scale = 1;
    _imageView.transform = CGAffineTransformMakeScale(scale, scale);
    
    // 让遮盖透明度改变
    double alpha = kDefaultAlpha - (txScale/0.5) * kDefaultAlpha;
    _cover.alpha = alpha;
    
    
    
}





@end
