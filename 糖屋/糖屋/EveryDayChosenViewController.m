//
//  EveryDayChosenViewController.m
//  糖屋
//
//  Created by qianfeng on 15/9/28.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "EveryDayChosenViewController.h"
#import "Path.h"
#import "EverdayChosenTableViewCell.h"
#import "EverdayContentViewController.h"
#import "EveOneViewController.h"
#import "EveTwoViewController.h"
#import "EveThreeViewController.h"
#import "EveFourViewController.h"
#import "EveFiveViewController.h"
#define title_color [UIColor colorWithRed:255/255.0 green:90/255.0 blue:90/255.0 alpha:1.0]
@interface EveryDayChosenViewController ()
<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView * tableView;
@end

@implementation EveryDayChosenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"每日精选";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSlideBar];
    [self creatTableVew];
}

#pragma mark - 顶部滑动的title -
- (void)setupSlideBar {
    // 用第三方库来设置顶部的滑动的标题栏
    FDSlideBar *sliderBar = [[FDSlideBar alloc] init];
    sliderBar.backgroundColor = [UIColor whiteColor];
    sliderBar.itemsTitle = @[@"全部", @"家居", @"创意", @"食品",@"杂货",@"数码"];
    
    sliderBar.itemColor = [UIColor grayColor];
    sliderBar.itemSelectedColor = title_color;
    sliderBar.sliderColor = title_color;
    
    [sliderBar slideBarItemSelectedCallback:^(NSUInteger idx) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }];
    [self.view addSubview:sliderBar];
    _slideBar = sliderBar;
}

#pragma mark - 创建表格视图以及表格视图的代理方法 -
- (void)creatTableVew {
    CGRect frame = CGRectMake(0, 0, CGRectGetMaxY(self.view.frame) - CGRectGetMaxY(self.slideBar.frame), CGRectGetWidth(self.view.frame));
    self.tableView = [[UITableView alloc] initWithFrame:frame];
    [self.view addSubview:self.tableView];
    
    //self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView.center = CGPointMake(CGRectGetWidth(self.view.frame) * 0.5, CGRectGetHeight(self.view.frame) * 0.5 + CGRectGetMaxY(self.slideBar.frame) * 0.5);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.pagingEnabled = YES;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.allowsSelection = NO;
    self.tableView.tableFooterView = [[UIView alloc]init];
}
#pragma mark - 表格视图的代理方法 -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // NSLog(@"%ld",self.dataArray.count);
    return [self.slideBar.itemsTitle count];;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CGRectGetWidth(self.view.frame);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 设置每一页的视图
    if (indexPath.row == 0) {// 第一页是全部
        NSString * cellId = @"xxx";
        // 运用的是单例来创建对象
        EverdayContentViewController * everdayVC = [[EverdayContentViewController alloc] oinit];
        UITableViewCell * cell = [_tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[EverdayChosenTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            // 旋转180°
            cell.contentView.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
        
        everdayVC.view.frame = CGRectMake(0, 0, CGRectGetHeight(cell.contentView.frame), CGRectGetWidth(cell.contentView.frame));
        [cell.contentView addSubview:everdayVC.view];
        return cell;
    } else if (indexPath.row == 1) {// 第二页是家居
        NSString * cellId = @"xxx";
        EveOneViewController * everdayVC = [[EveOneViewController alloc] oinit];
        everdayVC.category = indexPath.row;
        UITableViewCell * cell = [_tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[EverdayChosenTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.contentView.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
        everdayVC.view.frame = CGRectMake(0, 0, CGRectGetHeight(cell.contentView.frame), CGRectGetWidth(cell.contentView.frame));
        [cell.contentView addSubview:everdayVC.view];
        return cell;
    } else if (indexPath.row == 2) {// 第三页是创意
        NSString * cellId = @"xxx";
        EveTwoViewController * everdayVC = [[EveTwoViewController alloc] oinit];
        everdayVC.category = indexPath.row;
        UITableViewCell * cell = [_tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[EverdayChosenTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.contentView.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
        everdayVC.view.frame = CGRectMake(0, 0, CGRectGetHeight(cell.contentView.frame), CGRectGetWidth(cell.contentView.frame));
        [cell.contentView addSubview:everdayVC.view];
        return cell;

    } else if (indexPath.row == 3) {// 第四页是食品
        NSString * cellId = @"xxx";
        EveThreeViewController * everdayVC = [[EveThreeViewController alloc] oinit];
        everdayVC.category = indexPath.row +3;
        UITableViewCell * cell = [_tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[EverdayChosenTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.contentView.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
        everdayVC.view.frame = CGRectMake(0, 0, CGRectGetHeight(cell.contentView.frame), CGRectGetWidth(cell.contentView.frame));
        [cell.contentView addSubview:everdayVC.view];
        return cell;
        
    } else if (indexPath.row == 4) {// 第五页是杂货
        NSString * cellId = @"xxx";
        EveFourViewController * everdayVC = [[EveFourViewController alloc] oinit];
        everdayVC.category = indexPath.row + 8;
        UITableViewCell * cell = [_tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[EverdayChosenTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.contentView.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
        everdayVC.view.frame = CGRectMake(0, 0, CGRectGetHeight(cell.contentView.frame), CGRectGetWidth(cell.contentView.frame));
        [cell.contentView addSubview:everdayVC.view];
        return cell;
    } else {// 第六页是数码
        NSString * cellId = @"xxx";
        EveFiveViewController * everdayVC = [[EveFiveViewController alloc] oinit];
        everdayVC.category = indexPath.row + 9;
        UITableViewCell * cell = [_tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[EverdayChosenTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.contentView.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
        everdayVC.view.frame = CGRectMake(0, 0, CGRectGetHeight(cell.contentView.frame), CGRectGetWidth(cell.contentView.frame));
        [cell.contentView addSubview:everdayVC.view];
        return cell;
    }
    return nil;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:scrollView.contentOffset];
    
    // Select the relating item when scroll the tableView by paging.
    [self.slideBar selectSlideBarItemAtIndex:indexPath.row];
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
