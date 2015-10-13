//
//  Path.h
//  糖屋
//
//  Created by qianfeng on 15/9/17.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#ifndef _____Path_h
#define _____Path_h

//主页界面的URL
#define MAIN_URL (@"http://open3.bantangapp.com/topic/list?app_versions=3.3&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&os_versions=7.1.2&pagesize=20&screensize=640&update_time=%@&v=1")
#define MAIN_CACHE (@"maincache")
//精选界面的URL
#define BESTCHOSEN_URL (@"http://open3.bantangapp.com/community/post/editorRec?app_installtime=1442845577.39531&app_versions=4.1.1&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&os_versions=8.4.1&page=%ld&pagesize=10&screensize=640&track_device_info=iPhone&track_deviceid=E0D0718D-7574-49B2-AAC7-9C8C8F5A896E&v=6")
//精选界面点击进入的界面
#define BESTCHOSEN_TOTAOBAO_URL (@"http://open3.bantangapp.com/community/post/info?app_installtime=1442845577.39531&app_versions=4.2&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&id=%@")
#define BESTCHOSEN_CACHE (@"bsetchosecache")
//话题列表的URL和精选界面的URL是一样的，用的是其中的不同的字典
//#define TOPIC_CACHE (@"topiccache")
//话题详情界面的URL
#define TOPIC_DISCRSS_URL (@"http://open3.bantangapp.com/community/subject/listPost?app_installtime=1442845577.39531&app_versions=4.1.1&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&os_versions=8.4.1&page=%ld&pagesize=10&screensize=640&subject_id=%@&track_device_info=iPhone&track_deviceid=E0D0718D-7574-49B2-AAC7-9C8C8F5A896E&type_id=0&v=6")
#define TOP_TOPIC_DISSUSS_URL (@"http://open3.bantangapp.com/community/subject/info?app_installtime=1442845577.39531&app_versions=4.1.1&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&os_versions=8.4.1&screensize=640&subject_id=%@&track_device_info=iPhone&track_deviceid=E0D0718D-7574-49B2-AAC7-9C8C8F5A896E&v=6")
//详情界面的URL
#define DETAIL_URL (@"http://open3.bantangapp.com/topic/info?app_installtime=1434115868.646654&app_versions=3.4&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&id=%@&oauth_token=646d94904ec6b97d11f10237bf4f2d27&os_versions=7.1.2&screensize=640&statistics_uv=0&track_device_info=iPhone&track_deviceid=0958F43F-3F54-49DF-AA9B-676CC54DEFDE&track_user_id=540974&v=2")
//类别界面的URL
#define CATEGORY_URL (@"http://open1.bantangapp.com/topic/list?category=%@&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&oauth_token=5495d38a5cf1f7f460cf03aaa2e5c0a2&page=0&pagesize=20&screensize=640&update_time=%@&v=1")
//收藏界面的URL
#define COLLRET_URL (@"http://open1.bantangapp.com/topic/list?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&ids=%@&page=0&pagesize=20&screensize=640&update_time=0&v=1")
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
//搜索类别的URL
#define SEARCH_CLASSFICATION_URL (@"http://open3.bantangapp.com/base/search/list?app_installtime=1442845577.39531&app_versions=4.1.1&category=12&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&keyword=%@&os_versions=8.4.1&page=%ld&pagesize=20&screensize=640&track_device_info=iPhone&track_deviceid=E0D0718D-7574-49B2-AAC7-9C8C8F5A896E&type_id=1&v=6")

//每日精选的URL   全部
#define EVERDAY_CHOSEN_URL (@"http://open3.bantangapp.com/product/list?app_installtime=1442845577.39531&app_versions=4.2&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&os_versions=8.4.1&page=%ld&pagesize=20")
//其他具体的类别
#define EVERDAY_CATEGORY_URL (@"http://open3.bantangapp.com/product/list?app_installtime=1442845577.39531&app_versions=4.2&category=%ld&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&os_versions=8.4.1&page=%ld&pagesize=20")
#endif
