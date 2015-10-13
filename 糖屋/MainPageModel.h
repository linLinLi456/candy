//
//  MainPageModel.h
//  糖屋
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "JSONModel.h"

@interface MainPageModel : JSONModel
@property (nonatomic,copy)NSString <Optional>*id;
@property (nonatomic,copy)NSString <Optional>*islike;
@property (nonatomic,copy)NSString <Optional>*title;
@property (nonatomic,copy)NSString <Optional>*pic;
@property (nonatomic,copy)NSString <Optional>*likes;
@property (nonatomic,copy)NSString <Optional>*update_time;




@property (nonatomic,copy)NSString <Optional>*photo;
@property (nonatomic,copy)NSString <Optional>*number;
@property (nonatomic,copy)NSString <Optional>*desc;
@property (nonatomic,copy)NSString <Optional>*price;
@property (nonatomic,copy)NSString <Optional>*url;
@property (nonatomic,copy)NSString <Optional>*extend;
@property (nonatomic,copy)NSString <Optional>*type;
@end
