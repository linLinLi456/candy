//
//  TopicModel.h
//  糖屋
//
//  Created by qianfeng on 15/9/25.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "JSONModel.h"
/*
 "subject": [
 {
 "id": "30",
 "title": "一周之星",
 "description": "",
 "author_id": "1",
 "start_time": "1443179517",
 "datestr": "09-25 19:11",
 "dynamic": {},
 "author": {},
 "share_url": "http://m.ibantang.com/post/subject/30/",
 "is_recommend": "0",
 "pic1": "http://7xiwnz.com2.z0.glb.qiniucdn.com/subject1/201509/97554852.jpg?v=1443179802",
 "pic2": "http://7xiwnz.com2.z0.glb.qiniucdn.com/subject2/201509/97554853.jpg?v=1443179802",
 "rank_share_url": "http://m.ibantang.com/post/subject/rank/30?userId=0",
 "tags": ""
 },
 */
@interface TopicModel : JSONModel
@property (nonatomic,copy) NSString <Optional> * id;
@property (nonatomic,copy) NSString <Optional> * title;
@property (nonatomic,copy) NSString <Optional> * description;
@property (nonatomic,copy) NSString <Optional> * author_id;
@property (nonatomic,copy) NSString <Optional> * start_time;
@property (nonatomic,copy) NSString <Optional> * datestr;
@property (nonatomic,strong) NSDictionary <Optional> * dynamic;
@property (nonatomic,strong) NSDictionary <Optional> * author;
@property (nonatomic,copy) NSString <Optional> * share_url;
@property (nonatomic,copy) NSString <Optional> * is_recommend;
@property (nonatomic,copy) NSString <Optional> * pic1;
@property (nonatomic,copy) NSString <Optional> * pic2;
@property (nonatomic,copy) NSString <Optional> * rank_share_url;
@property (nonatomic,copy) NSString <Optional> * tags;
@end
