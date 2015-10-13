//
//  ContentInMainViewController.m
//  糖屋
//
//  Created by qianfeng on 15/9/17.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "ContentInMainViewController.h"
#import "Path.h"
#import "MainPageModel.h"
#import "MainTableViewCell.h"
#import "MJRefresh.h"
#import "DetailViewController.h"
#import "CacheFunc.h"
#import "AdScrollView.h"
#import "AdDataModel.h"
@interface ContentInMainViewController ()
<UITableViewDataSource,UITableViewDelegate>
// 用来存储商品数据的数组
@property (nonatomic,strong) NSMutableArray * dataArray;
// 用来存储广告数据的数组
@property (nonatomic,strong) NSMutableArray * bannerArray;
// 用来存储广告图片的数组

// 表格视图
@property (nonatomic,strong) UITableView * tableView;
// 利用第三方类来异步下载网络数据
@property (nonatomic,strong) AFHTTPRequestOperationManager * manager;
// 请求网络数据的接口
@property (nonatomic,strong) NSString * requestURL;
// 获取模型中的update_time属性
@property (nonatomic,strong) NSString * update_time;
// 代理方法传广告数组

@end

@implementation ContentInMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 子类重写父类的方法，就回进入到这个子类中执行子类的代码
    [self creatViews:@"糖屋"];
    // 创建表格视图
    [self creatTableVew];
    // 滚动的navigationbar
    [self followRollingScrollView:self.tableView];
    // 初始化manager
    self.manager = [AFHTTPRequestOperationManager manager];
    // 设置服务器响应的格式
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self firstDownLoad];
    // 刷新
    [self setRefreshData];
    
}
// typeof(self) 是获取到self的类型,这样定义出的weakSelf就是和self一个类型的, 加上__weak是建立一个若引用,整句就是给self定义了一个若引用性质的替身; 这个一般用在使用block时会用到,因为block会copy它内部的变量,可能会造成引用循环,使用__weak性质的self替代self,可以切断block对self的引用,避免循环引用
#pragma mark - 下载数据的方法 -
- (void)firstDownLoad {
    self.update_time = 0;
    [self downLoadWithURL:self.update_time];
}
static int i = 0;
- (void)downLoadWithURL:(NSString *)update_time {
    __weak typeof(self) weakSelf = self;
    NSString * URL = [NSString stringWithFormat:MAIN_URL,self.update_time];
    // 利用第三方库AFNetworking下载网络数据,GET方法
    [weakSelf.manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSLog(@"下载成功:%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        // 访问数据成功，把数据保存到缓存中
        [CacheFunc saveDataToCacheWith:MAIN_CACHE andUpdateTime:self.update_time.integerValue andData:responseObject];
        // 把json数据转化为字典
        NSDictionary * AllDataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        // 找到字典中键值是data的数据，得到的结果是个字典
        NSDictionary * dataDic = AllDataDic[@"data"];
        // 找到商品数组
        NSArray * topicArray = dataDic[@"topic"];
        
        if (topicArray.count == 0) {
            return ;
        }
        
        // 加入到模型中
        for (NSDictionary * oneDic in topicArray) {
            MainPageModel * oneModel = [[MainPageModel alloc] initWithDictionary:oneDic error:nil];
            [weakSelf.dataArray addObject:oneModel];
        }
        // 找到广告数组
        NSArray * bannerArray = dataDic[@"banner"];
        // 加入到模型中
        for (NSDictionary * oneDic in bannerArray) {
            MainPageModel * oneModel = [[MainPageModel alloc] initWithDictionary:oneDic error:nil];
            [weakSelf.bannerImagesArray addObject:oneModel.photo];
        }
        // 设置顶部新闻视图
        // NSLog(@"%@",self.bannerImagesArray);
        
        if (i == 0) {
            [weakSelf creatScrollView];
            i++;
        }
        
        // 代理方法
        if ([weakSelf.delegate respondsToSelector:@selector(setTopNewsWithNewsArray:)]) {
            [weakSelf.delegate setTopNewsWithNewsArray:self.bannerImagesArray];
        }
        [weakSelf.tableView reloadData];
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 访问失败，从缓存中读取数据
        NSData * responseObject = [CacheFunc getDataFromCacheWith:MAIN_CACHE andUpdateTime:weakSelf.update_time.integerValue];
        if (responseObject == nil) {
            return ;
        }
        // 把json数据转化为字典
        NSDictionary * AllDataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        // NSLog(@"%@",AllDataDic);
        // 找到字典中键值是data的数据，得到的结果是个字典
        NSDictionary * dataDic = AllDataDic[@"data"];
        // 找到商品数组
        NSArray * topicArray = dataDic[@"topic"];
        // 加入到模型中
        for (NSDictionary * oneDic in topicArray) {
            MainPageModel * oneModel = [[MainPageModel alloc] initWithDictionary:oneDic error:nil];
            [weakSelf.dataArray addObject:oneModel];
        }
        // 找到广告数组
        NSArray * bannerArray = dataDic[@"banner"];
        // 加入到模型中
        for (NSDictionary * oneDic in bannerArray) {
            MainPageModel * oneModel = [[MainPageModel alloc] initWithDictionary:oneDic error:nil];
            [weakSelf.bannerImagesArray addObject:oneModel.photo];
        }
        // 设置顶部新闻视图
        [weakSelf creatScrollView];
        // 代理方法
        if ([weakSelf.delegate respondsToSelector:@selector(setTopNewsWithNewsArray:)]) {
            [weakSelf.delegate setTopNewsWithNewsArray:self.bannerImagesArray];
        }
        [weakSelf.tableView reloadData];
    }];
}
#pragma mark - 刷新数据的方法 -
- (void)setRefreshData {
    // 添加下拉刷新功能
    [self.tableView addHeaderWithTarget:self action:@selector(headerRefreshing) dateKey:@"table"];
    // 设置头部提示
    self.tableView.headerPullToRefreshText = @"下拉可以刷新";
    self.tableView.headerReleaseToRefreshText = @"松开即可刷新";
    self.tableView.headerRefreshingText = @"正在下载中";
    // 添加上拉刷新
    [self.tableView addFooterWithTarget:self action:@selector(footerRefreshing)];
    // 设置底部提示
    self.tableView.footerPullToRefreshText = @"继续向上拉可以刷新";
    self.tableView.footerReleaseToRefreshText = @"松开即可刷新";
    self.tableView.footerRefreshingText = @"正在加载中";
}
// - 下拉 -
- (void)headerRefreshing {
    [self performSelector:@selector(refreshData) withObject:nil afterDelay:1.0];
}
- (void)refreshData {
    // 插入的数据
    [self.dataArray removeAllObjects];
    [self.bannerImagesArray removeAllObjects];
    self.update_time = 0;
    [self downLoadWithURL:MAIN_URL];
    //
    CATransition * transaction = [CATransition animation];
    transaction.type = @"rippleEffect";
    transaction.duration = 1;
    [self.tableView.layer addAnimation:transaction forKey:nil];
    // 刷新界面
    [self.tableView reloadData];
    // 结束刷新
    [self.tableView headerEndRefreshing];
}
// - 上拉 -
- (void)footerRefreshing {
    [self performSelector:@selector(loadMoreData) withObject:nil afterDelay:1.0];
}
- (void)loadMoreData {
    // 此处加载新的数据
    MainPageModel * oneModel = self.dataArray.lastObject;
    self.update_time = oneModel.update_time;
    [self downLoadWithURL:MAIN_URL];
    // 动画效果
    CATransition * transaction = [CATransition animation];
    transaction.type = @"rippleEffect";
    transaction.duration = 1;
    [self.tableView.layer addAnimation:transaction forKey:nil];
    // 刷新界面
    [self.tableView reloadData];
    // 结束刷新
    [self.tableView footerEndRefreshing];
}
#pragma - 头部的滚动新闻视图 -
- (void)creatScrollView {
    AdScrollView * scrollView = [[AdScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 150)];
    AdDataModel * dataModel = [AdDataModel adDataModelWithImageNameAndAdTitleArray];
    //scrollView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    dataModel.imageNameArray = self.bannerImagesArray;
    scrollView.imageNameArray = dataModel.imageNameArray;
    scrollView.PageControlShowStyle = UIPageControlShowStyleRight;
    scrollView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    [scrollView setAdTitleArray:dataModel.adTitleArray withShowStyle:AdTitleShowStyleLeft];
    scrollView.pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    self.tableView.tableHeaderView = scrollView;
}


