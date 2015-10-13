//
//  ClassficationViewController.h
//  糖屋
//
//  Created by qianfeng on 15/9/21.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainPageViewController.h"
@interface ClassficationViewController : UIViewController
//用cellId来确定点击的具体类别
@property (nonatomic,copy) NSString * cellId;
//第一次下载网络数据
- (void)firstDownLoad;
- (void)downLoadWithURL:(NSString *)update_time andCellId:(NSString *)cellId;

@end
