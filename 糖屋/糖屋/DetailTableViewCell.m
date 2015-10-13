//
//  DetailTableViewCell.m
//  糖屋
//
//  Created by qianfeng on 15/9/18.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "DetailTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation DetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)showDataWithModel:(DetailModel *)model indexPath:(NSIndexPath *)indexPath {
    // 商品的编号
    self.numberLabel.text = [NSString stringWithFormat:@"%.2d",model.number.intValue+1];
    // 商品的名字
    self.titleLabel.text = model.title;
    // 商品的介绍
    self.descriptionLabel.text = model.desc;
    // 商品的价格
    // self.priceLabel.text = [model.price componentsSeparatedByString:@"元"][0];
    self.priceLabel.text = [NSString stringWithFormat:@"%@元",model.price];
    [self.titleLabel setFont:[UIFont fontWithName:@"American Typewriter" size:15]];
    [self.descriptionLabel setFont:[UIFont fontWithName:@"American Typewriter" size:13]];
    // 存储图片地址的字典
    NSDictionary * picDic = model.pic[0];
    // 商品的展示图片
    [self.picImageView sd_setImageWithURL:picDic[@"pic"] placeholderImage:[UIImage imageNamed:@"placeHolderPic.png"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

//- (IBAction)detailButtonClicked:(UIButton *)sender {
//    
//}
@end
