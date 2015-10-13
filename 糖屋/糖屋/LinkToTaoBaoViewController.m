//
//  LinkToTaoBaoViewController.m
//  糖屋
//
//  Created by qianfeng on 15/9/19.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "LinkToTaoBaoViewController.h"
#import "Path.h"
@interface LinkToTaoBaoViewController ()
{
    UIWebView * _webView;
}
@end

@implementation LinkToTaoBaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"淘宝";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:198/255.0f green:79/255.0f blue:75/255.0f alpha:1.0];
    NSDictionary * attributeDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:19],NSFontAttributeName, [UIColor whiteColor],NSForegroundColorAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributeDic];
    
    
    if ([self.type isEqualToString:@"mainpage"]) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height - 64)];
    } else {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height)];
    }
    
    [self.view addSubview:_webView];
    NSURL * URL = [NSURL URLWithString:self.taoBaoLink];
    NSURLRequest * requset = [NSURLRequest requestWithURL:URL];
    [_webView loadRequest:requset];
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
