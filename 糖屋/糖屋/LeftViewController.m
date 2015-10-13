//
//  LeftViewController.m
//  糖屋
//
//  Created by qianfeng on 15/9/19.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "LeftViewController.h"
#import "Path.h"
#import "CacheFunc.h"
@interface LeftViewController ()
<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    //表格
    UITableView * _tableView;
    //
    NSMutableArray * _dataArray;
}
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIButton *changeIconImage;
@property (nonatomic,strong) CacheFunc * cacheFunc;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.iconImageView.layer.cornerRadius = self.iconImageView.frame.size.height / 2;
    self.iconImageView.layer.masksToBounds = YES;
    self.changeIconImage.layer.cornerRadius = 10;
    self.changeIconImage.layer.masksToBounds = YES;
    [self creatTableViews];
}
//设置表格并初始化数组
- (void)creatTableViews {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_SIZE.width, SCREEN_SIZE.height - 350) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _dataArray = [[NSMutableArray alloc] init];
    NSArray * clearArray = [[NSArray alloc] initWithObjects:@"清理缓存", nil];
    [_dataArray addObject:clearArray];
    NSArray * otherArray = [[NSArray alloc] initWithObjects:@"版本号:V1.0",@"感谢使用糖屋", nil];
    [_dataArray addObject:otherArray];
    //NSLog(@"%@",_dataArray);
    
}
#pragma mark - tableView的代理方法 -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //return 1;
    return _dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return 10;
    return [[_dataArray objectAtIndex:section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellId = @"xxx";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    //设置点击的时候不显示选中的灰色背景
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [[_dataArray objectAtIndex:section] objectAtIndex:row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [self clearMyInfo];
    }
}

/*
 NSFileManager * fileManager = [[NSFileManager alloc]init];
 
 [fileManager removeItemAtPath:@"你的文件路径" error:nil];
 */
#pragma mark - 点击清除缓存 -
- (void)clearMyInfo {
    //NSLog(@"...");
    NSString * path = [NSString stringWithFormat:@"%@/Library/Caches/updataTime/",NSHomeDirectory()];
    self.cacheFunc = [[CacheFunc alloc] init];
    float info = [self.cacheFunc fileSizeForDir:path];
    //NSLog(@"%f",info);
    //创建一个操作表
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:[NSString stringWithFormat:@"共有缓存%.3f M",info] delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:nil, nil];
    [actionSheet showInView:self.view];
}

//选项操作
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString * path = [NSString stringWithFormat:@"%@/Library/Caches/updataTime/",NSHomeDirectory()];
    //NSLog(@"%lu",buttonIndex);
    if (buttonIndex == 0) {
        NSFileManager * fileManager = [[NSFileManager alloc]init];
        [fileManager removeItemAtPath:path error:nil];
        self.cacheFunc.size = 0;
    }
}
//点击换头像
- (IBAction)changeIconBtnClicked:(id)sender {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    //设置代理
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:^{
    }];
}
#pragma mark - 换头像的代理方法 -
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.iconImageView.image = info[@"UIImagePickerControllerOriginalImage"];
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
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
