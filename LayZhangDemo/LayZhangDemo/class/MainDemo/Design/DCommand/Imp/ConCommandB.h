//
//  ConCommandB.h
//  LayZhangDemo
//
//  Created by Lay on 2019/6/4.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICommand.h"
#import "CReceiver.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConCommandB : NSObject<ICommand>

- (instancetype)initWithReceiver:(CReceiver *)receiver;

@end

NS_ASSUME_NONNULL_END
