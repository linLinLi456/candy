//
//  MyFMDBInfo.h
//  糖屋
//
//  Created by qianfeng on 15/9/18.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainPageModel.h"
#import "FMDB.h"



@interface MyFMDBInfo : NSObject
{
    //记录是否打开成功
    BOOL _isOpenSuccess;
    //创建数据库管理对象
    FMDatabase * _dataBase;
}
//打开成功
- (BOOL)open;
//插入一条数据，表示新加入一条收藏   第一个参数表示插入的数据模型  第二个参数是标记
- (void)insertCollectionWithModel:(MainPageModel *)model andRecordType:(NSString *)type;
//删除一条收藏记录 根据其cellId来删除
- (void)deleteOneCollentionWithCellId:(NSString *)cellId andRecordType:(NSString *)type;
//判断正在浏览的这一项是否已经被收藏了
- (BOOL)isExistedWithCellId:(NSString *)cellId andRecordType:(NSString *)type;
//获取表中的信息
- (NSArray *)getdataInfoWithRecordType:(NSString *)type;
@end
