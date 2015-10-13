//
//  SearchTableViewCell.m
//  糖屋
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "SearchTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation SearchTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)showDataWithModel:(SearchModel *)SearchModel andIndexPath:(NSIndexPath *)indexPath {
    self.desLab.text = SearchModel.title;
    [self.picImgeView sd_setImageWithURL:[NSURL URLWithString:SearchModel.pic] placeholderImage:[UIImage imageNamed:@"placeHolderPic.png"]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
