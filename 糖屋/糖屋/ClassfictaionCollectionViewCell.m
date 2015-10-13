//
//  ClassfictaionCollectionViewCell.m
//  糖屋
//
//  Created by qianfeng on 15/9/21.
//  Copyright (c) 2015年 高习泰. All rights reserved.
//

#import "ClassfictaionCollectionViewCell.h"

@implementation ClassfictaionCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)creatCollectionCellWithIndexPath:(NSIndexPath *)indexPath {
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"categorys" ofType:@"plist"];
    NSMutableArray * infoArray = [NSMutableArray arrayWithContentsOfFile:path];
    NSDictionary * dataDic = [infoArray objectAtIndex:indexPath.row];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 44, 44)];
    [self.contentView addSubview:self.imageView];
    self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2;
    self.imageView.layer.masksToBounds = YES;
    self.chineseName = [[UILabel alloc] initWithFrame:CGRectMake(59, 22, 50, 20)];
    
    self.chineseName.font = [UIFont systemFontOfSize:14];
    self.chineseName.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.chineseName];
    self.EnglishName = [[UILabel alloc] initWithFrame:CGRectMake(59, 40, 60, 20)];
    self.EnglishName.font = [UIFont systemFontOfSize:9];
    self.EnglishName.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.EnglishName];
    //self.classficiationName = dataDic[@"categoryImage"];
    self.imageView.image = [UIImage imageNamed:dataDic[@"categoryImage"]];
    self.chineseName.text = dataDic[@"title"];
    self.EnglishName.text = dataDic[@"engTltle"];
    

}
@end
