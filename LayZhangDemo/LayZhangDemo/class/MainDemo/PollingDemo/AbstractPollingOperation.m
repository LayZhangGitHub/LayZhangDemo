//
//  AbstractPollingOperation.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/12/7.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "AbstractPollingOperation.h"

typedef NS_ENUM(NSInteger, PollingOperationState) {
    PollingOperationStateReady       = 1,
    PollingOperationStateExecuting   = 2,
    PollingOperationStateFinished    = 3,
};

static dispatch_group_t polling_operation_completion_group() {
    static dispatch_group_t polling_operation_completion_group;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        polling_operation_completion_group = dispatch_group_create();
    });
    
    return polling_operation_completion_group;
}

static dispatch_queue_t polling_operation_completion_queue() {
    static dispatch_queue_t polling_operation_completion_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        polling_operation_completion_queue = dispatch_queue_create("polling.operation.queue", DISPATCH_QUEUE_CONCURRENT );
    });
    
    return polling_operation_completion_queue;
}

static inline NSString * PollingKeyPathFromOperationState(PollingOperationState state) {
    switch (state) {
        case PollingOperationStateReady:
            return @"isReady";
        case PollingOperationStateExecuting:
            return @"isExecuting";
        case PollingOperationStateFinished:
            return @"isFinished";
        default: {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunreachable-code"
            return @"state";
#pragma clang diagnostic pop
        }
    }
}

static NSString * const kPollingLockName = @"polling.operation.lock";

@interface AbstractPollingOperation()

@property (nonatomic, assign) PollingOperationState state;
@property (nonatomic, strong) NSRecursiveLock *lock; // 递归锁， 可以在同个线程中加锁



- (void)pollingDidStart;
- (void)pollingFinish;
- (void)pollingCancel;

@end

@implementation AbstractPollingOperation

+ (void)startRunloop {
    @autoreleasepool {
        [[NSThread currentThread] setName:@"m.thread.polling"];
        
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runLoop run];
    }
}

+ (NSThread *)pollingThread {
    static NSThread *_networkRequestThread = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _networkRequestThread = [[NSThread alloc] initWithTarget:self selector:@selector(startRunloop) object:nil];
        [_networkRequestThread start];
    });
    
    return _networkRequestThread;
}

- (instancetype)init {
    if (self = [super init]) {
        
        _state = PollingOperationStateReady; // 默认是的 ready， 否则operate 不会start
        
        _lock = [[NSRecursiveLock alloc] init];
        _lock.name = kPollingLockName;
    }
    return self;
}


- (void)setState:(PollingOperationState)state {
    [self.lock lock];
    NSString *oldStateKey = PollingKeyPathFromOperationState(self.state);
    NSString *newStateKey = PollingKeyPathFromOperationState(state);
    
    [self willChangeValueForKey:newStateKey];
    [self willChangeValueForKey:oldStateKey];
    _state = state;
    [self didChangeValueForKey:oldStateKey];
    [self didChangeValueForKey:newStateKey];
    [self.lock unlock];
}

- (void)setCompletionBlock:(void (^)(void))block {
    [self.lock lock];
    if (!block) {
        [super setCompletionBlock:nil];
    } else {
        __weak __typeof(self)weakSelf = self;
        [super setCompletionBlock:^ {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_group_t group = polling_operation_completion_group();
            dispatch_queue_t queue = dispatch_get_main_queue();
#pragma clang diagnostic pop
            
            dispatch_group_async(group, queue, ^{
                block();
            });
            
            dispatch_group_notify(group, polling_operation_completion_queue(), ^{
                [strongSelf setCompletionBlock:nil];
            });
        }];
    }
    [self.lock unlock];
}

- (BOOL)isReady {
    return self.state == PollingOperationStateReady && [super isReady];
}

- (BOOL)isExecuting {
    return self.state == PollingOperationStateExecuting;
}

- (BOOL)isFinished {
    return self.state == PollingOperationStateFinished;
}

- (BOOL)isConcurrent {
    return YES;
}

- (void)start {
    [self.lock lock];
    if ([self isCancelled]) {
        [self performSelector:@selector(pollingCancel) onThread:[[self class] pollingThread] withObject:nil waitUntilDone:NO modes:@[NSRunLoopCommonModes]];
    } else if ([self isReady]) {
        self.state = PollingOperationStateExecuting;
        [self performSelector:@selector(pollingDidStart) onThread:[[self class] pollingThread] withObject:nil waitUntilDone:NO modes:@[NSRunLoopCommonModes]];
    }
    [self.lock unlock];
}

- (void)pollingDidStart {
    [self.lock lock];
    if (![self isCancelled]) {
        [self pollingTask];
    }
    [self.lock unlock];
}

- (void)pollingTask {
    NSLog(@"impl subclass");
}

- (void)pollingFinish {
    if (self.pollingTimer) {
        [self.pollingTimer invalidate];
    }
    [self.lock lock];
    self.state = PollingOperationStateFinished;
    [self.lock unlock];
}

- (void)cancel {
    [self.lock lock];
    if (![self isFinished] && ![self isCancelled]) {
        [super cancel];
        
        if ([self isExecuting]) {
            [self performSelector:@selector(pollingCancel) onThread:[[self class] pollingThread] withObject:nil waitUntilDone:NO modes:@[NSRunLoopCommonModes]];
        }
    }
    [self.lock unlock];
}

- (void)pollingCancel {
    if (![self isFinished]) {
        [self pollingFinish];
    }
}

- (void)dealloc {
    NSLog(@"abstract operation dealloc");
}

@end
