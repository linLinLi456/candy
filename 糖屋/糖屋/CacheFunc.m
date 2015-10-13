//
//  CacheFunc.m
//  糖屋
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "CacheFunc.h"
#import "Path.h"
@implementation CacheFunc
//获取沙盒路径
+ (NSString *)cachePath:(NSString *)cacheName {
    NSString * cachePath = [NSString stringWithFormat:@"%@/Library/Caches/updataTime/%@/",NSHomeDirectory(),cacheName];
    NSFileManager * FM = [NSFileManager defaultManager];
    if (![FM fileExistsAtPath:cachePath isDirectory:nil]) {
        [FM createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return cachePath;
}
//保存到沙盒路径中
+ (void)saveDataToCacheWith:(NSString *)cacheName andUpdateTime:(NSInteger)updateTime andData:(NSData *)data {
    NSString * pathStr = [NSString stringWithFormat:@"%@%ld.png",[self cachePath:cacheName],updateTime];
    [data writeToFile:pathStr atomically:NO];
    //NSLog(@"%@",pathStr);
}
//获取到缓存
+ (NSData *)getDataFromCacheWith:(NSString *)cacheName andUpdateTime:(NSInteger)updateTime {
    NSString * pathStr = [NSString stringWithFormat:@"%@%ld.png",[self cachePath:cacheName],updateTime];
    NSData * data = [NSData dataWithContentsOfFile:pathStr];
    return data;
}
//计算缓存大小
- (float)fileSizeForDir:(NSString *)path {
    NSFileManager * fileManager = [[NSFileManager alloc] init];
    NSArray * array = [fileManager contentsOfDirectoryAtPath:path error:nil];
    for (int i = 0; i < [array count]; i++) {
        NSString * fullPath = [path stringByAppendingPathComponent:[array objectAtIndex:i]];
        BOOL isDir;
        if ( !([fileManager fileExistsAtPath:fullPath isDirectory:&isDir] && isDir) ) {
            NSDictionary *fileAttributeDic=[fileManager attributesOfItemAtPath:fullPath error:nil];
            self.size+= fileAttributeDic.fileSize/ 1024.0/1024.0;
        } else {
            [self fileSizeForDir:fullPath];
        }
    }
    return self.size;
}
@end
