//
//  TopModel.h
//  糖屋
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
/*
 "id": "484",
 "category": "12",
 "title": "让你的桌面更出彩",
 "desc": "不管是办公室的办公桌、卧室的书桌、还是客厅的茶几，都是需要添加些有趣精致的摆件，给单调的生活带来情调。小糖君一共搜罗了10款小物件让你的桌面更出彩，有没有你中意的呀。",
 "pic": "http://bt.img.17gwx.com/topic/0/4/dlla/600x270",
 "width": "800",
 "height": "360",
 "likes": "41951",
 "share_url": "http://m.ibantang.com/topic/detail/484/",
 "share_pic": "http://bt.img.17gwx.com/topic/0/4/dlla/600x270",
 "islike": false,
 "product": [
 */
@interface TopModel : JSONModel
@property (nonatomic,copy)NSString <Optional>*id;
@property (nonatomic,copy)NSString <Optional>*category;
@property (nonatomic,copy)NSString <Optional>*title;
@property (nonatomic,copy)NSString <Optional>*desc;
@property (nonatomic,copy)NSString <Optional>*pic;
@property (nonatomic,copy)NSString <Optional>*width;
@property (nonatomic,copy)NSString <Optional>*height;
@property (nonatomic,copy)NSString <Optional>*likes;
@property (nonatomic,copy)NSString <Optional>*share_url;
@property (nonatomic,copy)NSString <Optional>*share_pic;
@property (nonatomic,copy)NSString <Optional>*islike;
//@property (nonatomic,copy)NSArray <Optional>*product;
@end
