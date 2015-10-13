//
//  BsetChosenViewController.h
//  糖屋
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopNewsProtocol.h"
#import "MainPageViewController.h"
#import "AFNetworking.h"
#import "BestChosenTableViewCell.h"
#import "Path.h"
#import "BestChosenModel.h"
#import "MJRefresh.h"
#import "CacheFunc.h"
@interface BsetChosenViewController : MainPageViewController
<TopNewsProtocol>
@property (nonatomic,strong) UITableView * tableView;

// 第一次下载网络数据
- (void)firstDownLoad;
- (void)downLoadWithURL:(NSInteger)page andSubject_id:(NSString *)subject_id;
@end
