//
//  TopTopicModel.h
//  糖屋
//
//  Created by qianfeng on 15/9/28.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "JSONModel.h"
/*
 "id": "28",
 "title": "每日一晒——怀旧纪念馆",
 "description": "港囧上映了，虽然是一部喜剧，但里面那些港片、港乐元素一定能勾起不少人的回忆。当我们慢慢长大，那些曾陪伴着我们的美好事物，都成了旧时光里珍贵的回忆。\r\n“每日一晒”今天要晒的就是那些能勾起我们回忆的美好小物。旧时听过的磁带、用过的破旧字典、或者是人人都爱的大白兔奶糖！\r\n----每日一晒，每日一个主题，分享身边的幸福 留住这一刻的美好！",
 "author_id": "1",
 "start_time": "1443090056",
 "datestr": "09-24 18:20",
 "dynamic":{}
 "share_url": "http://m.ibantang.com/post/subject/28/",
 "is_recommend": "0",
 "pic1": "http://7xiwnz.com2.z0.glb.qiniucdn.com/subject1/201509/10149555.jpg?v=1443090606",
 "pic2": "http://7xiwnz.com2.z0.glb.qiniucdn.com/subject2/201509/10149555.jpg?v=1443090606",
 "rank_share_url": "http://m.ibantang.com/post/subject/rank/28?userId=0",
 "tags": "怀旧"
 
 */
@interface TopTopicModel : JSONModel
{
    NSString * _description;
}


@property (nonatomic,copy) NSString <Optional>* id;
@property (nonatomic,copy) NSString <Optional>* title;
@property (nonatomic,copy) NSString * description;
@property (nonatomic,copy) NSString <Optional>* author_id;
@property (nonatomic,copy) NSString <Optional>* start_time;
@property (nonatomic,copy) NSString <Optional>* datestr;
@property (nonatomic,strong) NSDictionary <Optional>* dynamic;
@property (nonatomic,strong) NSDictionary <Optional> * author;
@property (nonatomic,copy) NSString <Optional>* share_url;
@property (nonatomic,copy) NSString <Optional>* is_recommend;
@property (nonatomic,copy) NSString <Optional>* pic1;
@property (nonatomic,copy) NSString <Optional>* pic2;
@property (nonatomic,copy) NSString <Optional>* rank_share_url;
@property (nonatomic,copy) NSString <Optional>* tags;

@end
