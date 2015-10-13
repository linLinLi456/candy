//
//  TaoBaoViewController.m
//  糖屋
//
//  Created by qianfeng on 15/9/29.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "TaoBaoViewController.h"
#import "Path.h"
@interface TaoBaoViewController ()
{
    UIWebView * _webView;
}

@end

@implementation TaoBaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"淘宝";
    UINavigationBar * navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 64)];
    [self.view addSubview:navigationBar];
    // 设置UINavigationBar标题和按钮 用UINavigationItem方法
    UINavigationItem * navigationItem = [[UINavigationItem alloc] initWithTitle:@"详情"];
    [navigationBar setItems:[NSArray arrayWithObjects:navigationItem, nil]];
    navigationBar.tintColor = [UIColor whiteColor];
    navigationBar.barTintColor = [UIColor colorWithRed:198/255.0f green:79/255.0f blue:75/255.0f alpha:1.0];
    NSDictionary * attributeDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:19],NSFontAttributeName, [UIColor whiteColor],NSForegroundColorAttributeName,nil];
    [navigationBar setTitleTextAttributes:attributeDic];
    
    // 左边按钮
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"next_tips2.png"] style:0 target:self action:@selector(leftBtnClicked)];
    navigationItem.leftBarButtonItem = leftBtn;
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_SIZE.width, SCREEN_SIZE.height - 64)];
    [self.view addSubview:_webView];
    // 滚动的navigationbar
    // [self followRollingScrollView:_webView];
    NSURL * URL = [NSURL URLWithString:self.taoBaoLink];
    NSURLRequest * requset = [NSURLRequest requestWithURL:URL];
    [_webView loadRequest:requset];
}

- (void)leftBtnClicked {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
