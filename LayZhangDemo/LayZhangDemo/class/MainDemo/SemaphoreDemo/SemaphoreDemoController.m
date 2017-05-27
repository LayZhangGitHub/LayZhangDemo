//
//  SemaphoreDemoController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/25.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "SemaphoreDemoController.h"

@interface SemaphoreDemoController () {
    Boolean isalive;
}
@end

@implementation SemaphoreDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"SemaphoreDemo" withLeft:[UIImage imageNamed:@"icon_back"]];
//    [self semaphoreDemo01];
//    [self semaphoreDemo02];
    [self semaphoreDemo03];
}

- (void)semaphoreDemo01 {
    //传递的参数是信号量最初值,下面例子的信号量最初值是1
    dispatch_semaphore_t signal = dispatch_semaphore_create(1);
    dispatch_time_t overTime = dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 当信号量是0的时候,dispatch_semaphore_wait(signal, overTime);这句代码会一直等待直到overTime超时.
        //这里信号量是1 所以不会在这里发生等待.
        dispatch_semaphore_wait(signal, overTime);
        {
            NSLog(@"需要线程同步的操作1 开始");
            sleep(2);
            NSLog(@"需要线程同步的操作1 结束");
        }
        long signalValue = dispatch_semaphore_signal(signal);//这句代码会使信号值 增加1
        //并且会唤醒一个线程去开始继续工作,如果唤醒成功,那么返回一个非零的数,如果没有唤醒,那么返回 0
        
        NSLog(@"%ld",signalValue);
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        dispatch_semaphore_wait(signal, overTime);
        sleep(2);
        NSLog(@"需要线程同步的操作2");
        long signalValue = dispatch_semaphore_signal(signal);
        
        NSLog(@"%ld",signalValue);
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(4);
        dispatch_semaphore_wait(signal, overTime);
        NSLog(@"需要线程同步的操作3");
//        dispatch_semaphore_signal(signal);
        long signalValue = dispatch_semaphore_signal(signal);
        
        NSLog(@"%ld",signalValue);
    });
}

- (void)semaphoreDemo02 {
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(10);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0; i < 100; i++)
    {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        //注意这里信号量从10开始递减,并不会阻塞循环.循环10次,递减到0的时候,开始阻塞.
        NSLog(@"-------");
        dispatch_group_async(group, queue, ^{
            NSLog(@"%i",i);
            sleep(1);
            long signalValue = dispatch_semaphore_signal(semaphore);
            
            NSLog(@".....%ld", signalValue);
        });//创建一个新线程,并在线程结束后,发送信号量,通知阻塞的循环继续创建新线程.
    }
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
//    如此循环就形成了对并发的控制，如上就是一个并发数为10的一个线程队列。
}

- (void)semaphoreDemo03 {
    isalive = true;
    __block int product = 0;
    dispatch_semaphore_t sem = dispatch_semaphore_create(10);
    
    // 消费
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ //消费者队列
        
        while (isalive) {
            if(!dispatch_semaphore_wait(sem, dispatch_time(DISPATCH_TIME_NOW, DISPATCH_TIME_FOREVER))){
                ////非 0的时候,就是成功的timeout了,这里判断就是没有timeout   成功的时候是 0
                
                NSLog(@"消费%d产品",product);
                product--;
            };
        }
    });
    
    // 生产
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ //生产者队列
        while (isalive) {
            
            sleep(1); //wait for a while
            product++;
            NSLog(@"生产%d产品",product);
            dispatch_semaphore_signal(sem);
        }
    });
}

- (void)dealloc {
    NSLog(@"semaphore dealloc");
    isalive=  false;
}

@end
