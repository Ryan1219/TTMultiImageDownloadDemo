//
//  YZShopTableViewCell.h
//  YZMulitImageDownLoadDemo
//
//  Created by zhangliangwang on 17/4/16.
//  Copyright © 2017年 zhangliangwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZShopModel.h"

@interface YZShopTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** <#注释#> **/
@property (nonatomic,strong) YZShopModel *model;


@end
