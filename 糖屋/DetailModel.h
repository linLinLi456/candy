//
//  DetailModel.h
//  糖屋
//
//  Created by qianfeng on 15/9/18.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "JSONModel.h"
#import <Foundation/Foundation.h>
@interface DetailModel : JSONModel
@property (nonatomic,copy)NSString <Optional>*number;
@property (nonatomic,copy)NSString <Optional>*desc;
@property (nonatomic,copy)NSString <Optional>*price;
@property (nonatomic,copy)NSString <Optional>*url;
@property (nonatomic,copy)NSString <Optional>*title;
@property (nonatomic,copy)NSArray <Optional>*pic;

@property (nonatomic,copy)NSString <Optional>*id;
@property (nonatomic,copy)NSString <Optional>*likes;
@property (nonatomic,copy)NSString <Optional>*islike;
@property (nonatomic,copy)NSString <Optional>*comments;
@property (nonatomic,copy)NSString <Optional>*iscomments;
@property (nonatomic,copy)NSString <Optional>*category;
@property (nonatomic,copy)NSString <Optional>*topic_id;
@property (nonatomic,copy)NSString <Optional>*item_id;
@property (nonatomic,copy)NSString <Optional>*platform;
@property (nonatomic,copy)NSString <Optional>*share_url;

@end
