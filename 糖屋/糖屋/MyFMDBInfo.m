//
//  MyFMDBInfo.m
//  糖屋
//
//  Created by qianfeng on 15/9/18.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "MyFMDBInfo.h"

@implementation MyFMDBInfo
- (void)dealloc {
    //如果打开成功
    if (_isOpenSuccess) {
        //关闭数据库
        [_dataBase close];
    }
}
//在构造方法中实例化数据库管理对象
- (instancetype)init {
    if (self = [super init]) {
        //实例化管理对象
        _dataBase = [FMDatabase databaseWithPath:[self dataBasePath]];
        //初始化为没有打开
        _isOpenSuccess = NO;
    }
    return self;
}

- (NSString *)dataBasePath {
    return [NSString stringWithFormat:@"%@/Documents/dataBase.rdb",NSHomeDirectory()];
}

#pragma mark - 创建数据库表 -
- (BOOL)open {
    _isOpenSuccess = [_dataBase open];
    //如果没有打开数据库，就不用创建数据库表了
    if (!_isOpenSuccess) {
        return _isOpenSuccess;
    }
    //创建一个收藏信息表
    NSString * createCollectionInfoTable = @"create table if not exists collectionInfoTable (id integer primary key,cellId text,title text,pic text,update_time text,url text,recordType)";
    BOOL createSuccess = [_dataBase executeUpdate:createCollectionInfoTable];
    //如果创建成功，返回打开成功，如果创建失败，就当打开数据库失败，返回失败
    if (!createSuccess) {
        [_dataBase close];
        _isOpenSuccess = NO;
        return _isOpenSuccess;
    }
    return _isOpenSuccess;
}

#pragma mark - 对数据库的操作 -
//增加一条收藏
- (void)insertCollectionWithModel:(MainPageModel *)model andRecordType:(NSString *)type {
    //先判断当前浏览的项目是否已经被加到收藏栏中了
    BOOL result = [self isExistedWithCellId:model.id andRecordType:type];
    if (result) {
        NSLog(@"当前正在浏览的项目已经添加到收藏栏中了");
        return;
    }
    NSString * addInfoTable = @"insert into collectionInfoTable (cellId,title,pic,update_time,url,recordType) values (?,?,?,?,?,?)";
    
    BOOL isSuccess = [_dataBase executeUpdate:addInfoTable,model.id,model.title,model.pic,model.update_time,model.url,type];
    if (isSuccess) {
        //NSLog(@"添加一条新的收藏记录成功");
    } else {
        //NSLog(@"添加一条新的收藏记录失败");
    }
}
//删除一条收藏记录
- (void)deleteOneCollentionWithCellId:(NSString *)cellId andRecordType:(NSString *)type {
    NSString * deleteInfoTable = @"delete from collectionInfoTable where cellId = ? and recordType = ?";
    BOOL isSuccess = [_dataBase executeUpdate:deleteInfoTable,cellId,type];
    if (isSuccess) {
        //NSLog(@"删除一条新的收藏记录成功");
    } else {
        //NSLog(@"删除一条新的收藏记录失败");
    }

}
//读取收藏记录到表格中
- (NSArray *)getdataInfoWithRecordType:(NSString *)type {
    NSString * collectionInfoTable = @"select * from collectionInfoTable where recordType = ?";
    FMResultSet * set = [_dataBase executeQuery:collectionInfoTable,type];
    NSMutableArray * modelArray = [[NSMutableArray alloc] init];
    //固定格式
    while ([set next]) {
        MainPageModel * oneModel = [[MainPageModel alloc] init];
        oneModel.id = [set stringForColumn:@"cellId"];
        oneModel.title = [set stringForColumn:@"title"];
        oneModel.pic = [set stringForColumn:@"pic"];
        oneModel.url = [set stringForColumn:@"url"];
        oneModel.update_time = [set stringForColumn:@"update_time"];
        [modelArray addObject:oneModel];
    }
    return modelArray;
}

//判断当前浏览项目是否已经添加到收藏里面了
- (BOOL)isExistedWithCellId:(NSString *)cellId andRecordType:(NSString *)type {
    NSString * collectionInfoTable = @"select * from collectionInfoTable where cellId = ? and recordType = ?";
    //先查询数据库 确定正在浏览的项目是否已经存在于收藏记录中了
    FMResultSet * collectionInfoTableSet = [_dataBase executeQuery:collectionInfoTable,cellId,type];
    BOOL result = [collectionInfoTableSet next];
    if (result) {
        //存在
        return YES;
    } else {
        //不存在
        return NO;
    }
}
@end
