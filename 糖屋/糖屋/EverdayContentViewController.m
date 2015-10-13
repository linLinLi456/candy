//
//  EverdayContentViewController.m
//  糖屋
//
//  Created by qianfeng on 15/9/28.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "EverdayContentViewController.h"
#import "EveOneViewController.h"


@interface EverdayContentViewController ()
<UITableViewDelegate,UITableViewDataSource>
// 利用第三方类来异步下载网络数据
@property (nonatomic,strong) AFHTTPRequestOperationManager * manager;
@property NSInteger page;
@property (nonatomic,strong) NSMutableArray * leftDataArray;
@property (nonatomic,strong) NSMutableArray * rightDataArray;
@end

@implementation EverdayContentViewController
-(instancetype)oinit{
    static EverdayContentViewController *DZVC = nil;
    if( !DZVC){
        DZVC  = [[EverdayContentViewController alloc]init];
    }
    return DZVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 用来存储左边数据的容器
    self.leftDataArray = [[NSMutableArray alloc] init];
    // 用来存储右边数据的容器
    self.rightDataArray = [[NSMutableArray alloc] init];
    // 创建左右表格
    [self createTableViews];
    // 初始化manager
    self.manager = [AFHTTPRequestOperationManager manager];
    // 设置服务器响应的格式
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self firstDownLoad];
    [self setRefreshData];
}

- (void)firstDownLoad {
    self.page = 0;
    [self downLoadWithURLCategory:0 andPage:self.page];
}
- (void)downLoadWithURLCategory:(NSInteger)category andPage:(NSInteger)page {
    __weak typeof(self) weakSelf = self;
    NSString * URL = [NSString stringWithFormat:EVERDAY_CHOSEN_URL,page];
    [weakSelf.manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 把json数据转化为字典
        NSDictionary * AllDataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"%@",AllDataDic);
        NSDictionary * dataDic = AllDataDic[@"data"];
        NSArray * array = dataDic[@"product"];
        //NSLog(@"%@",array);
        for (int i = 0; i < array.count; i++) {
            NSDictionary * oneDic = array[i];
            EverdayModel * oneModel = [[EverdayModel alloc] initWithDictionary:oneDic error:nil];
            if (i % 2 == 0) {
                [weakSelf.leftDataArray addObject:oneModel];
            } else {
            //NSLog(@"%@",oneModel);
            [weakSelf.rightDataArray addObject:oneModel];
            }
        }
        [weakSelf.leftTableView reloadData];
        [weakSelf.rightTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"下载失败%@",error);
    }];
}
#pragma mark - 创建左右表格 -
- (void)createTableViews {
    // 创建表格视图
    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width / 2, SCREEN_SIZE.height - 100) style:UITableViewStylePlain];
    [self.view addSubview:self.leftTableView];
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    //_leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//隐藏单元格线
    self.leftTableView.showsVerticalScrollIndicator = NO;//隐藏侧边滚动条
    [self.leftTableView registerNib:[UINib nibWithNibName:@"EverdayChosenTableViewCell" bundle:nil] forCellReuseIdentifier:@"EverdayChosenTableViewCell"];
    self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_SIZE.width / 2, 0, SCREEN_SIZE.width / 2, SCREEN_SIZE.height - 100) style:UITableViewStylePlain];
    [self.view addSubview:self.rightTableView];
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    //_rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//隐藏单元格线
    self.rightTableView.showsVerticalScrollIndicator = NO;//隐藏侧边滚动条
    [self.rightTableView registerNib:[UINib nibWithNibName:@"EverdayChosenTableViewCell" bundle:nil] forCellReuseIdentifier:@"EverdayChosenTableViewCell"];
    self.rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


#pragma mark - 刷新数据的方法 -
- (void)setRefreshData {
    // 添加上拉刷新
    [self.leftTableView addFooterWithTarget:self action:@selector(footerRefreshing)];
    // 设置底部提示
    self.leftTableView.footerPullToRefreshText = @"继续向上拉可以刷新";
    self.leftTableView.footerReleaseToRefreshText = @"松开即可刷新";
    self.leftTableView.footerRefreshingText = @"正在加载中";
}
// - 上拉 -
- (void)footerRefreshing {
    [self performSelector:@selector(loadMoreData) withObject:nil afterDelay:1.0];
}
- (void)loadMoreData {
    self.page = self.page + 1;
    [self downLoadWithURLCategory:0 andPage:self.page];
    // 动画效果
    CATransition * transaction = [CATransition animation];
    transaction.type = @"rippleEffect";
    transaction.duration = 1;
    [self.view.layer addAnimation:transaction forKey:nil];
    // 刷新界面
    [self.leftTableView reloadData];
    // 结束刷新
    [self.leftTableView footerEndRefreshing];
}


#pragma mark - 代理方法 -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return self.leftDataArray.count;
    }
    return self.rightDataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EverdayChosenTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EverdayChosenTableViewCell" forIndexPath:indexPath];
    // 设置点击的时候不显示选中的灰色背景
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (tableView == self.leftTableView) {
        EverdayModel * model = self.leftDataArray[indexPath.row];
        [cell showDataWithModel:model andIndexPath:indexPath];
    } else {
    EverdayModel * model = self.rightDataArray[indexPath.row];
    [cell showDataWithModel:model andIndexPath:indexPath];
    }
    return cell;
}
// 点击进入淘宝界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TaoBaoViewController * linkToTaoBaoVC = [[TaoBaoViewController alloc] init];
    if (tableView == self.leftTableView) {
        EverdayModel * oneModel = self.leftDataArray[indexPath.row];
        linkToTaoBaoVC.taoBaoLink = oneModel.url;
        // 此方法可解决bug:Presenting view controllers on detached view controllers is discouraged
        [self.view.window.rootViewController presentViewController:linkToTaoBaoVC animated:YES completion:nil];
    } else {
        // NSLog(@"%ld",(2 * (long)indexPath.row ) + 1);
        EverdayModel * oneModel = self.rightDataArray[indexPath.row];
        linkToTaoBaoVC.taoBaoLink = oneModel.url;
        [self.view.window.rootViewController presentViewController:linkToTaoBaoVC animated:YES completion:nil];
    }
    
}
// 解决左右tableView的同步问题
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.leftTableView) {
        [self.rightTableView setContentOffset:scrollView.contentOffset];
    } else {
        [self.leftTableView setContentOffset:scrollView.contentOffset];
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
