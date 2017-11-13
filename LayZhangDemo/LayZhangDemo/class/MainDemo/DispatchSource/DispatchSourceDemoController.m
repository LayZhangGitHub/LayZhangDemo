//
//  DispatchSourceDemoController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/11/10.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "DispatchSourceDemoController.h"

#import <sys/socket.h>
#import <sys/un.h>

@interface DispatchSourceDemoController ()

@property (nonatomic, weak) dispatch_source_t timer;

@end

@implementation DispatchSourceDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"dispatchSource" withLeft:[UIImage imageNamed:@"icon_back"]];
    
//    [self dispatchSource];
    
//    [self test:[NSURL URLWithString:@"www.baidu.com"]];
    
    UIButton *button = [UIButton new];
    button.frame = CGRectMake(10, 110, 100 , 100);
    [self.view addSubview:button];
    [button setBackgroundColor:[UIColor blackColor]];
    [button addTarget:self action:@selector(dispatchTimerDemo) forControlEvents:UIControlEventTouchUpInside];
    
//    [self dispatchTimerDemo];
}

- (void)dispatchTimerDemo {
    /* step 1 */
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,//类型：定时器
                                   0, 0,
                                   queue);//block会被压入queue执行
    self.timer = timer;
    /* step 2 */
    dispatch_source_set_timer(timer,//dispatch source
                              dispatch_time(DISPATCH_TIME_NOW, 0* NSEC_PER_SEC),//现在开始
                              1* NSEC_PER_SEC,//间隔 1s
                              0);//精度0
    /* step 3 */
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"!");//整秒报时时的操作
    });
    /* step 4 */
    dispatch_resume(timer);//恢复source
}

//1. Timer dispatch sources：定时器类型，能够产生周期性的通知事件；
//2. Signal dispatch sources：信号类型，当UNIX信号到底时，能够通知应用程序；
//3. Descriptor sources：文件描述符类型，处理UNIX的文件或socket描述符，如：
//数据可读
//数据可写
//文件被删除、修改或移动
//文件的元信息被修改
//4. Process dispatch sources：进程类型，能够通知一些与进程相关的事件类型，如：
//当进程退出
//当进程调用了fork或exec
//当一个信号传递给了进程
//5. Mach port dispatch sources：端口匹配类型，能够通知一些端口事件的类型；
//6. Custom dispatch sources：自定义类型，可以自定义一些事件类型。

- (void)dispatchSource {
    
    NSArray *name = @[@"a",@"b",@"c",@"d",@"e"];
    
    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_ADD, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_event_handler(source, ^{
//        [progressIndicator incrementBy:dispatch_source_get_data(source)];
        NSLog(@"handler get data %ld", dispatch_source_get_data(source));
    });
    dispatch_resume(source);
    

    dispatch_apply(5, dispatch_get_global_queue(0, 0), ^(size_t index) {
        NSLog(@"done %@", name[index]);
        dispatch_source_merge_data(source, 1);
        sleep(1);
        // 调用 get 会使 这个值会被重置为0
        NSLog(@"%ld", dispatch_source_get_data(source));
    });
//
//    dispatch_apply(5, dispatch_get_global_queue(0, 0), ^(size_t index) {
//        NSLog(@"done %@", name[index]);
////        dispatch_source_merge_data(source, 1);
//    });
    
//    dispatch_apply([array count], globalQueue, ^(size_t index) {
//        // do some work on data at index
//        dispatch_source_merge_data(source, 1);
//    });
}

- (dispatch_source_t)read {
    // Prepare the file for reading.
    char *filename = "test";
    int fd = open(filename, O_RDONLY);
    if (fd == -1)
        return NULL;
    fcntl(fd, F_SETFL, O_NONBLOCK); // Avoid blocking the read operation
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t readSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_READ, fd, 0, queue);
    if (!readSource)
    {
        close(fd);
        return NULL;
    }
    // Install the event handler
    dispatch_source_set_event_handler(readSource, ^{
        size_t estimated = dispatch_source_get_data(readSource) + 1;
        // Read the data into a text buffer.
        char* buffer = (char*)malloc(estimated);
        if (buffer)
        {
            ssize_t actual = read(fd, buffer, (estimated));
            Boolean done = YES;
//            MyProcessFileData(buffer, actual); // Process the data.
            free(buffer); // Release the buffer when done.
            if (done) // If there is no more data, cancel the source.
                dispatch_source_cancel(readSource);
        }
    });
    dispatch_source_set_cancel_handler(readSource, ^{close(fd);}); // Install the cancellation handler
    dispatch_resume(readSource); // Start reading the file.
    return readSource;
}

- (NSData *)test:(NSURL *)url {
    NSString *path = url.path;
    if (path.length == 0) {
        return nil;
    }
    //uinix domin socket地址结构体
    //    struct    sockaddr_un {
    //        unsigned char    sun_len;    /* sockaddr len including null */
    //        sa_family_t    sun_family;    /* [XSI] AF_UNIX */
    //        char        sun_path[104];    /* [XSI] path name (gag) */
    //    };
    
    struct sockaddr_un nativeAddr;
    //设置为AF_UNIX unix domin
    nativeAddr.sun_family = AF_UNIX;
    
    //strlcpy(char *__dst, const char *__source, size_t __size);
    //赋值文件地址到结构体中
    strlcpy(nativeAddr.sun_path, path.fileSystemRepresentation, sizeof(nativeAddr.sun_path));
    nativeAddr.sun_len = SUN_LEN(&nativeAddr);
    //包裹成data
    NSData *interface = [NSData dataWithBytes:&nativeAddr length:sizeof(struct sockaddr_un)];
    return interface;
}

@end
