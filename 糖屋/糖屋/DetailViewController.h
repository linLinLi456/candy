//
//  DetailViewController.h
//  糖屋
//
//  Created by qianfeng on 15/9/18.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainPageModel.h"
#import "MyFMDBInfo.h"
#import "MainPageViewController.h"
@interface DetailViewController : MainPageViewController
// 确定点击的具体行
@property (nonatomic,copy) NSString * mainCell;
// 确定点击的数据模型
@property (nonatomic,strong) MainPageModel * model;
// 展示详情的表格
@property (nonatomic,strong) UITableView * tableView;
// 用来存储数据的容器
@property (nonatomic,strong) NSMutableArray * dataArray;
// 顶部
@property (nonatomic,strong) NSMutableArray * topArray;
// 顶部的表格
@property (nonatomic,strong) UITableView * topView;
// 用来判断是哪个页面推出的此页面
@property (nonatomic,copy) NSString * type;
@end
