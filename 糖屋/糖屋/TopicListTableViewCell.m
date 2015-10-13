//
//  TopicListTableViewCell.m
//  糖屋
//
//  Created by qianfeng on 15/9/25.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "TopicListTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation TopicListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)showDataWithModel:(TopicModel *)topicModel andIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        self.picImageView.layer.cornerRadius = 10;
        self.picImageView.layer.masksToBounds = YES;
        self.picImageView.image = [UIImage imageNamed:@"每日精选.jpg"];
        self.titleLab.text = @"糖主为你选出每日最好单品";
        self.tagsLab.text = @"话题:每日精选";
    } else {
        self.picImageView.layer.cornerRadius = 10;
        self.picImageView.layer.masksToBounds = YES;
        [self.picImageView sd_setImageWithURL:[NSURL URLWithString:topicModel.pic1] placeholderImage:[UIImage imageNamed:@"icon.png"]];
        self.titleLab.text = topicModel.title;
        if ([topicModel.tags isEqualToString:@""]) {
        topicModel.tags = @"极客";
    }
    self.tagsLab.text =  [NSString stringWithFormat:@"话题:%@",topicModel.tags];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
