//
//  TopicContentViewController+TopTopicTable.m
//  糖屋
//
//  Created by qianfeng on 15/9/28.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "TopicContentViewController+TopTopicTable.h"
#import "TopTopicModel.h"
@implementation TopicContentViewController (TopTopicTable)
- (void)downLoadWithURLSubject_id:(NSString *)subject_id {
    __weak typeof(self) weakSelf = self;
    NSString * URL = [NSString stringWithFormat:TOP_TOPIC_DISSUSS_URL,subject_id];
    [weakSelf.managerTop GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //把json数据转化为字典
        NSDictionary * AllDataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //找到字典中键值是data的数据，得到的结果是个字典
        NSDictionary * dataDic = AllDataDic[@"data"];
        //找到商品数组
        NSDictionary * listDic = dataDic[@"subject"];
        TopTopicModel * oneModel = [[TopTopicModel alloc] initWithDictionary:listDic error:nil];
            [self.dataArrayTop addObject:oneModel];
        [weakSelf.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"下载失败%@",error);
    }];
}
@end
