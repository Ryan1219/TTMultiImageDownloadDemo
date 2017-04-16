//
//  YZShopModel.m
//  YZMulitImageDownLoadDemo
//
//  Created by zhangliangwang on 17/4/16.
//  Copyright © 2017年 zhangliangwang. All rights reserved.
//

#import "YZShopModel.h"

@implementation YZShopModel

+ (instancetype)shopModelWithDict:(NSDictionary *)dict {
    
    YZShopModel *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

@end
