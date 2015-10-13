//
//  EverdayChosenTableViewCell.h
//  糖屋
//
//  Created by qianfeng on 15/9/28.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EverdayModel.h"
@interface EverdayChosenTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
- (void)showDataWithModel:(EverdayModel *)model andIndexPath:(NSIndexPath *)indexPath;
@end