#pragma mark - 创建表格视图以及表格视图的代理方法 -
- (void)creatTableVew {
    self.dataArray = [[NSMutableArray alloc] init];
    self.bannerImagesArray = [[NSMutableArray alloc] init];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height - 64) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    [self.tableView registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:nil] forCellReuseIdentifier:@"MaintableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    // 设置没有cell的cell分割线隐藏
    self.tableView.tableFooterView = [[UIView alloc] init];
    
}
#pragma mark - 表格视图的代理方法 -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MaintableViewCell" forIndexPath:indexPath];
    // 设置点击的时候不显示选中的灰色背景
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MainPageModel * model = self.dataArray[indexPath.row];
    [cell showDataWithModel:model andIndexPath:indexPath];
    return cell;
}
// 点击了表格的某一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 点击显示navigationbar  解决bug
    [self touchNavigationBarBack];
    MainPageModel * model = self.dataArray[indexPath.row];
    DetailViewController * detailViewController = [[DetailViewController alloc] init];
    detailViewController.mainCell = model.id;
    // 此句代码是为了解决10件商品界面的frame的问题
    detailViewController.type = @"mainpage";
    // 为以后的收藏做准备
    detailViewController.model = model;
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 当进入到下一个界面的时候隐藏底部的toolBar
    detailViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
