# LayZhangDemo

## 把以前写的demo整合在一起 做一下简单的记录

### 1. XML 解析demo
#### 需求
简单的将XML中的配置信息解析，保存到缓存中。
使用的是 pod 'GDataXML-HTML','~> 1.3.0'
```
- (void)parseLangConfig{
//获取工程目录的xml文件
NSString *path = [NSString stringWithFormat:@"MessageLang"];
NSString *filePath = [[NSBundle mainBundle] pathForResource:path ofType:@"xml"];
NSData *xmlData = [[NSData alloc] initWithContentsOfFile:filePath];

//使用NSData对象初始化
GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData error:nil];

//获取根节点（resources）
GDataXMLElement *rootElement = [doc rootElement];

//获取根节点下的节点（Item）
NSArray * items = [rootElement elementsForName:@"item"];
[self parseElements:items atDictionary:_langMap];
}
```
---

### 2. TableViewCell NSTimer Demo
#### 需求
在TableViewCell 中 添加Timer倒计时，类似聚划算最后结束时间。
简单写完后，发现NSTimer并不释放，原因是Timer和Cell之间循环引用。
#### 解决方案
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

-----

### 3. 整理以前的KVO Demo
#### 以观察者的方式 实现KVO
关键代码是观察者订阅， 发送消息给观察者。

```
//订阅操作
- (void)observeValueForKeyPath:(NSString *)keyPath
ofObject:(id)object
change:(NSDictionary *)change
context:(void *)context；
//发送操作
- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;
```

----

### 4.谈谈 KVO delegate notification
#### 前提 看了离职同事写的代码，头痛。数据太乱了。。。
从viewcontroller 的 数据通信层面 自己总结一下，如何写耦合性低，易维护的App。

viewcontroller之间的数据通信，iOS应用中无处不在。
处理好viewController之间的数据通信，能使代码简洁易于维护。
最常用的就这三种KVO delegate notification。

只是自己的理解，说不上真确错误。

目的很简单，就是各个viewcontroller 之间，尽量保持独立，不要包含或持有其他的viewcontroller，降低耦合。这样，即使以后业务改了，也能很方便的只修改自己的代码，而不需要动别的。

那么怎么让viewcontroller之间互相不包含呢。 用事件传递的方式，KVO delegate notification 都可以。但三者应用的时机，还要看具体的情况。

后续。

----

### 5.load initialize
#### 总结

|  | load | initialize |
|:--|:---|:---|
|执行时间|在程序运行后立即执行|在类方法第一次被调用时执行，且只执行一次|
|若自身未定义，是否调用父类|否|是|
|Category中的调用| 全都执行，但是在比类方法晚|若父方法未执行，两个都会执行，且先父后子|

----

### 6.bool Boolean BOOL

| Name | type | True Value | False Value |
|:--|:--|:--|:--|
|bool|int|true|false|
|Boolean|unsigned char|TRUE|FALSE|
|BOOL|unsigned char|YES|NO|
|boolean_t|int|true|false|

int 当b!=0 有 b=true
unsigned char 当b=1 有 b=YES

----

### 7.__unsafe_unretain 和 __weak 区别

__weak 当释放指针指向的对象时， 指针转换为nil。
__unsafe_unretain 当释放指针指向的对象时， 指针还是继续指向原来的内存空间。（野指针）

----

### 8.消息发送

* #### 动态方法解析
当 Runtime 系统在 Cache 和类的方法列表(包括父类)中找不到要执行的方法时，Runtime 会调用 resolveInstanceMethod: 或 resolveClassMethod: 来给我们一次动态添加方法实现的机会。我们需要用 class_addMethod 函数完成向特定类添加特定方法实现的操作：
```
+ (BOOL)resolveInstanceMethod:(SEL)aSEL {
if (aSEL == @selector(resolveThisMethodDynamically)) {
class_addMethod([self class], aSEL, (IMP) dynamicMethodIMP, "v@:");
return YES;
}
return [super resolveInstanceMethod:aSEL];
}
```
* #### 消息重定向
消息转发机制执行前，Runtime 系统允许我们替换消息的接收者为其他对象。通过 - (id)forwardingTargetForSelector:(SEL)aSelector 方法。

```
- (id)forwardingTargetForSelector:(SEL)aSelector {
if(aSelector == @selector(mysteriousMethod:)){
return alternateObject;
}
return [super forwardingTargetForSelector:aSelector];
}
```

* #### 消息转发
当动态方法解析不做处理返回 NO 时，则会触发消息转发机制。这时 forwardInvocation: 方法会被执行，我们可以重写这个方法来自定义我们的转发逻辑：

```
- (void)forwardInvocation:(NSInvocation *)invocation {
TempClass * forwardClass = [TempClass new];
SEL sel = invocation.selector;
if ([forwardClass respondsToSelector:sel]) {
[invocation invokeWithTarget:forwardClass];
} else {
[self doesNotRecognizeSelector:sel];
}
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
//查找父类的方法签名
NSMethodSignature *signature = [super methodSignatureForSelector:selector];
if(signature == nil) {
signature = [NSMethodSignature signatureWithObjCTypes:"@@:"];

}
return signature;
}
```

### 9.runtime 操作函数

1. 类相关操作函数：以class为前缀命名

```
class_getName 　　                       // 获取类名
class_getSuperclass                       // 获取父类
class_isMetaClass                          // 判断类是不是元类
class_getInstanceSize                    // 获取实例大小
class_getInstanceVariable              // 获取实例成员变量
class_getClassVariable                   // 获取类成员变量
class_addIvar                                // 添加实例变量
class_copyIvarList                         // 获取整个成员变量表
class_getProperty                         // 获取指定属性
class_copyPropertyList                  // 获取整个属性表
class_addProperty                         // 添加属性
class_replaceProperty                   // 替换属性
class_addMethod                         // 添加方法
class_getInstanceMethod             // 获取实例方法
class_getClassMethod                  // 获取类方法
class_copyMethodList                  // 获取所有方法的数组
class_replaceMethod                   // 替代方法的实现
class_getMethodImplementation  // 返回方法的具体实现
class_respondsToSelector            // 类实例是否响应指定的selector
class_addProtocol                       // 添加协议
class_conformsToProtocol            // 返回类是否实现指定的协议
class_copyProtocolList                 // 返回类实现的协议列表
class_getVersion                         // 获取版本号
class_setVersion                         // 设置版本号

```

### 10.现有一个网络请求需要向服务器进行轮询，直到服务器返回成功为止，尝试次数为10次，每次请求的时间间隔为3秒。设计代码。

### 11.变量存储区
局部变量
作用域: 从定义的那一行开始,直到大括号结束或者遇到break return为止
存储位置: 栈

全局变量:
作用域:从定义变量的那一行直到文件结束
存储位置:静态区

成员变量:
作用域：创建对象时候有效,对象销毁(释放)结束
存储位置:存储在对象所在的堆内存中

### 12.block类型
arc 下
global block
```
int temp = 0;
void (^stackBlock)(void) = ^ {
//        NSLog(@"%d", temp);
};
```

stack block
```
int temp = 0;
NSLog(@"statck block %@", ^ {
NSLog(@"%d", temp);
});
```

有个 = 赋值操作， 系统会把block copy 到堆区
malloc stack
```
int temp = 0;
void (^stackBlock)(void) = ^ {
NSLog(@"%d", temp);
};
```
