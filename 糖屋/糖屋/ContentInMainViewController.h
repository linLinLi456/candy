//
//  ContentInMainViewController.h
//  糖屋
//
//  Created by qianfeng on 15/9/17.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "MainPageViewController.h"
#import "AFNetworking.h"
#import "TopNewsProtocol.h"

@interface ContentInMainViewController : MainPageViewController
@property (nonatomic,strong) NSMutableArray * bannerImagesArray;
// 用代理将头部视图的广告数据传到发现精选的界面
@property (assign) id<TopNewsProtocol>delegate;

// 第一次下载网络数据
- (void)firstDownLoad;
// 开始下载数据
- (void)downLoadWithURL:(NSString *)update_time;
@end
