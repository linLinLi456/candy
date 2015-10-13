//
//  EverdayChosenTableViewCell.m
//  糖屋
//
//  Created by qianfeng on 15/9/28.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "EverdayChosenTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation EverdayChosenTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)showDataWithModel:(EverdayModel *)model andIndexPath:(NSIndexPath *)indexPath {
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:nil];
    self.titleLab.text = model.title;
    self.priceLab.text = [NSString stringWithFormat:@"￥%@",model.price];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
