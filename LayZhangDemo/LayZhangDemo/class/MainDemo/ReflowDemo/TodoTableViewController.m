//
//  TodoTableViewController.m
//  Example
//
//  Created by Zepo on 25/09/2017.
//  Copyright © 2017 Zepo. All rights reserved.
//

#import "TodoTableViewController.h"
#import "Todo.h"
#import "TodoStore.h"

@interface TodoTableViewController ()
@property (nonatomic, strong) TodoStore *todoStore;
@property (nonatomic, copy) NSArray *todos;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *filterButton;

@property (nonatomic, strong) RFSubscription *subscription;

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TodoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNavBarWithTitle:@"TodoDemo" withLeft:[UIImage imageNamed:@"icon_back"]];
    
    self.todoStore = [[TodoStore alloc] init];
    self.todos = [self.todoStore visibleTodos];
    self.filterButton.title = [self stringFromVisibilityFilter:[self.todoStore visibilityFilter]];
    self.tableView = [[UITableView alloc] init];
    self.tableView.frame = CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT);
    [self.view addSubview:self.tableView];
    
    weakSelf(self);
    self.subscription = [self.todoStore subscribe:^(RFAction *action) {
        strongSelf(self);
        if (action.selector == @selector(actionSetVisibilityFilter:)) {
            self.filterButton.title = [self stringFromVisibilityFilter:[self.todoStore visibilityFilter]];
        }
        self.todos = [self.todoStore visibleTodos];
        [self.tableView reloadData];
    }];
}

- (NSString *)stringFromVisibilityFilter:(VisibilityFilter)filter {
    switch (filter) {
        case VisibilityFilterShowAll:
            return @"All";
            break;
        case VisibilityFilterShowActive:
            return @"Active";
            break;
        case VisibilityFilterShowCompleted:
            return @"Completed";
            break;
        default:
            NSAssert(NO, @"Unknown filter:%ld", (long)filter);
            return nil;
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.todos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    Todo *todo = [self.todos objectAtIndex:indexPath.row];
    cell.textLabel.text = todo.text;
    cell.accessoryType = todo.completed ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Todo *todo = [self.todos objectAtIndex:indexPath.row];
    [self.todoStore actionToggleTodo:todo.todoId];
}

#pragma mark - Actions

- (IBAction)addTodo:(id)sender {
    [self.navigationController pushViewController:[[TodoTableViewController alloc] init] animated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
    return;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add todo"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = @"New todo";
    }];
    
    __weak UIAlertController *weakAlert = alert;
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              __strong UIAlertController *alert = weakAlert;
                                                              UITextField *textField = alert.textFields.firstObject;
                                                              [self.todoStore actionAddTodo:textField.text];
                                                          }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                         }];
    
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:^ {
        UITextField *textField = alert.textFields.firstObject;
        textField.selectedTextRange = [textField textRangeFromPosition:[textField beginningOfDocument] toPosition:[textField endOfDocument]];
    }];
}

- (IBAction)changeFilter:(UIBarButtonItem *)sender {
    VisibilityFilter filter = [self.todoStore visibilityFilter];
    switch (filter) {
        case VisibilityFilterShowAll:
            [self.todoStore actionSetVisibilityFilter:VisibilityFilterShowActive];
            break;
        case VisibilityFilterShowActive:
            [self.todoStore actionSetVisibilityFilter:VisibilityFilterShowCompleted];
            break;
        case VisibilityFilterShowCompleted:
            [self.todoStore actionSetVisibilityFilter:VisibilityFilterShowAll];
            break;
        default:
            NSAssert(NO, @"Unknown filter:%ld", (long)filter);
            break;
    }
}

- (void)leftBtnDidTouch {
    [super leftBtnDidTouch];
//    self.subscription = nil;
//    NSLog(@"left");
}

- (void)dealloc {
    NSLog(@"dealloc");
}

@end
