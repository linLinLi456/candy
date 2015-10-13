//
//  TopTableViewCell.h
//  糖屋
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopModel.h"
@interface TopTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImageView;
- (void)showDataWithModel:(TopModel *)model;
@end
