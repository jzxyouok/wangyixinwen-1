//
//  MYNewsModel.h
//  网易新闻
//
//  Created by caohaifeng on 4/28/16.
//  Copyright © 2016 haifeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYNewsModel : NSObject

/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 摘要 */
@property (nonatomic, copy) NSString *digest;
/** 图片链接 */
@property (nonatomic, copy) NSString *imgsrc;
/** 跟贴数 */
@property (nonatomic, assign) int replyCount;
/** 多张配图 */
@property (nonatomic, strong) NSArray *imgextra;
/** 大图标记 */
@property (nonatomic, assign) BOOL imgType;

@property (nonatomic, copy) NSArray *ads;
/** 进入后是图片详情 */
@property (nonatomic, copy) NSString *photosetID;
/** 进入后是新闻web详情 */
@property (nonatomic, copy) NSString *url;
/** 新闻ID */
@property (nonatomic,copy) NSString *docid;
@property (nonatomic,copy) NSString *boardid;

+ (void)newsDataListWithUrlString:(NSString *)urlString complection:(void (^)(NSMutableArray *array))complection;

@end
