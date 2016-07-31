//
//  MYChannelModel.m
//  网易新闻
//
//  Created by caohaifeng on 4/28/16.
//  Copyright © 2016 haifeng. All rights reserved.
//

#import "MYChannelModel.h"

@implementation MYChannelModel

+ (instancetype)channelWithDictionary:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    NSArray *array = @[@"tname", @"tid"];
    [array enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL * _Nonnull stop) {
        if (dict[key]) {
            [obj setValue:dict[key] forKey:key];
        }
    }];
    return obj;
}

+ (NSArray *)channels {
    // 频道列表没从网上获取，直接用了网易新闻bundle里的这个文件。
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"topic_news.json" withExtension:nil];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    NSArray *array = dict[@"tList"];
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [arrayM addObject:[self channelWithDictionary:obj]];
    }];
    //排序
    return [arrayM sortedArrayUsingComparator:^NSComparisonResult(MYChannelModel *obj1, MYChannelModel *obj2) {
        return [obj1.tid compare:obj2.tid];
    }];

}

- (void)setTid:(NSString *)tid {
    _tid = tid.copy;
    _urlString = [NSString stringWithFormat:@"article/headline/%@/0-20.html", tid];
}


- (NSString *)description {
    NSDictionary *dict = [self dictionaryWithValuesForKeys:@[@"tname", @"tid"]];
    return [NSString stringWithFormat:@"<%@: %p> %@", self.class, self, dict];
}

@end
