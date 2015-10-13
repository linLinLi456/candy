//
//  EveTwoViewController.m
//  糖屋
//
//  Created by qianfeng on 15/9/29.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "EveTwoViewController.h"

@interface EveTwoViewController ()
@property (nonatomic,strong) AFHTTPRequestOperationManager * manager;
@property NSInteger page;
@property (nonatomic,strong) NSMutableArray * leftDataArray;
@property (nonatomic,strong) NSMutableArray * rightDataArray;
@end

@implementation EveTwoViewController
-(instancetype)oinit{
    static EveTwoViewController *DZVC = nil;
    if( !DZVC){
        DZVC  = [[EveTwoViewController alloc]init];
    }
    return DZVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化manager
    self.manager = [AFHTTPRequestOperationManager manager];
    // 设置服务器响应的格式
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self firstDownLoad];
    [self setRefreshData];
}
- (void)firstDownLoad {
    self.page = 0;
    [self downLoadWithURLCategory:self.category andPage:self.page];
}


- (void)downLoadWithURLCategory:(NSInteger)category andPage:(NSInteger)page {
    __weak typeof(self) weakSelf = self;
    NSString * URL = [NSString stringWithFormat:EVERDAY_CATEGORY_URL,category,page];
    [weakSelf.manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (page == 0) {
            [weakSelf.leftDataArray removeAllObjects];
            [weakSelf.rightDataArray removeAllObjects];
        }
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
        // 访问失败，从缓存中读取数据
        
    }];
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
    [self downLoadWithURLCategory:self.category andPage:self.page];
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
