//
//  TableTimerTableViewCell.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/17.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "TableTimerTableViewCell.h"

@interface TableTimerTableViewCell()

@property (nonatomic, assign) NSTimeInterval time;
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation TableTimerTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"TableTimerTableViewCell";
    
    TableTimerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[TableTimerTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:[UIColor whiteColor]]];
        
        cell.textLabel.textColor = ZLRGB(39, 39, 39);
        cell.textLabel.font = [UIFont systemFontOfSize:28 * SCALE];
        
        [cell addTimer];
        [cell addNotification];
    }
    return cell;
}

#pragma mark - timer
- (void)addNotification {
    [DefaultNotificationCenter addObserver:self
                                  selector:@selector(invalidTime)
                                      name:TimerCellDeallocNotification
                                    object:nil];
}

- (void)invalidTime {
    [self.timer invalidate];
}

- (void)addTimer {
    self.time = 0;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeNew) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

- (void)timeNew {
    if (self.time >= -0.00001 && self.time <= 0.00001) {
        return;
    }
    self.time --;
    self.textLabel.text = [NSString stringWithFormat:@"%f", self.time];
    NSLog(@"%f", self.time);
}

- (void)setItem:(NSDictionary *)item {
    if (item[@"value"]) {
        self.time = [item[@"value"] integerValue];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)dealloc {
    [DefaultNotificationCenter removeObserver:self];
    NSLog(@"cell dealloc");
}

@end
