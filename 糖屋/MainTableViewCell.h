//
//  MainTableViewCell.h
//  糖屋
//
//  Created by qianfeng on 15/9/17.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainPageModel.h"
@interface MainTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *loveLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picIamge;
@property (weak, nonatomic) IBOutlet UIImageView *bottonImage;
@property (weak, nonatomic) IBOutlet UIImageView *loveImage;

// 在表格中展示数据
- (void)showDataWithModel:(MainPageModel *)mainModel andIndexPath:(NSIndexPath *)indexPath;
@end
