//
//  ViewController.m
//  YZMulitImageDownLoadDemo
//
//  Created by zhangliangwang on 17/4/16.
//  Copyright © 2017年 zhangliangwang. All rights reserved.
//

#import "ViewController.h"
#import "YZShopModel.h"
#import "YZShopTableViewCell.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height



@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

/** <#注释#> **/
@property (nonatomic,strong) NSArray *dataArray;
/** <#注释#> **/
@property (nonatomic,strong) UITableView *tableView;

/** 缓存图片 **/
@property (nonatomic,strong) NSMutableDictionary *images;

/** 缓存操作 **/
@property (nonatomic,strong) NSMutableDictionary *operations;

/** <#注释#> **/
@property (nonatomic,strong) NSOperationQueue *queue;



@end

@implementation ViewController

/* <#description#> */
- (NSArray *)dataArray{
    if (_dataArray == nil) {
        
        NSArray *dictArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"YZShop.plist" ofType:nil]];
        NSMutableArray *tmpArr = [NSMutableArray array];
        for (NSDictionary *dict in dictArr) {
            YZShopModel *model = [YZShopModel shopModelWithDict:dict];
            [tmpArr addObject:model];
        }
        _dataArray = tmpArr;
    }
    return _dataArray;
}

/* <#description#> */
- (NSMutableDictionary *)images {
    if (_images == nil) {
        _images = [NSMutableDictionary dictionary];
    }
    return _images;
}

/* <#description#> */
- (NSMutableDictionary *)operations {
    if (_operations == nil) {
        _operations = [NSMutableDictionary dictionary];
    }
    return _operations;
}

/* <#description#> */
- (NSOperationQueue *)queue {
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CGRect aRect = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.tableView = [[UITableView alloc] initWithFrame:aRect style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    
}

//MARK:-UITableView Delegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YZShopTableViewCell *cell = [YZShopTableViewCell cellWithTableView:tableView];

    YZShopModel *model = self.dataArray[indexPath.row];
    
    [self configCellWith:cell model:model tableView:tableView indexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}


//MARK:- <#description#>
- (void)configCellWith:(YZShopTableViewCell *)cell model:(YZShopModel *)model tableView:(UITableView *)tableView  indexPath:(NSIndexPath *)indexPath {
    
    cell.nameLabel.text = model.name;
    cell.countLabel.text = model.count;
    
    //先从内存中找图片
    UIImage *image = self.images[model.imgurl];
    if (image) { //内存中有
        cell.headImageView.image = image;
    } else { //内存中没有
        
        //查找沙盒是否有
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, true) firstObject];
        NSString *filename = [model.imgurl lastPathComponent];
        
        NSString *file = [path stringByAppendingPathComponent:filename];
        
        NSData *data = [NSData dataWithContentsOfFile:file];
        
        if (data) { //沙盒中有
            UIImage *image = [UIImage imageWithData:data];
            cell.headImageView.image = image;
            self.images[model.imgurl] = image;
        } else  {
            
            cell.headImageView.image = [UIImage imageNamed:@"place_image"];
            
            NSOperation *operateion = self.operations[model.imgurl];
            if (operateion == nil) { //没有下载操作
                operateion = [NSBlockOperation blockOperationWithBlock:^{
                    
                    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.imgurl]];
                    // 下载失败移除操作
                    if (data == nil) {
                        [self.operations removeObjectForKey:model.imgurl];
                        return ;
                    }
                    UIImage *image = [UIImage imageWithData:data];
                    
                    //挥刀住现场刷新界面
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        
                        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    }];
                    
                    //把图片存入字典
                    self.images[model.imgurl] = image;
                    //写入文件
                    [data writeToFile:file atomically:true];
                    //下载成功移除操作
                    [self.operations removeObjectForKey:model.imgurl];
                }];
                
                [self.queue addOperation:operateion];
                
                self.operations[model.imgurl] = operateion;
            }
        }
    }

}

@end









































