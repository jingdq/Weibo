//
//  OauthViewController.m
//  Weibo
//
//  Created by jingdongqi on 14-5-2.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import "OauthViewController.h"
#import "MBProgressHUD.h"
#import "Account.h"
#import "AccountTool.h"
#import "MainViewController.h"
@interface OauthViewController ()
{
    UIWebView *_webView;
}
@end

@implementation OauthViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)loadView
{
    
    _webView = [[UIWebView alloc]init];
    _webView.delegate = self;
    self.view = _webView;
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:kOauthURL]];
    [_webView loadRequest:request];
    
    
    
}



- (void)webViewDidStartLoad:(UIWebView *)webView
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:_webView animated:YES];
    hud.labelText = @"哥正在帮你加载....";

}



- (void)webViewDidFinishLoad:(UIWebView *)webView
{

    [MBProgressHUD hideHUDForView:_webView animated:YES];
    
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = request.URL.absoluteString;
    
    NSRange range = [url rangeOfString:@"access_token"];
    
    if (range.length != 0) {
        NSString *paramStr = [url substringFromIndex:range.location];
        
        NSArray *params = [paramStr componentsSeparatedByString:@"&"];
        Account *acc = [[Account alloc]init];
        for (NSString *paramStr in params) {
            NSArray *keyValue = [paramStr componentsSeparatedByString:@"="];
            NSString *key = keyValue[0];
            NSString *value = keyValue[1];
            if ([key isEqualToString:kAccessToken]) {
                acc.accessToken =value;
            }else if ([key isEqualToString:KUid]){
                acc.uid = value;
            }
        }
        
        
        //获取用户昵称
        
        NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?access_token=%@&uid=%@", acc.accessToken, acc.uid];
        NSURL *URL = [NSURL URLWithString:urlStr];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        AFJSONRequestOperation *operatoin = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
            [MBProgressHUD hideHUDForView:_webView animated:YES];
             acc.screenName = JSON[@"screen_name"];

        
            [[AccountTool sharedAccountTool]addAccount:acc];
            
            // 主界面
            MainViewController *main = [[MainViewController alloc] init];
            self.view.window.rootViewController = main;
            
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
            [MBProgressHUD hideHUDForView:_webView animated:YES];

        
        }];
        
        
        [operatoin start];
        
        
        
        return NO;
    }
    
    return  YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
