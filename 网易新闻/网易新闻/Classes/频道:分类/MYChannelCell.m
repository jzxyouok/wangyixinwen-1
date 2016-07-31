//
//  MYChannelCell.m
//  网易新闻
//
//  Created by caohaifeng on 4/28/16.
//  Copyright © 2016 haifeng. All rights reserved.
//

#import "MYChannelCell.h"
#import "MYNewsTVC.h"

@implementation MYChannelCell

- (void)setUrlString:(NSString *)urlString {
    _urlString = urlString;
    _newsTVC = [[MYNewsTVC alloc] init];
    _newsTVC.view.frame = self.bounds;
    _newsTVC.urlString = urlString;
    [self.contentView addSubview:_newsTVC.view];
}


@end
