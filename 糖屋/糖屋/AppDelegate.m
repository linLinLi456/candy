//
//  AppDelegate.m
//  糖屋
//
//  Created by qianfeng on 15/9/16.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "AppDelegate.h"

#import "RightViewController.h"
#import "LeftViewController.h"
#import "TabBarViewController.h"
#import "UMSocial.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    //友盟分享
    [UMSocialData setAppKey:@"5610e2cd67e58e287400081e"];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    LeftViewController *leftViewController=[[LeftViewController alloc]init];
    //RightViewController * rightViewControler = [[RightViewController alloc] init];
    TabBarViewController * tabBarViewController = [[TabBarViewController alloc] init];
    _sideViewController=[[YRSideViewController alloc]init];
    _sideViewController.rootViewController = tabBarViewController;
    _sideViewController.leftViewController=leftViewController;
    //_sideViewController.rightViewController = rightViewControler;
    _sideViewController.leftViewShowWidth=200;
    _sideViewController.needSwipeShowMenu=true;//默认开启的可滑动展示
    self.window.rootViewController = _sideViewController;
    
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    
    
    
    return YES;
}
- (void)presentRoorViewController {
    self.window.rootViewController = _sideViewController;
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
