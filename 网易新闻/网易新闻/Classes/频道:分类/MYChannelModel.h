//
//  MYChannelModel.h
//  网易新闻
//
//  Created by caohaifeng on 4/28/16.
//  Copyright © 2016 haifeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYChannelModel : NSObject

@property(nonatomic,copy)NSString *tname;
@property(nonatomic,copy)NSString *tid;
@property(nonatomic,copy,readonly)NSString *urlString;

+ (instancetype)channelWithDictionary:(NSDictionary *)dict;
+ (NSArray *)channels;

@end
