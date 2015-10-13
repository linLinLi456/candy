//
//  TopNewsProtocol.h
//  糖屋
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import <Foundation/Foundation.h>
// 此协议是为了将首页的广告信息传到此界面
@protocol TopNewsProtocol <NSObject>
- (void)setTopNewsWithNewsArray:(NSMutableArray *)array;
@end
