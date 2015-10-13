//
//  CacheFunc.h
//  糖屋
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheFunc : NSObject
@property float size;
+ (void)saveDataToCacheWith:(NSString *)cacheName andUpdateTime:(NSInteger)updateTime andData:(NSData *)data;
+ (NSData *)getDataFromCacheWith:(NSString *)cacheName andUpdateTime:(NSInteger)updateTime;
//计算文件夹下得文件的大小
- (float)fileSizeForDir:(NSString *)path;
@end
