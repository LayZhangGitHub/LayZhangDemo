//
//  CCellA.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/8/22.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "CCellA.h"

@interface CCellA ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CCellA

- (void)reloadData
{
    if (self.cellData){
        self.backgroundColor = ZLWhiteColor;
        [self cellAddSubview:self.titleLabel];
        self.titleLabel.text = self.cellData;
//        MHModuleModel *model = self.cellData;
//        for (int i = 0; i< 4; i++) {
//            MHItemModel *item = [model.items safeObjectAtIndex:i];
//            NSString *link = item.link?item.link:@"";
//            NSString *title = item.title?item.title:@"";
//            NSString *image = item.image?item.image:@"";
//            
//            MHomeModuleView *module = [self.moduleViews safeObjectAtIndex:i];
//            [module reloadData:@{@"title":title,@"icon":image,@"link":link}];
//        }
    }
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.frame = CGRectMake(0, 0, 300, 40);
    }
    return _titleLabel;
}

+ (CGFloat)heightForCell:(id)cellData
{
//    CGFloat height = 0;
//    MHModuleModel *model = cellData;
//    if (model.items.count) {
//        int row = ceil(model.items.count/4.);
//        height = 20 + (20+70)*row;
//    }
//    return height;
    return 40.0f;
}
@end
