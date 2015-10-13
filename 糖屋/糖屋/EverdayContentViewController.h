//
//  EverdayContentViewController.h
//  糖屋
//
//  Created by qianfeng on 15/9/28.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "Path.h"
#import "EverdayModel.h"
#import "EverdayChosenTableViewCell.h"
#import "MJRefresh.h"
#import "TaoBaoViewController.h"
@interface EverdayContentViewController : UIViewController
-(instancetype)oinit;
@property (nonatomic,strong) UITableView * leftTableView;
@property (nonatomic,strong) UITableView * rightTableView;
// 第一次下载网络数据
- (void)firstDownLoad;
// 开始下载数据
- (void)downLoadWithURLCategory:(NSInteger)category andPage:(NSInteger)page;
@end
