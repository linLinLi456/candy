//
//  DetailViewController.m
//  糖屋
//
//  Created by qianfeng on 15/9/18.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "DetailViewController.h"
#import "AFNetworking.h"
#import "Path.h"
#import "DetailTableViewCell.h"
#import "DetailModel.h"
#import "MyFMDBInfo.h"
#import "LinkToTaoBaoViewController.h"
#import "TopModel.h"
#import "TopTableViewCell.h"
@interface DetailViewController ()
<UITableViewDataSource,UITableViewDelegate>
{
    // 判断是否已经添加到收藏栏中
    BOOL  _isExist;
    //
    MyFMDBInfo * _myFMDBInfo;
}

// 利用第三方类来异步下载网络数据
@property (nonatomic,strong) AFHTTPRequestOperationManager * manager;
// 请求网络数据的接口
@property (nonatomic,strong) NSString * requestURL;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    // 滑动时隐藏navigationbar
    // self.navigationController.hidesBarsOnSwipe = YES;
    // 创建收藏按钮-----------------------------------------------------------
    if (self.model != nil) {
        UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(addCollentionIntoMyDataBase)];
        // 判断数据中是否已经存在
        _myFMDBInfo = [[MyFMDBInfo alloc] init];
        [_myFMDBInfo open];
        _isExist = [_myFMDBInfo isExistedWithCellId:self.mainCell andRecordType:@"myLove"];
        if (_isExist) {
            UIImage *image = [[UIImage imageNamed:@"stared"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            [rightBtn setImage:image];
            self.navigationItem.rightBarButtonItem = rightBtn;
        } else {
            UIImage *image = [[UIImage imageNamed:@"star"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            [rightBtn setImage:image];
            self.navigationItem.rightBarButtonItem = rightBtn;
        }
    }
        // 创建表格视图
    [self creatTableVew];
    // 滚动的navigationbar
    // [self followRollingScrollView:self.tableView];
    // 初始化manager
    self.manager = [AFHTTPRequestOperationManager manager];
    // 设置服务器响应的格式
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 开始下载数据
    [self firstDownLoad];
}

#pragma mark - 收藏的相关方法 -
- (BOOL)addCollentionIntoMyDataBase {
    
    if (_isExist == NO) {
        UIImage *image = [[UIImage imageNamed:@"stared"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self.navigationItem.rightBarButtonItem setImage:image];
        [_myFMDBInfo insertCollectionWithModel:self.model andRecordType:@"myLove"];
        
    } else {
        UIImage *image = [[UIImage imageNamed:@"star"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self.navigationItem.rightBarButtonItem setImage:image];
        [_myFMDBInfo deleteOneCollentionWithCellId:self.mainCell andRecordType:@"myLove"];
        // 发送一个广播，让收藏界面刷新
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:nil];
        return  _isExist = NO;
    }
    // 发送一个广播，让收藏界面刷新
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:nil];
    return  _isExist = YES;
}

#pragma mark - 创建表格视图以及表格视图的代理方法 -
- (void)creatTableVew {
    self.topArray = [[NSMutableArray alloc] init];
    self.dataArray = [[NSMutableArray alloc] init];
    if ([self.type isEqualToString:@"mainpage"]) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height - 64) style:UITableViewStylePlain];
    } else {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height) style:UITableViewStylePlain];
    }
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"DetailTableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"TopTableViewCell" bundle:nil] forCellReuseIdentifier:@"TopTableViewCell"];
}

#pragma mark - 下载数据的方法 -
- (void)firstDownLoad {
    // self.update_time = 0;
    [self downLoadWithURL:self.mainCell];
    
}

- (void)downLoadWithURL:(NSString *)update_time {
    __weak typeof(self) weakSelf = self;
    NSString * URL = [NSString stringWithFormat:DETAIL_URL,self.mainCell];
    // 利用第三方库AFNetworking下载网络数据,GET方法
    [weakSelf.manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSLog(@"下载成功:%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        // 把json数据转化为字典
        NSDictionary * AllDataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        // NSLog(@"%@",AllDataDic);
        // 找到字典中键值是data的数据，得到的结果是个字典
        NSDictionary * dataDic = AllDataDic[@"data"];
        // NSLog(@"%@",dataDic);
        // 找到产品数组
        NSArray * productArray = dataDic[@"product"];
        // NSLog(@"%@",productArray);
        // 头部的模型数据
        TopModel * oneModel = [[TopModel alloc] initWithDictionary:dataDic error:nil];
        // NSLog(@"%@",oneModel);
        [self.dataArray addObject:oneModel];
        // 加入到模型中
        for (NSDictionary * oneDic in productArray) {
            DetailModel * oneModel = [[DetailModel alloc] initWithDictionary:oneDic error:nil];
            [weakSelf.dataArray addObject:oneModel];
        }
        [weakSelf.tableView reloadData];
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"下载失败:%@",error);
    }];
}

#pragma mark - 表格视图的代理方法 -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (tableView == _topView) {
//        return self.topArray.count;
//    }
    //NSLog(@"%ld",self.dataArray.count);
    return self.dataArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 279;
    }
    return 480;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
    TopTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TopTableViewCell" forIndexPath:indexPath];
                //NSLog(@"--------%@",self.dataArray);
    TopModel * model = self.dataArray[0];
    // NSLog(@"-----%@",model);
    [cell showDataWithModel:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    } else {
    DetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DetailTableViewCell" forIndexPath:indexPath];
    // NSLog(@"--------%@",self.dataArray);
    DetailModel * model = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // NSLog(@"-----%@",model);
    [cell showDataWithModel:model indexPath:indexPath];
        return cell;
    }
    return nil;
}
// 点击进入淘宝界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // NSLog(@"%ld",(long)indexPath.row);
    if (indexPath.row != 0) {
        // [self touchNavigationBarBack];
        DetailModel * model = self.dataArray[indexPath.row];
        LinkToTaoBaoViewController * linkToTaoBaoVC = [[LinkToTaoBaoViewController alloc] init];
        linkToTaoBaoVC.type = self.type;
        linkToTaoBaoVC.taoBaoLink = model.url;
        [self.navigationController pushViewController:linkToTaoBaoVC animated:YES];
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
