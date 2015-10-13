//
//  TopTopicTableViewCell.h
//  糖屋
//
//  Created by qianfeng on 15/9/25.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopTopicModel.h"
@interface TopTopicTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@property (weak, nonatomic) IBOutlet UILabel *desLab;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;





- (void)showDataWithModel:(TopTopicModel *)topicModel andIndexPath:(NSIndexPath *)indexPath;
@end
