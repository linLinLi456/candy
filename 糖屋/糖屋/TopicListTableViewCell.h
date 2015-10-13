//
//  TopicListTableViewCell.h
//  糖屋
//
//  Created by qianfeng on 15/9/25.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicModel.h"
@interface TopicListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *tagsLab;


- (void)showDataWithModel:(TopicModel *)topicModel andIndexPath:(NSIndexPath *)indexPath;
@end
