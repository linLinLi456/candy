//
//  TopicContentViewController.m
//  糖屋
//
//  Created by qianfeng on 15/9/25.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "TopicContentViewController.h"
#import "TopicContentViewController+TopTopicTable.h"
#import "TopTopicTableViewCell.h"
#import "TopTopicModel.h"
#import "UMSocial.h"
@interface TopicContentViewController ()
<UITableViewDataSource,UITableViewDelegate>
@property NSInteger page;
//@property (nonatomic,strong) NSString * subject_id;
@property (nonatomic,strong) NSMutableArray * dataArray;
//利用第三方类来异步下载网络数据
@property (nonatomic,strong) AFHTTPRequestOperationManager * manager;
//请求网络数据的接口
//@property (nonatomic,strong) NSString * requestURL;
@end

@implementation TopicContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"话题";
    
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    UIImage *image = [[UIImage imageNamed:@"shareto.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [rightBtn setImage:image];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    //左边按钮
    self.navigationItem.leftBarButtonItem = nil;
    //初始化manager
    self.manager = [AFHTTPRequestOperationManager manager];
    //设置服务器响应的格式
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //初始化manager
    self.managerTop = [AFHTTPRequestOperationManager manager];
    //设置服务器响应的格式
    self.managerTop.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self creatTableView];
    [self firstDownLoad];
    [self setRefreshData];
}
#pragma mark - 分享 -
- (void)share {
    TopTopicModel * oneModel = self.dataArrayTop[0];
    NSString * shareText = [NSString stringWithFormat:@"有点儿意思:%@%@",oneModel.description,oneModel.share_url];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5610e2cd67e58e287400081e"
                                      shareText:shareText
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,nil]
                                       delegate:nil];
}
#pragma mark - 开始下载 -
- (void)firstDownLoad {
    self.page = 0;
    [self downLoadWithURLSubject_id:self.subject_id];
    [self downLoadWithURL:self.page andSubject_id:self.subject_id];
}
- (void)downLoadWithURL:(NSInteger)page andSubject_id:(NSString *)subject_id {
    __weak typeof(self) weakSelf = self;
    NSString * URL = [NSString stringWithFormat:TOPIC_DISCRSS_URL,page,subject_id];
    [weakSelf.manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * AllDataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //找到字典中键值是data的数据，得到的结果是个字典
        NSDictionary * dataDic = AllDataDic[@"data"];
        //找到商品数组
        NSArray * listArray = dataDic[@"list"];
        //NSLog(@"%ld",listArray.count);
        for (NSDictionary * oneDic in listArray) {
            BestChosenModel * oneModel = [[BestChosenModel alloc] initWithDictionary:oneDic error:nil];
            [weakSelf.dataArray addObject:oneModel];
        }
        [weakSelf.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"下载失败%@",error);
    }];
}

//初始化表格
- (void)creatTableView {
    self.dataArrayTop = [[NSMutableArray alloc] init];
    self.dataArray = [[NSMutableArray alloc] init];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height - 64) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    [self.tableView registerNib:[UINib nibWithNibName:@"BestChosenTableViewCell" bundle:nil] forCellReuseIdentifier:@"BestChosenTableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    //设置没有cell的cell分割线隐藏
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:@"TopTopicTableViewCell" bundle:nil] forCellReuseIdentifier:@"TopTopicTableViewCell"];
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
    self.page = 0;
    [self downLoadWithURL:self.page andSubject_id:self.subject_id];
    
    // 动画效果
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
    self.page = self.page + 1;
    [self downLoadWithURL:self.page andSubject_id:self.subject_id];
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


#pragma mark - 表格的代理方法 -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 300;
    }
    return 483;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //[self touchNavigationBarBack];
    if (indexPath.row == 0) {
        TopTopicTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TopTopicTableViewCell" forIndexPath:indexPath];
        //设置点击的时候不显示选中的灰色背景
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.dataArrayTop.count == 0) {
            return cell;
        }
        TopTopicModel * oneModel = self.dataArrayTop[indexPath.row];
        [cell showDataWithModel:oneModel andIndexPath:indexPath];
        return cell;
    }
    BestChosenTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BestChosenTableViewCell" forIndexPath:indexPath];
    //设置点击的时候不显示选中的灰色背景
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BestChosenModel * oneModel = self.dataArray[indexPath.row];
    [cell showDataWithModel:oneModel andIndexPath:indexPath];
    return cell;
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
