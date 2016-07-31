//
//  MYNetworkTool.m
//  网易新闻
//
//  Created by caohaifeng on 4/27/16.
//  Copyright © 2016 haifeng. All rights reserved.
//

#import "MYNetworkTool.h"

@implementation MYNetworkTool

+ (instancetype)shareNetworkingTool {
    static MYNetworkTool *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:@"http://c.m.163.com/nc/"];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        instance = [[MYNetworkTool alloc] initWithBaseURL:url sessionConfiguration:config];
        // 加入 text/html 解析
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    return instance;
}

@end
