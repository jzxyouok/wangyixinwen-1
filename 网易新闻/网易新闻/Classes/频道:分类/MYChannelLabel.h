//
//  MYChannelLabel.h
//  网易新闻
//
//  Created by caohaifeng on 4/28/16.
//  Copyright © 2016 haifeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYChannelLabel : UILabel

@property(nonatomic,assign) CGFloat scale;
@property(nonatomic,assign) CGFloat textWidth;

+ (instancetype)channelLabelWithTitle:(NSString *)title;

@end
