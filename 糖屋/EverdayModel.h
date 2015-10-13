//
//  EverdayModel.h
//  糖屋
//
//  Created by qianfeng on 15/9/28.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "JSONModel.h"
/*
 "id": "18314",
 "title": "保湿化妆水",
 "price": "129.00",
 "category": "5",
 "pic": "http://bt.img.17gwx.com/product1/1/83/c1ldZVU/w300",
 "url": "https://detail.tmall.com/item.htm?id=40001107553",
 "item_id": "40001107553",
 "platform": "2",
 "dateline": "1441977695",
 "likes": "0",
 "islike": false
 */
@interface EverdayModel : JSONModel
@property (nonatomic,copy) NSString <Optional>* id;
@property (nonatomic,copy) NSString <Optional>* title;
@property (nonatomic,copy) NSString <Optional>* price;
@property (nonatomic,copy) NSString <Optional>* category;
@property (nonatomic,copy) NSString <Optional>* pic;
@property (nonatomic,copy) NSString <Optional>* url;
@property (nonatomic,copy) NSString <Optional>* item_id;
@property (nonatomic,copy) NSString <Optional>* platform;
@property (nonatomic,copy) NSString <Optional>* dateline;
@property (nonatomic,copy) NSString <Optional>* likes;
@property (nonatomic,copy) NSString <Optional>* islike;
@end
