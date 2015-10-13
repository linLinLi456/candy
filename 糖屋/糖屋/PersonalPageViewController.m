//
//  PersonalPageViewController.m
//  糖屋
//
//  Created by qianfeng on 15/9/16.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "PersonalPageViewController.h"
#import "MyFMDBInfo.h"
#import "MainTableViewCell.h"
#import "Path.h"
#import "DetailViewController.h"
#import "MJRefresh.h"
#import "YRSideViewController.h"
#import "AppDelegate.h"
@interface PersonalPageViewController ()
<UITableViewDataSource,UITableViewDelegate>
{

    //用来存储数据的数组
    NSMutableArray * _dataArray;
    //
    MyFMDBInfo * _myFMDBInfo;
    //
    UIImageView * _mainImageView;
}

@end

@implementation PersonalPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收藏馆";
    [self creatViews:self.title];
    //读取数据库中的数据
    _myFMDBInfo = [[MyFMDBInfo alloc] init];
    [_myFMDBInfo open];
    _dataArray = [[NSMutableArray alloc] init];
    _dataArray = [NSMutableArray arrayWithArray:[_myFMDBInfo getdataInfoWithRecordType:@"myLove"]];
    //判断有无收藏的内容，来决定背景图片显示与否
    self.view.backgroundColor = [UIColor whiteColor];
    _mainImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    _mainImageView.image = [UIImage imageNamed:@"fav_tips.png"];
    if (_dataArray.count == 0) {
        [self creatTableVew];
        //滚动的navigationbar
        [self followRollingScrollView:self.tableView];
        [self.view addSubview:_mainImageView];
    } else {
        [self creatTableVew];
        //滚动的navigationbar
        [self followRollingScrollView:self.tableView];
    }
    //设置当前的对象为广播接收者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:@"refresh" object:nil];
    [self setRefreshData];
}


#pragma mark - 刷新数据的方法 -
- (void)setRefreshData {
    //添加下拉刷新功能
    [self.tableView addHeaderWithTarget:self action:@selector(headerRefreshing) dateKey:@"table"];
    //设置头部提示
    self.tableView.headerPullToRefreshText = @"下拉可以刷新";
    self.tableView.headerReleaseToRefreshText = @"松开即可刷新";
    self.tableView.headerRefreshingText = @"正在下载中";
    //添加上拉刷新
    [self.tableView addFooterWithTarget:self action:@selector(footerRefreshing)];
    //设置底部提示
    self.tableView.footerPullToRefreshText = @"继续向上拉可以刷新";
    self.tableView.footerReleaseToRefreshText = @"松开即可刷新";
    self.tableView.footerRefreshingText = @"正在加载中";}


// - 上拉 -
- (void)headerRefreshing {
    [self performSelector:@selector(refreshData) withObject:nil afterDelay:1.0];
}
- (void)refreshData {
    //在此处进行网络数据的加载
    //NSLog(@"更新数据");
    //插入的数据
    _dataArray = (NSMutableArray *)[_myFMDBInfo getdataInfoWithRecordType:@"myLove"];
    //判断有无收藏内容来确定背景图片
    if (_dataArray.count == 0) {
        [self.view addSubview:_mainImageView];
    } else {
        [_mainImageView removeFromSuperview];
    }
    //刷新界面
    [self.tableView reloadData];
    //结束刷新
    [self.tableView headerEndRefreshing];
}
// - 下拉 -
- (void)footerRefreshing {
    [self performSelector:@selector(loadMoreData) withObject:nil afterDelay:1.0];
}
- (void)loadMoreData {
    //此处加载新的数据
    _dataArray = (NSMutableArray *)[_myFMDBInfo getdataInfoWithRecordType:@"myLove"];
    //刷新界面
    [self.tableView reloadData];
    //结束刷新
    [self.tableView footerEndRefreshing];
}

#pragma mark - 创建表格视图以及表格视图的代理方法 -
- (void)creatTableVew {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height - 64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    [_tableView registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:nil] forCellReuseIdentifier:@"MaintableViewCell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    //设置没有cell的cell分割线隐藏
    _tableView.tableFooterView = [[UIView alloc] init];
}
#pragma mark - 表格视图的代理方法 -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //NSLog(@"%ld",self.dataArray.count);
    return _dataArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MaintableViewCell" forIndexPath:indexPath];
    //NSLog(@"--------%@",self.dataArray);
    MainPageModel * model = _dataArray[indexPath.row];
    //NSLog(@"-----%@",model);
    //设置点击的时候不显示选中的灰色背景
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell showDataWithModel:model andIndexPath:indexPath];
    return cell;
}
//点击了某一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"点击了第%ld行",indexPath.row);
    [self touchNavigationBarBack];
    MainPageModel * model = _dataArray[indexPath.row];
    DetailViewController * detailViewController = [[DetailViewController alloc] init];
    detailViewController.mainCell = model.id;
    //为以后的收藏做准备
    detailViewController.model = model;
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    detailViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailViewController animated:YES];
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
