//
//  MYChannelCell.h
//  网易新闻
//
//  Created by caohaifeng on 4/28/16.
//  Copyright © 2016 haifeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MYNewsTVC;

@interface MYChannelCell : UICollectionViewCell

@property(nonatomic,strong) MYNewsTVC *newsTVC;
@property(nonatomic,copy) NSString *urlString;

@end
