//
//  KVOController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/18.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "KVOController.h"
#import "Person.h"

@interface KVOController ()

@property (nonatomic, strong) Person *kvoPerson;

@end

@implementation KVOController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"KVODemo" withLeft:[UIImage imageNamed:@"back_icon"]];
    
    [self kvcDemo];
    [self kvoDemo];
}

// kvc 就是 健值对 路径
- (void)kvcDemo {
    Person *person = [[Person alloc] init];
    
    // using the KVC accessor (getter) method
    NSString *originalName = [person valueForKey:@"name"];
    
    // using the KVC  accessor (setter) method.
    NSString *newName = @"MyNewName";
    [person setValue:newName forKey:@"name"];
    
    NSLog(@"%@ to: %@", originalName, newName);
}

- (void)kvoDemo {
    self.kvoPerson = [[Person alloc] init];
    [self.kvoPerson addObserver:self
             forKeyPath:@"name"
                options:0
                context:@"change"];
     [self.kvoPerson willChangeValueForKey:@"name"];
    [self.kvoPerson setValue:@"aaa" forKey:@"name"];
    [self.kvoPerson didChangeValueForKey:@"name"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    NSLog(@"change");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
