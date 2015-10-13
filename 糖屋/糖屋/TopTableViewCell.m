//
//  TopTableViewCell.m
//  糖屋
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "TopTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "UMSocial.h"
@implementation TopTableViewCell
{
    TopModel * _oneModel;
}
- (void)awakeFromNib {
    // Initialization code
}
- (void)showDataWithModel:(TopModel *)model {
    _oneModel = model;
    // 顶部的图片
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"placeHolderPic.png"]];
//    self.titleLabel.layer.cornerRadius = 5;
//    self.titleLabel.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = 5;
    self.imageView.layer.masksToBounds = YES;
    // 标题
    self.titleLabel.text = model.title;
    // 商品的描述
    self.desLabel.text = model.desc;
    [self.titleLabel setFont:[UIFont fontWithName:@"American Typewriter" size:15]];
    [self.desLabel setFont:[UIFont fontWithName:@"American Typewriter" size:13]];
}

- (IBAction)shareBtnClicked:(id)sender {
    NSString * shareText = [NSString stringWithFormat:@"糖主精选:%@%@",_oneModel.desc,_oneModel.share_url];
    [UMSocialSnsService presentSnsIconSheetView:self.window.rootViewController
                                         appKey:@"5610e2cd67e58e287400081e"
                                      shareText:shareText
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,nil]
                                       delegate:nil];
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
