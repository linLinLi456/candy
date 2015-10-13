//
//  SearchModel.h
//  糖屋
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "JSONModel.h"
/*
 "data": [
 {
 "id": "973",
 "type_id": "1",
 "title": "设计为了更好的生活",
 "pic": "http://bt.img.17gwx.com/topic/0/9/e1Zd/600x270"
 },
 */
@interface SearchModel : JSONModel
@property (nonatomic,copy) NSString <Optional>* id;
@property (nonatomic,copy) NSString <Optional>* type_id;
@property (nonatomic,copy) NSString <Optional>* title;
@property (nonatomic,copy) NSString <Optional>* pic;
@end
