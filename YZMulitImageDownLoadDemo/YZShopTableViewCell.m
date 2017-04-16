//
//  YZShopTableViewCell.m
//  YZMulitImageDownLoadDemo
//
//  Created by zhangliangwang on 17/4/16.
//  Copyright © 2017年 zhangliangwang. All rights reserved.
//

#import "YZShopTableViewCell.h"

@interface YZShopTableViewCell()



@end

@implementation YZShopTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *YZShopTableViewCellIdentifier = @"YZShopTableViewCellIdentifier";
    YZShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YZShopTableViewCellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    
    return cell;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
