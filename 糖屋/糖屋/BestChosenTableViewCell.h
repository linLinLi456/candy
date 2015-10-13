//
//  BestChosenTableViewCell.h
//  糖屋
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BestChosenModel.h"
@interface BestChosenTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *topicLabel;
@property (weak, nonatomic) IBOutlet UIImageView *topicImageView;
- (void)showDataWithModel:(BestChosenModel *)mainModel andIndexPath:(NSIndexPath *)indexPath;
@end
