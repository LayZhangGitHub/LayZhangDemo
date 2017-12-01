//
//  AsyncToSyncController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/8/21.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "AsyncToSyncController.h"

@interface AsyncToSyncController ()

@end

static const void * const kClassHasBeenHookedKey = &kClassHasBeenHookedKey;

@implementation AsyncToSyncController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"AsyncToSync"];
    
    NSString *returnString = [self test];
    NSLog(@"%@", returnString);
    
    
    NSNumber *hasBeenHooked = objc_getAssociatedObject(self, kClassHasBeenHookedKey);
    if (!hasBeenHooked.boolValue) {
        objc_setAssociatedObject(self, kClassHasBeenHookedKey, @YES, OBJC_ASSOCIATION_RETAIN);
    }
    
}

- (NSString *)test {
    
    NSMutableSet *set = [[NSMutableSet alloc] init];
    NSObject *object1 = [[NSObject alloc] init];
    NSLog(@"%lu", (unsigned long)object1.hash);
    NSLog(@"%lu", (unsigned long)set.hash);
    NSObject *object2 = [[NSObject alloc] init];
    NSLog(@"%lu", (unsigned long)object2.hash);
    NSLog(@"%lu", (unsigned long)set.hash);
    [set addObject:object1];
    NSLog(@"%lu", (unsigned long)set.hash);
    [set addObject:object2];
    NSLog(@"%lu", (unsigned long)set.hash);
    
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"run task 1");
        sleep(4);
        NSLog(@"complete task 1");
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    dispatch_semaphore_signal(semaphore);
    

    return @"retuen";
}

- (void)asyncTosync {
    NSLog(@"1");
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        sleep(1);
        NSLog(@"2");
        // todo
    });
    NSLog(@"3");
}


@end
