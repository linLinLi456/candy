//
//  TabBarViewController.m
//  糖屋
//
//  Created by qianfeng on 15/9/16.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "TabBarViewController.h"
#import "ContentInMainViewController.h"
#import "PersonalPageViewController.h"
#import "ClassficationMainViewController.h"
#import "BsetChosenViewController.h"
#import "TopicViewController.h"
@interface TabBarViewController ()
@end
@implementation TabBarViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //首页
    ContentInMainViewController * mainVC = [[ContentInMainViewController alloc] init];
    UINavigationController * mainNC = [[UINavigationController alloc] initWithRootViewController:mainVC];
    mainNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"tab_home1@2x.png"] selectedImage:[UIImage imageNamed:@"tab_home1@2x.png"]];
    //精选
    BsetChosenViewController * bestChoseVC= [[BsetChosenViewController alloc] init];
    UINavigationController * bsetChoseNC = [[UINavigationController alloc] initWithRootViewController:bestChoseVC];
    bsetChoseNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:[UIImage imageNamed:@"tab_good.png"] selectedImage:[UIImage imageNamed:@"tab_good.png"]];
    mainVC.delegate = bestChoseVC;
    //话题
    TopicViewController * topicVC= [[TopicViewController alloc] init];
    UINavigationController * topicNC = [[UINavigationController alloc] initWithRootViewController:topicVC];
    topicNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"话题" image:[UIImage imageNamed:@"tab_idea.png"] selectedImage:[UIImage imageNamed:@"tab_idea.png"]];
    //分类
    ClassficationMainViewController * classficationVC = [[ClassficationMainViewController alloc] init];
    UINavigationController * classficationNC = [[UINavigationController alloc] initWithRootViewController:classficationVC];
    classficationNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"搜索" image:[UIImage imageNamed:@"tab_search@2x.png"] selectedImage:[UIImage imageNamed:@"tab_search@2x.png"]];
    //收藏
    PersonalPageViewController * personalVC = [[PersonalPageViewController alloc] init];
    UINavigationController * personalNC = [[UINavigationController alloc] initWithRootViewController:personalVC];
    personalNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"收藏" image:[UIImage imageNamed:@"tab_heart@2x.png"] selectedImage:[UIImage imageNamed:@"tab_heart@2x.png"]];
    
//    RightViewController * rightVC = [[RightViewController alloc] init];
//    UINavigationController * rightNC = [[UINavigationController alloc] initWithRootViewController:rightVC];
//    rightNC.navigationBarHidden = YES;
    
    //加入到tabBar容器中
    self.viewControllers = @[mainNC,bsetChoseNC,topicNC,classficationNC,personalNC];
    self.tabBar.tintColor = [UIColor colorWithRed:198/255.0f green:79/255.0f blue:75/255.0f alpha:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
