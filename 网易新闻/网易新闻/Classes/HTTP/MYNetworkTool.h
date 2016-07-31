//
//  MYNetworkTool.h
//  网易新闻
//
//  Created by caohaifeng on 4/27/16.
//  Copyright © 2016 haifeng. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface MYNetworkTool : AFHTTPSessionManager

+ (instancetype)shareNetworkingTool;

@end
