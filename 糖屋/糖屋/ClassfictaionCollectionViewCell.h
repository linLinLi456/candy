//
//  ClassfictaionCollectionViewCell.h
//  糖屋
//
//  Created by qianfeng on 15/9/21.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassfictaionCollectionViewCell : UICollectionViewCell



@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *chineseName;
@property (nonatomic,strong)UILabel *EnglishName;
//@property (nonatomic,strong)NSString * classficiationName;
- (void)creatCollectionCellWithIndexPath:(NSIndexPath *)indexPath;
@end
