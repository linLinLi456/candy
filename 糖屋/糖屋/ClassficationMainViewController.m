//
//  ClassficationMainViewController.m
//  糖屋
//
//  Created by qianfeng on 15/9/21.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "ClassficationMainViewController.h"
#import "Path.h"
#import "ClassfictaionCollectionViewCell.h"
#import "ClassficationViewController.h"
#import "YRSideViewController.h"
#import "SearchViewController.h"

@interface ClassficationMainViewController ()
<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UISearchBarDelegate>
@property (nonatomic,strong) UICollectionView * classificationCV;
//导航栏的搜索栏
@property (nonatomic,strong) UISearchBar * searchBar;
@end

@implementation ClassficationMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:198/255.0f green:79/255.0f blue:75/255.0f alpha:1.0];
    //创建搜索栏
    [self creatSearchVC];
    [self creatCollectionView];
}
//创建瀑布流
- (void)creatCollectionView {
    //布局类UICollectionViewLayout
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //设置item之间的最小间距
    flowLayout.minimumInteritemSpacing = 10;
    //设置行间距。
    flowLayout.minimumLineSpacing = 15;
    //全局设置item的大小
    flowLayout.itemSize = CGSizeMake(SCREEN_SIZE.width/2-20, 65);
    //实例化collectionView对象
    self.classificationCV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height) collectionViewLayout:flowLayout];
    [self.view addSubview:self.classificationCV];
    self.classificationCV.backgroundColor = [UIColor whiteColor];
    //设置代理
    self.classificationCV.delegate = self;
    self.classificationCV.dataSource = self;
    //注册cell
    [self.classificationCV registerClass:[ClassfictaionCollectionViewCell class] forCellWithReuseIdentifier:@"ClassfictaionCollectionViewCell"];
    //分割线
    {
    UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(5,10, SCREEN_SIZE.width-10, 1)];
    topLineView.alpha = 0.2;
    topLineView.backgroundColor = [UIColor grayColor];
    [self.classificationCV addSubview:topLineView];
    
    UIView * bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(5,454, SCREEN_SIZE.width-10, 1)];
    bottomLineView.alpha = 0.2;
    bottomLineView.backgroundColor = [UIColor grayColor];
    [self.classificationCV addSubview:bottomLineView];
    
    UIView * leftLineView = [[UIView alloc] initWithFrame:CGRectMake(5,11, 1, 443)];
    leftLineView.alpha = 0.2;
    leftLineView.backgroundColor = [UIColor grayColor];
    [self.classificationCV addSubview:leftLineView];
    
    UIView * rightLineView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_SIZE.width-5,11, 1, 443)];
    rightLineView.alpha = 0.2;
    rightLineView.backgroundColor = [UIColor grayColor];
    [self.classificationCV addSubview:rightLineView];
    
    for (NSInteger i = 0; i < 5; i++) {
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(10,84+i*74, SCREEN_SIZE.width-20, 1)];
        lineView.alpha = 0.2;
        lineView.backgroundColor = [UIColor grayColor];
        [self.classificationCV addSubview:lineView];
    }
    for (NSInteger i = 0; i < 6; i++) {
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_SIZE.width/2-1,25+i*74, 1, 44)];
        lineView.alpha = 0.2;
        lineView.backgroundColor = [UIColor grayColor];
        [self.classificationCV addSubview:lineView];
    }
    }
}




#pragma mark - 瀑布流代理方法 -
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 12;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ClassfictaionCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ClassfictaionCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    [cell creatCollectionCellWithIndexPath:indexPath];
    return cell;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(150,60);
}
//点击了图片
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    NSArray * nameArray = @[@"家居",@"创意",@"办公",@"卫浴",@"护肤",@"美食",@"主题",@"植物",@"厨具",@"杂货",@"运动",@"数码"];
    ClassficationViewController * classficationVC = [[ClassficationViewController alloc] init];
    classficationVC.hidesBottomBarWhenPushed = YES;
    //classficationVC.cellId = [NSString stringWithFormat:@"%ld",indexPath.row];
    if (indexPath.row >= 6 && indexPath.row <=8) {
        classficationVC.cellId = [NSString stringWithFormat:@"%ld",indexPath.row+2];
    }else if (indexPath.row >= 9 && indexPath.row <=11) {
        classficationVC.cellId = [NSString stringWithFormat:@"%ld",indexPath.row+3];
    }else{
        classficationVC.cellId = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    }
    classficationVC.title = [nameArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:classficationVC animated:YES];
    //NSLog(@"%@",indexPath);
    
}

#pragma mark - 搜索栏的相关方法 -
- (void)creatSearchVC {
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(50, 0, SCREEN_SIZE.width - 60, 25)];
    self.searchBar.delegate = self;
    [self.searchBar setTintColor:[UIColor colorWithRed:198/255.0f green:79/255.0f blue:75/255.0f alpha:1.0]];
    [self.searchBar setPlaceholder:@"搜索感兴趣的产品"];
    self.navigationItem.titleView = self.searchBar;
    
}
//监听searchBar已经更新
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    SearchViewController * searchVC = [[SearchViewController alloc] init];
    searchVC.keyword = [searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVC animated:YES];
    //NSLog(@"%@",searchBar.text);
}
//点击搜索栏的时候就显示取消的按钮
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
     UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = item;
}
//点击取消的按钮，收回键盘，取消按钮消失
- (void) back {
    [UIView animateWithDuration:0.2 animations:^{
        
        self.navigationItem.rightBarButtonItem = nil;
    }];
    
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
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
