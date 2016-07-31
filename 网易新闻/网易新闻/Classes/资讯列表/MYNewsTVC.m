//
//  MYNewsTVC.m
//  网易新闻
//
//  Created by caohaifeng on 4/28/16.
//  Copyright © 2016 haifeng. All rights reserved.
//

#import "MYNewsTVC.h"
#import "MYNewsModel.h"

@interface MYNewsTVC ()

@property(nonatomic,strong) NSMutableArray *dataList;

@end

@implementation MYNewsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",self.dataList);
}

- (void)setUrlString:(NSString *)urlString {
    _urlString = urlString;
    
    [MYNewsModel newsDataListWithUrlString:urlString complection:^(NSMutableArray *array) {
        _dataList = array;
//        [self.tableView reloadData]; // 不刷新的话，数据会显示复用的，而不是对应频道的。
    }];

}

@end
