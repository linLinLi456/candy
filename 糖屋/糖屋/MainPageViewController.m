//
//  MainPageViewController.m
//  糖屋
//
//  Created by qianfeng on 15/9/16.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "MainPageViewController.h"
#import "AppDelegate.h"
#import "MainPageModel.h"
#import "Path.h"

@interface MainPageViewController ()


@end

@implementation MainPageViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.navigationController.navigationBar setTranslucent:NO];
}

#pragma mark - 其他方法 -
// 自定义各种Views
- (void)creatViews:(NSString *)title {
    self.title = title;
    [self.navigationController.navigationBar setTranslucent:NO];
    // navigationbar的文本设置
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:198/255.0f green:79/255.0f blue:75/255.0f alpha:1.0];
    NSDictionary * attributeDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:19],NSFontAttributeName, [UIColor whiteColor],NSForegroundColorAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributeDic];
    // 左边按钮
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"follow_title_profile@2x.png"] style:0 target:self action:@selector(leftBtnClicked)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.view.backgroundColor = [UIColor whiteColor];
}
// 点击显示左侧栏
- (void)leftBtnClicked {
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    YRSideViewController *sideViewController=[delegate sideViewController];
    [sideViewController showLeftViewController:true];
}

// 点击显示右侧侧栏
- (void)rightBtnClicked {
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    YRSideViewController *sideViewController=[delegate sideViewController];
    [sideViewController showRightViewController:true];
}

@end
