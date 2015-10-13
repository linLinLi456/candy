//
//  MainTableViewCell.m
//  糖屋
//
//  Created by qianfeng on 15/9/17.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "MainTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation MainTableViewCell

- (void)awakeFromNib {
    // 设置主界面表格的圆角
    self.picIamge.layer.masksToBounds = YES;
    self.picIamge.layer.cornerRadius = 8;
    //
    self.loveImage.layer.masksToBounds = YES;
    self.loveImage.layer.cornerRadius = 5;
    //
    self.bottonImage.layer.masksToBounds = YES;
    self.bottonImage.layer.cornerRadius = 8;
}


// 在表格中展示数据
- (void)showDataWithModel:(MainPageModel *)mainModel andIndexPath:(NSIndexPath *)indexPath {
    // 利用第三方库获取图片
    // NSLog(@"%@",mainModel.pic);
    // 图片
    [self.picIamge sd_setImageWithURL:[NSURL URLWithString:mainModel.pic] placeholderImage:[UIImage imageNamed:@"placeHolderPic.png"]];
    // 标题
    self.titleLabel.text = mainModel.title;
    // 喜欢的人数
    self.loveLabel.text = mainModel.likes;
    [self.titleLabel setFont:[UIFont fontWithName:@"American Typewriter" size:15]];
    [self.loveLabel setFont:[UIFont fontWithName:@"American Typewriter" size:10]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
