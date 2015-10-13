//
//  TopTopicTableViewCell.m
//  糖屋
//
//  Created by qianfeng on 15/9/25.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "TopTopicTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation TopTopicTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)showDataWithModel:(TopTopicModel *)topicModel andIndexPath:(NSIndexPath *)indexPath {
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:topicModel.pic2] placeholderImage:nil];
    self.nameLab.text = topicModel.author[@"username"];
    self.timeLab.text = topicModel.datestr;
    self.desLab.text = topicModel.description;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:topicModel.author[@"avatar"]] placeholderImage:nil];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
