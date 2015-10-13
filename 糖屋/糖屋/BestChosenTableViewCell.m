//
//  BestChosenTableViewCell.m
//  糖屋
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "BestChosenTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation BestChosenTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)showDataWithModel:(BestChosenModel *)mainModel andIndexPath:(NSIndexPath *)indexPath {
    self.iconImageView.layer.cornerRadius = self.iconImageView.frame.size.height / 2;
    self.iconImageView.layer.masksToBounds = YES;
    self.topicImageView.layer.cornerRadius = self.topicImageView.frame.size.height / 2;
    self.topicImageView.layer.masksToBounds = YES;
    self.descriptionLabel.text = mainModel.content;
    self.timeLabel.text = mainModel.datestr;
    NSDictionary * authorDic = mainModel.author;
    self.nameLabel.text = authorDic[@"username"];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:authorDic[@"avatar"]] placeholderImage:[UIImage imageNamed:@"icon.png"]];
    NSString * picsUrl = [mainModel.pics objectAtIndex:0][@"url"];
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:picsUrl] placeholderImage:[UIImage imageNamed:@"placeHolderPic.png"]];
    NSMutableArray * tagsArray = (NSMutableArray *)mainModel.tags;
    NSMutableString * tagsStr = [[NSMutableString alloc] init];
    for (NSDictionary * oneDic in tagsArray) {
        NSString * key = [oneDic objectForKeyedSubscript:@"name"];
        [tagsStr appendFormat:@"%@ ",key];
    }
    self.topicLabel.text = tagsStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
