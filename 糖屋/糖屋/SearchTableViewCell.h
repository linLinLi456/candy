//
//  SearchTableViewCell.h
//  糖屋
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchModel.h"
@interface SearchTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picImgeView;
@property (weak, nonatomic) IBOutlet UILabel *desLab;
- (void)showDataWithModel:(SearchModel *)SearchModel andIndexPath:(NSIndexPath *)indexPath;
@end
