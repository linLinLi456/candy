//
//  SearchViewController.m
//  糖屋
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "SearchViewController.h"
#import "Path.h"
#import "SearchTableViewCell.h"
#import "SearchModel.h"
#import "DetailViewController.h"
#import "MainPageModel.h"
#import "MJRefresh.h"
@interface SearchViewController ()
<UITableViewDataSource,UITableViewDelegate>
//利用第三方类来异步下载网络数据
@property (nonatomic,strong) AFHTTPRequestOperationManager * manager;
//请求网络数据的接口
@property (nonatomic,copy) NSString * requestURL;
@property (nonatomic,strong) NSMutableArray * dataArray;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"结果";
    //导航条返回键带的title让它消失
    [[UIBarButtonItem appearance]setBackButtonTitlePositionAdjustment:UIOffsetMake(0,-60)forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    NSDictionary * attributeDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:19],NSFontAttributeName, [UIColor whiteColor],NSForegroundColorAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributeDic];
    [self creatTableVew];
    //初始化manager
    self.manager = [AFHTTPRequestOperationManager manager];
    //设置服务器响应的格式
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self firstDownLoad];
    [self setRefreshData];

}
- (void)firstDownLoad {
    self.classPage = 0;
    [self downLoadWithURL:self.classPage andKeyword:self.keyword];
}
- (void)downLoadWithURL:(NSInteger)classPage andKeyword:(NSString *)keyword {
    __weak typeof(self) weakSelf = self;
    NSString * URL = [NSString stringWithFormat:SEARCH_CLASSFICATION_URL,keyword,classPage];
    [weakSelf.manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * AllDataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //找到字典中键值是data的数据，得到的结果是个字典
        NSArray * allDataArray = AllDataDic[@"data"];
        for (NSDictionary * oneDic in allDataArray) {
            SearchModel * oneModel = [[SearchModel alloc] initWithDictionary:oneDic error:nil];
            [weakSelf.dataArray addObject:oneModel];
            [weakSelf.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
#pragma mark - 创建表格视图以及表格视图的代理方法 -
- (void)creatTableVew {
    self.dataArray = [[NSMutableArray alloc] init];
    //self.bannerImagesArray = [[NSMutableArray alloc] init];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchTableViewCell" bundle:nil] forCellReuseIdentifier:@"SearchTableViewCell"];
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
    SearchTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SearchTableViewCell" forIndexPath:indexPath];
    //设置点击的时候不显示选中的灰色背景
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //NSLog(@"--------%@",self.dataArray);
    SearchModel * model = self.dataArray[indexPath.row];
    //NSLog(@"-----%@",model);
    [cell showDataWithModel:model andIndexPath:indexPath];
    return cell;
}
//点击了某一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MainPageModel * model = self.dataArray[indexPath.row];
    DetailViewController * detailViewController = [[DetailViewController alloc] init];
    detailViewController.mainCell = model.id;
    detailViewController.type = @"search";
    //为以后的收藏做准备
    //detailViewController.model = model;
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:detailViewController animated:YES];
}


#pragma mark - 刷新数据的方法 -
- (void)setRefreshData {
    //添加上拉刷新
    [self.tableView addFooterWithTarget:self action:@selector(footerRefreshing)];
    //设置底部提示
    self.tableView.footerPullToRefreshText = @"继续向上拉可以刷新";
    self.tableView.footerReleaseToRefreshText = @"松开即可刷新";
    self.tableView.footerRefreshingText = @"正在加载中";
}
// - 上拉 -
- (void)footerRefreshing {
    [self performSelector:@selector(loadMoreData) withObject:nil afterDelay:1.0];
}
- (void)loadMoreData {
    //此处加载新的数据
    self.classPage = self.classPage + 1;
    [self downLoadWithURL:self.classPage andKeyword:self.keyword];
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
