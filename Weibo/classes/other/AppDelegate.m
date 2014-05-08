//
//  AppDelegate.m
//  Weibo
//
//  Created by jingdongqi on 14-4-26.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "NewFeatureViewController.h"
#import "AccountTool.h"
#import "OauthViewController.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    
    
    NSString *versionKey = (NSString*)kCFBundleVersionKey;
    
    NSString *lastVersionCode = [[NSUserDefaults standardUserDefaults]objectForKey:versionKey];
    
    NSString *currentVersionCode = [NSBundle mainBundle].infoDictionary[versionKey];
    
    
    Account *currentAccount = [AccountTool sharedAccountTool].currentAccount;
    
    if ([lastVersionCode isEqualToString:currentVersionCode]) {
        
        if (!currentAccount) {
            OauthViewController *oauthCtrl = [[OauthViewController alloc]init];
            
            [self.window setRootViewController:oauthCtrl];
        }else{
            MainViewController *mainCtrl = [[MainViewController alloc]init];
            
            [self.window setRootViewController:mainCtrl];

        }
        
    }else{
        NewFeatureViewController *newFeatureCtrl = [[NewFeatureViewController alloc]init];
        [self.window setRootViewController:newFeatureCtrl];
        newFeatureCtrl.startBlock=^(BOOL shared){
            
                   [self startWeibo:shared];
            
               
               };

        [[NSUserDefaults standardUserDefaults]setObject:currentVersionCode forKey:versionKey];
    
    }
    
    
    return YES;
}

- (void)startWeibo:(BOOL)shared
{
    [UIApplication sharedApplication].statusBarHidden = NO;
    MainViewController *main = [[MainViewController alloc] init];
    self.window.rootViewController = main;


}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
