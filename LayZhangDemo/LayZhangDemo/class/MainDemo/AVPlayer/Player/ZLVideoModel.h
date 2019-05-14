//
//  ZLVideoModel.h
//  LayZhangDemo
//
//  Created by Lay on 2019/5/6.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLVideoModel : NSObject

@property (nonatomic, strong) NSURL * url;
@property (nonatomic, assign) NSTimeInterval currentTime;

@end

NS_ASSUME_NONNULL_END
