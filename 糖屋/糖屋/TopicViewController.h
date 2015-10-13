//
//  TopicViewController.h
//  糖屋
//
//  Created by qianfeng on 15/9/25.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "MainPageViewController.h"
#import "AFNetworking.h"
@interface TopicViewController : MainPageViewController
// 第一次下载网络数据
- (void)firstDownLoad;
// 开始下载数据
- (void)downLoadWithURL:(NSInteger)update_time;
@end
