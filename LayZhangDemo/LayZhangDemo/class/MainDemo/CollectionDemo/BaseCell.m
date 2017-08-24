//
//  BaseCell.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/8/22.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "BaseCell.h"

@implementation BaseCell

- (void)reloadData {
    AllLog(@"basecell log");
}

- (void)cellAddSubview:(UIView *)view {
    
    if (view && ![view superview] ) {
        [self addSubview:view];
    }
    
}

+ (CGFloat)heightForCell:(id)cellData
{
    return 0;
}

+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}


@end
