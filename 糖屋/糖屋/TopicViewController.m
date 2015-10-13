//
//  TopicViewController.m
//  糖屋
//
//  Created by qianfeng on 15/9/25.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "TopicViewController.h"
#import "Path.h"
#import "TopicModel.h"
#import "TopicListTableViewCell.h"
#import "BestChosenModel.h"
#import "TopicContentViewController.h"
#import "EveryDayChosenViewController.h"

@interface TopicViewController ()
<UITableViewDataSource,UITableViewDelegate>
//用来存储商品数据的数组
@property (nonatomic,strong) NSMutableArray * dataArray;
//表格视图
@property (nonatomic,strong) UITableView * tableView;
//利用第三方类来异步下载网络数据
@property (nonatomic,strong) AFHTTPRequestOperationManager * manager;
//请求网络数据的接口
@property (nonatomic,copy) NSString * requestURL;

@end

@implementation TopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"话题";
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatViews:self.title];
    // 创建表格视图
    [self creatTableVew];
    // 滚动的navigationbar
    [self followRollingScrollView:self.tableView];
    // 初始化manager
    self.manager = [AFHTTPRequestOperationManager manager];
    // 设置服务器响应的格式
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self firstDownLoad];
    [self setRefreshData];
}
#pragma mark - 开始下载 -
- (void)firstDownLoad {
    [self downLoadWithURL:0];
}
- (void)downLoadWithURL:(NSInteger)update_time {
    __weak typeof(self) weakSelf = self;
    NSString * URL = [NSString stringWithFormat:BESTCHOSEN_URL,update_time];
    [weakSelf.manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * AllDataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        // 找到字典中键值是data的数据，得到的结果是个字典
        NSDictionary * dataDic = AllDataDic[@"data"];
        // 找到商品数组
        NSArray * subjectArray = dataDic[@"subject"];
        
        if (subjectArray.count == 0) {
            return ;
        }
        
        for (NSDictionary * oneDic in subjectArray) {
            TopicModel * oneModel = [[TopicModel alloc] initWithDictionary:oneDic error:nil];
            // NSLog(@"%@",oneModel);
            [self.dataArray addObject:oneModel];
            // NSLog(@"%@",self.dataArray);
        }
        [weakSelf.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 访问失败，从缓存中读取数据
        NSData * responseObject = [CacheFunc getDataFromCacheWith:BESTCHOSEN_CACHE andUpdateTime:0];
        if (responseObject == nil) {
            return ;
        }
        NSDictionary * AllDataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
       // 找到字典中键值是data的数据，得到的结果是个字典
        NSDictionary * dataDic = AllDataDic[@"data"];
        // 找到商品数组
        NSArray * subjectArray = dataDic[@"subject"];
        for (NSDictionary * oneDic in subjectArray) {
            TopicModel * oneModel = [[TopicModel alloc] initWithDictionary:oneDic error:nil];
            [weakSelf.dataArray addObject:oneModel];
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
}
// - 下拉 -
- (void)headerRefreshing {
    [self performSelector:@selector(refreshData) withObject:nil afterDelay:1.0];
}
- (void)refreshData {
    // 插入的数据
    [self.dataArray removeAllObjects];
    [self downLoadWithURL:0];
    // 刷新界面
    [self.tableView reloadData];
    // 结束刷新
    [self.tableView headerEndRefreshing];
}


#pragma mark - 创建表格视图以及表格视图的代理方法 -
- (void)creatTableVew {
    self.dataArray = [[NSMutableArray alloc] init];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height - 64) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:@"TopicListTableViewCell" bundle:nil] forCellReuseIdentifier:@"TopicListTableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
}
#pragma mark - 表格视图的代理方法 -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TopicListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TopicListTableViewCell" forIndexPath:indexPath];
    // 设置点击的时候不显示选中的灰色背景
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // NSLog(@"--------%@",self.dataArray);
    TopicModel * model = self.dataArray[indexPath.row];
    // NSLog(@"-----%@",model);
    [cell showDataWithModel:model andIndexPath:indexPath];
    return cell;
}
// 点击了表格的某一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // NSLog(@"点击了第%ld行",indexPath.row);
    // 点击显示navigationbar  解决bug
    [self touchNavigationBarBack];
    // 头部的视图的点击事件不同与其他的界面
    if (indexPath.row == 0) {
        EveryDayChosenViewController * everyDayVC = [[EveryDayChosenViewController alloc] init];
        everyDayVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:everyDayVC animated:YES];
    } else {
        TopicModel * model = self.dataArray[indexPath.row];
        TopicContentViewController * topicContentViewController = [[TopicContentViewController alloc] init];
        topicContentViewController.subject_id = model.id;
        topicContentViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:topicContentViewController animated:YES];
    }
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
