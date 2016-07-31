//
//  MYChannelLabel.m
//  网易新闻
//
//  Created by caohaifeng on 4/28/16.
//  Copyright © 2016 haifeng. All rights reserved.
//

#import "MYChannelLabel.h"

@implementation MYChannelLabel

+ (instancetype)channelLabelWithTitle:(NSString *)title {
    MYChannelLabel *label = [[self alloc] init];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18];
    [label sizeToFit];
    label.userInteractionEnabled = YES;
    return label;
}

- (CGFloat)textWidth {
    return [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}].width + 8;
}

- (void)setScale:(CGFloat)scale {
    _scale = scale;
    self.textColor = [UIColor colorWithRed:scale*0.176 green:scale*0.722 blue:scale*0.945 alpha:1];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p> %@", self.class, self, self.text];
}


@end
