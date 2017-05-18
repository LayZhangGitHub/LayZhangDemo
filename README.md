# LayZhangDemo

## 把以前写的demo整合在一起 

### 1. XML 解析demo

### 2. TableViewCell NSTimer Demo
#### 需求
在TableViewCell 中 添加Timer倒计时，类似聚划算最后结束时间。
简单写完后，发现NSTimer并不释放，原因是Timer和Cell之间循环引用。
### 解决方案
1. 在ViewController中加一个NSSet容器，持有当前已经创建的Timer，当ViewController释放的时候，同时将NSTimer释放
```
@property (nonatomic, strong) NSMutableSet<NSTimer *> *timerSet;

- (void)dealloc {
    for (NSTimer * timer in self.timerSet) {
        [timer invalidate];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // other code here
    [self.timerSet addObject:cell.timer];
    return cell;
}
```
但是这样写有点问题，1,作为cell，没有必要将Timer暴露出来。2,ViewController要持有Timer，不好以后维护，而且增加了一定的耦合性。
2. 在viewController dealloc的时候，发送需要释放的消息，使cell主动invalidate time。

```
// viewController.m
- (void)dealloc {
    [DefaultNotificationCenter postNotificationName:TimerCellDeallocNotification object:nil];
}

// cell.m
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

```
这样写代码简洁，又没有太多耦合。结构清晰容易维护。
