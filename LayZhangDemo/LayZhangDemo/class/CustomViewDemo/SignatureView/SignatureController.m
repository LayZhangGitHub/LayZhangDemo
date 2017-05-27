//
//  SignatureVideController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/27.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "SignatureController.h"
#import "ZLSignatureView.h"

@interface SignatureController ()

@property(nonatomic, strong) ZLSignatureView *signatureView;

@end

@implementation SignatureController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"SignatureDemo" withLeft:[UIImage imageNamed:@"icon_back"]];
    
    [self addSignatureView];
    [self addActionButton];
    [self reloadData];
    
    NSDictionary *a = @{
                        @"1":@"2",
                        @"3":@"4"
                        };
    for (NSString *key in a.allKeys) {
        NSLog(@"key : %@, value: %@", key, [a objectForKey:key]);
    }
}

- (void)addSignatureView {
    _signatureView = [[ZLSignatureView alloc] init];
    [_signatureView setFrame:CGRectMake(30, 30, 200, 200)];
    [self.view addSubview:_signatureView];
    
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = [UIColor blackColor].CGColor;
    border.fillColor = nil;
    border.path = [UIBezierPath bezierPathWithRoundedRect:_signatureView.bounds cornerRadius:10.f].CGPath;
    border.frame = _signatureView.bounds;
    border.lineWidth = 2.f;
    border.lineCap = @"square";
    border.lineDashPattern = @[@5, @5];
    _signatureView.layer.cornerRadius = 10.f;
    [_signatureView.layer addSublayer:border];
}

- (void)addActionButton {
    UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 400, 200, 30)];
    UIButton *eraseButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    [saveButton setTitle:@"save" forState:UIControlStateNormal];
    [saveButton setBackgroundColor:[UIColor greenColor]];
    [eraseButton setTitle:@"erase" forState:UIControlStateNormal];
    [self.view addSubview:saveButton];
    [self.view addSubview:eraseButton];
    [saveButton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
}

- (void)save {
    
    UIImage *image =  _signatureView.signatureImage;
    NSData *imageData = [NSKeyedArchiver archivedDataWithRootObject:image];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"MyImage"];
    
    UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    [imageView setBackgroundColor:[UIColor greenColor]];
    [imageView setImage:image];
    [self.view addSubview:imageView];
}

- (void)reloadData {
    //    NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"MyImage"];
    //    UIImage *image = [NSKeyedUnarchiver unarchiveObjectWithData:imageData];
    //    if (image) {
    //        UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    //        [imageView setBackgroundColor:[UIColor greenColor]];
    //        [imageView setImage:image];
    //        [self.view addSubview:imageView];
    //    }
}
@end
