//
//  TopicContentViewController.h
//  糖屋
//
//  Created by qianfeng on 15/9/25.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "BsetChosenViewController.h"
#import <UIKit/UIKit.h>
#import "AFNetworking.h"

#import "BestChosenTableViewCell.h"
#import "Path.h"
#import "BestChosenModel.h"
#import "MJRefresh.h"
#import "CacheFunc.h"
@interface TopicContentViewController : UIViewController
@property (nonatomic,copy) NSString * subject_id;
@property (nonatomic,strong) UITableView * tableView;
//利用第三方类来异步下载网络数据
@property (nonatomic,strong) AFHTTPRequestOperationManager * managerTop;
//请求网络数据的接口
@property (nonatomic,copy) NSString * requestURLTop;
@property (nonatomic,strong) NSMutableArray * dataArrayTop;
//第一次下载网络数据
- (void)firstDownLoad;
- (void)downLoadWithURL:(NSInteger)page andSubject_id:(NSString *)subject_id;
@end
