//
//  BestChosenModel.h
//  糖屋
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "JSONModel.h"
/*
 "id": "19211",
 "title": "",
 描述："content": "本期话题：「你晒单，我买单」\n只要你肯晒，我们就敢买！本期奖品是小糖君帮你实现愿望！活动参与办法参照首页或者社区顶部运营位。\n活动时间：2015年9月23日-9月29日",
 "author_id": "1",
 "tags": [],
 话题： "i_tags": "小糖君来买单,编辑精选",
 "relation_id": "0",
 "create_time": "1442997652",
 "publish_time": "1453004210",
 时间   "datestr": "刚刚",
 "pics": [{图片：  "url": "http://pic1.bantangapp.com/post/201509/23/52491014_1_1.jpg!w600",}],
 "dynamic": {},
 "product": [],
 "author": {
 用户名：  "username": "小糖君",
 头像：  "avatar": "http://7te7t9.com2.z0.glb.qiniucdn.com/000/00/00/01.jpg",
 },
 "share_url": "http://m.ibantang.com/post/detail/19211/",
 "is_recommend": "1"
*/
@interface BestChosenModel : JSONModel
@property (nonatomic,copy) NSString <Optional>* id;
@property (nonatomic,copy) NSString <Optional>* title;
@property (nonatomic,copy) NSString <Optional>* content;
@property (nonatomic,copy) NSString <Optional>* author_id;
@property (nonatomic,strong) NSArray <Optional>* tags;
@property (nonatomic,copy) NSString <Optional>* i_tags;
@property (nonatomic,copy) NSString <Optional>* relation_id;
@property (nonatomic,copy) NSString <Optional>* create_time;
@property (nonatomic,copy) NSString <Optional>* publish_time;
@property (nonatomic,copy) NSString <Optional>* datestr;
@property (nonatomic,strong) NSArray <Optional>* pics;
@property (nonatomic,strong) NSDictionary <Optional>* dynamic;
@property (nonatomic,copy) NSArray <Optional>* product;
@property (nonatomic,strong) NSDictionary <Optional>* author;
@property (nonatomic,copy) NSString <Optional>* share_url;
@property (nonatomic,copy) NSString <Optional>* is_recommend;
@end
