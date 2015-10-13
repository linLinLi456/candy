//
//  ClassficationViewController.m
//  糖屋
//
//  Created by qianfeng on 15/9/21.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "ClassficationViewController.h"
#import "AFNetworking.h"
#import "Path.h"
#import "MainPageModel.h"
#import "MainTableViewCell.h"
#import "DetailViewController.h"
#import "MJRefresh.h"
@interface ClassficationViewController ()
<UITableViewDataSource,UITableViewDelegate>

    //用来存储商品数据的数组
@property (nonatomic,strong) NSMutableArray * dataArray;
    //用来存储广告图片的数组
@property (nonatomic,strong) NSMutableArray * bannerImagesArray;
    //表格视图
@property (nonatomic,strong) UITableView * tableView;
    //利用第三方类来异步下载网络数据
@property (nonatomic,strong) AFHTTPRequestOperationManager * manager;
    //请求网络数据的接口
@property (nonatomic,copy) NSString * requestURL;
    //获取模型中的update_time属性
@property (nonatomic,copy) NSString * update_time;

@end

@implementation ClassficationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary * attributeDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:19],NSFontAttributeName, [UIColor whiteColor],NSForegroundColorAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributeDic];
    //导航条返回键带的title让它消失
    [[UIBarButtonItem appearance]setBackButtonTitlePositionAdjustment:UIOffsetMake(0,-60)forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //创建表格视图
    [self creatTableVew];
    //滚动的navigationbar
    //[self followRollingScrollView:self.tableView];
    //初始化manager
    self.manager = [AFHTTPRequestOperationManager manager];
    //设置服务器响应的格式
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [self firstDownLoad];
    
    [self setRefreshData];
}
#pragma mark - 开始下载数据 -
- (void)firstDownLoad {
    self.update_time = 0;
    [self downLoadWithURL:self.update_time andCellId:self.cellId];
}
- (void)downLoadWithURL:(NSString *)update_time andCellId:(NSString *)cellId {
    __weak typeof(self) weakSelf = self;
    NSString * URL = [NSString stringWithFormat:CATEGORY_URL,cellId,update_time];
    //利用第三方库AFNetworking下载网络数据,GET方法
    [weakSelf.manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //把json数据转化为字典
        NSDictionary * AllDataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //找到字典中键值是data的数据，得到的结果是个字典
        NSDictionary * dataDic = AllDataDic[@"data"];
        //找到商品数组
        NSArray * topicArray = dataDic[@"topic"];
        //加入到模型中
        for (NSDictionary * oneDic in topicArray) {
            MainPageModel * oneModel = [[MainPageModel alloc] initWithDictionary:oneDic error:nil];
            [weakSelf.dataArray addObject:oneModel];
        }
        [weakSelf.tableView reloadData];
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"下载失败:%@",error);
    }];

    
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


// - 下拉 -
- (void)headerRefreshing {
    [self performSelector:@selector(refreshData) withObject:nil afterDelay:2.0];
}
- (void)refreshData {
    //在此处进行网络数据的加载
    //NSLog(@"更新数据");
    //插入的数据
    //MainModel * oneModel = self.dataArray.lastObject;
    [self.dataArray removeAllObjects];
    self.update_time = 0;
    [self downLoadWithURL:self.update_time andCellId:self.cellId];
    // 动画效果
    CATransition * transaction = [CATransition animation];
    transaction.type = @"rippleEffect";
    transaction.duration = 1;
    [self.tableView.layer addAnimation:transaction forKey:nil];
    //刷新界面
    [self.tableView reloadData];
    //结束刷新
    [self.tableView headerEndRefreshing];
}
// - 上拉 -
- (void)footerRefreshing {
    [self performSelector:@selector(loadMoreData) withObject:nil afterDelay:2.0];
}
- (void)loadMoreData {
    //此处加载新的数据
    ///////////////////
    MainPageModel * oneModel = self.dataArray.lastObject;
    self.update_time = oneModel.update_time;
    [self downLoadWithURL:self.update_time andCellId:self.cellId];
    // 动画效果
    CATransition * transaction = [CATransition animation];
    transaction.type = @"rippleEffect";
    transaction.duration = 1;
    [self.tableView.layer addAnimation:transaction forKey:nil];
    //刷新界面
    [self.tableView reloadData];
    //结束刷新
    [self.tableView footerEndRefreshing];
}


#pragma mark - 创建表格视图以及表格视图的代理方法 -
- (void)creatTableVew {
    self.dataArray = [[NSMutableArray alloc] init];
    self.bannerImagesArray = [[NSMutableArray alloc] init];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    [self.tableView registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:nil] forCellReuseIdentifier:@"MaintableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    //设置没有cell的cell分割线隐藏
    self.tableView.tableFooterView = [[UIView alloc] init];
}
#pragma mark - 表格视图的代理方法 -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //NSLog(@"%ld",self.dataArray.count);
    return self.dataArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MaintableViewCell" forIndexPath:indexPath];
    //NSLog(@"--------%@",self.dataArray);
    ///////////////////
    MainPageModel * model = self.dataArray[indexPath.row];
    //NSLog(@"-----%@",model);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell showDataWithModel:model andIndexPath:indexPath];
    return cell;
}
//点击了某一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"点击了第%ld行",indexPath.row);
    //[self touchNavigationBarBack];
    /////////////
    MainPageModel * model = self.dataArray[indexPath.row];
    DetailViewController * detailViewController = [[DetailViewController alloc] init];
    detailViewController.mainCell = model.id;
    detailViewController.type = @"class";
    //为以后的收藏做准备
    detailViewController.model = model;
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
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
