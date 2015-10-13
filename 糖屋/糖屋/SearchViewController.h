//
//  SearchViewController.h
//  糖屋
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
@interface SearchViewController : UIViewController
@property (nonatomic,strong) UIScrollView * mainScrollView;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,copy) NSString * keyword;
@property  NSInteger classPage;

//第一次下载网络数据
- (void)firstDownLoad;
- (void)downLoadWithURL:(NSInteger)classPage andKeyword:(NSString *)keyword;
@end
