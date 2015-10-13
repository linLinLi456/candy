//
//  BsetChosenViewController.m
//  糖屋
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "BsetChosenViewController.h"
#import "AdScrollView.h"
#import "AdDataModel.h"
#import "LinkToTaoBaoViewController.h"
#import "MozTopAlertView.h"
@interface BsetChosenViewController ()
<UITableViewDataSource,UITableViewDelegate>
// 用来存储广告图片的数组
@property (nonatomic,strong) NSMutableArray * bannerImagesArray;
//
@property (nonatomic,strong) NSMutableArray * dataArray;
// 利用第三方类来异步下载网络数据
@property (nonatomic,strong) AFHTTPRequestOperationManager * manager;
//
@property (nonatomic,strong) AFHTTPRequestOperationManager * taoBaoManager;
// 请求网络数据的接口
@property (nonatomic,copy) NSString * requestURL;
//
@property NSInteger pageNum;
//
@property (nonatomic,copy) NSString * taobaoLink;
@end

@implementation BsetChosenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"精选";
    [self creatViews:self.title];
    // 初始化表格
    [self creatTableView];
    // 滚动的navigationbar
    [self followRollingScrollView:self.tableView];
    
    
    // 初始化manager
    self.manager = [AFHTTPRequestOperationManager manager];
    // 设置服务器响应的格式
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    // 初始化manager
    self.taoBaoManager = [AFHTTPRequestOperationManager manager];
    // 设置服务器响应的格式
    self.taoBaoManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 开始下载
    [self firstDownLoad];
    // 刷新
    [self setRefreshData];

}
#pragma mark - 开始下载 -
- (void)firstDownLoad {
    self.pageNum = 0;
    [self downLoadWithURL:self.pageNum andSubject_id:nil];
}
- (void)downLoadWithURL:(NSInteger)page andSubject_id:(NSString *)subject_id{
    __weak typeof(self) weakSelf = self;
    NSString * URL = [NSString stringWithFormat:BESTCHOSEN_URL,page];
    [weakSelf.manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 访问数据成功，把数据保存到缓存中
        [CacheFunc saveDataToCacheWith:BESTCHOSEN_CACHE andUpdateTime:self.pageNum andData:responseObject];
        // 把json数据转化为字典
        NSDictionary * AllDataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        // 找到字典中键值是data的数据，得到的结果是个字典
        NSDictionary * dataDic = AllDataDic[@"data"];
        // 找到商品数组
        NSArray * listArray = dataDic[@"list"];
        
        if (listArray.count == 0) {
            return ;
        }
        for (NSDictionary * oneDic in listArray) {
            BestChosenModel * oneModel = [[BestChosenModel alloc] initWithDictionary:oneDic error:nil];
            [weakSelf.dataArray addObject:oneModel];
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 访问失败，从缓存中读取数据
        NSData * responseObject = [CacheFunc getDataFromCacheWith:BESTCHOSEN_CACHE andUpdateTime:weakSelf.pageNum];
        // 如果缓存中也没有数据，就直接返回
        if (responseObject == nil) {
            return ;
        }
        NSDictionary * AllDataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        // 找到字典中键值是data的数据，得到的结果是个字典
        NSDictionary * dataDic = AllDataDic[@"data"];
        // 找到商品数组
        NSArray * listArray = dataDic[@"list"];
        for (NSDictionary * oneDic in listArray) {
            BestChosenModel * oneModel = [[BestChosenModel alloc] initWithDictionary:oneDic error:nil];
            [weakSelf.dataArray addObject:oneModel];
        }
        [weakSelf.tableView reloadData];
    }];
}
// 初始化表格
- (void)creatTableView {
    self.dataArray = [[NSMutableArray alloc] init];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height - 70) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    [self.tableView registerNib:[UINib nibWithNibName:@"BestChosenTableViewCell" bundle:nil] forCellReuseIdentifier:@"BestChosenTableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    // 设置没有cell的cell分割线隐藏
    self.tableView.tableFooterView = [[UIView alloc] init];
    //创建头部的滚动视图
    //[self creatScrollView];
}

#pragma mark - 头部的滚动新闻视图 -
- (void)setTopNewsWithNewsArray:(NSMutableArray *)array {
    self.bannerImagesArray = [[NSMutableArray alloc] init];
    self.bannerImagesArray = array;
}
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



#pragma mark - 表格的代理方法 -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 483;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BestChosenTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BestChosenTableViewCell" forIndexPath:indexPath];
    // 设置点击的时候不显示选中的灰色背景
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BestChosenModel * oneModel = self.dataArray[indexPath.row];
    [cell showDataWithModel:oneModel andIndexPath:indexPath];
    return cell;
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
    self.tableView.footerRefreshingText = @"正在加载中";}


// - 下拉 -
- (void)headerRefreshing {
    [self performSelector:@selector(refreshData) withObject:nil afterDelay:1.0];
}
- (void)refreshData {
    // 在此处进行网络数据的加载
    // NSLog(@"更新数据");
    // 插入的数据
    [self.dataArray removeAllObjects];
    self.pageNum = 0;
    [self downLoadWithURL:self.pageNum andSubject_id:nil];
    // 动画效果
    CATransition * transaction = [CATransition animation];
    transaction.type = @"rippleEffect";
    transaction.duration = 1;
    [self.tableView.layer addAnimation:transaction forKey:nil];
    // 刷新界面
    [self.tableView reloadData];
    //结束刷新
    [self.tableView headerEndRefreshing];
}
// - 上拉 -
- (void)footerRefreshing {
    [self performSelector:@selector(loadMoreData) withObject:nil afterDelay:1.0];
}
- (void)loadMoreData {
    // 此处加载新的数据
    self.pageNum = self.pageNum + 1;
    [self downLoadWithURL:self.pageNum andSubject_id:nil];
    CATransition * transaction = [CATransition animation];
    transaction.type = @"rippleEffect";
    transaction.duration = 1;
    [self.tableView.layer addAnimation:transaction forKey:nil];
    // 刷新界面
    [self.tableView reloadData];
    // 结束刷新
    [self.tableView footerEndRefreshing];
}


// 点击了表格的某一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 点击显示navigationbar  解决bug
    [self touchNavigationBarBack];
    BestChosenModel * model = self.dataArray[indexPath.row];
    LinkToTaoBaoViewController * linkToTaoBaoVC = [[LinkToTaoBaoViewController alloc] init];
    linkToTaoBaoVC.type = @"mainpage";
    NSString * URL = [NSString stringWithFormat:BESTCHOSEN_TOTAOBAO_URL,model.id];
    //self.taobaoLink = [[NSString alloc] init];
    [self.manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 把json数据转化为字典
        NSDictionary * AllDataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"%@",AllDataDic);
        NSDictionary * dataDic = AllDataDic[@"data"];
        NSDictionary * postDic = dataDic[@"post"];
        NSArray * productArray = postDic[@"product"];
        if (productArray.count != 0) {
            NSDictionary * taobaoDic = productArray[0];
            linkToTaoBaoVC.taoBaoLink = taobaoDic[@"url"];
        } else {
            [MozTopAlertView showWithType:MozAlertTypeWarning text:@"暂无此商品的淘宝链接" parentView:self.view];
            return ;
        }
            linkToTaoBaoVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:linkToTaoBaoVC animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"%@",error);
        linkToTaoBaoVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:linkToTaoBaoVC animated:YES];
    }];
    
    
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
