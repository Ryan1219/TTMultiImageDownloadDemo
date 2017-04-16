//
//  YZShopModel.h
//  YZMulitImageDownLoadDemo
//
//  Created by zhangliangwang on 17/4/16.
//  Copyright © 2017年 zhangliangwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZShopModel : NSObject

/** <#注释#> **/
@property (nonatomic,copy) NSString *imgurl;
/** <#注释#> **/
@property (nonatomic,copy) NSString *name;
/** <#注释#> */
@property (nonatomic,copy) NSString *count;

+ (instancetype)shopModelWithDict:(NSDictionary *)dict;

@end
