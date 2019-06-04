//
//  CInvoker.h
//  LayZhangDemo
//
//  Created by Lay on 2019/6/4.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICommand.h"

NS_ASSUME_NONNULL_BEGIN

@interface CInvoker : NSObject

@property (nonatomic, strong) id<ICommand> command;

- (void)doCommand;

@end

NS_ASSUME_NONNULL_END
