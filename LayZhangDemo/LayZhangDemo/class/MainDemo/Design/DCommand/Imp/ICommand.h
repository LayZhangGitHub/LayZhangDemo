//
//  ICommand.h
//  LayZhangDemo
//
//  Created by Lay on 2019/6/4.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ICommand <NSObject>

- (void)execute;

@end

NS_ASSUME_NONNULL_END
