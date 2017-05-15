//
//  EnlargeButton.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/12/29.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "EnlargeButton.h"
//#import "ImageUtils.h"

@interface EnlargeButton() {
    UIImageView *enlargeView;
//    UIView *enlargeView;
}

@end

@implementation EnlargeButton

- (id)init {
    if (self = [super init]) {
        [self addTarget:self action:@selector(clickDown:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(clickUpinside:) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(clickOutside:) forControlEvents:UIControlEventTouchDragOutside];
    }
    return self;
}

- (void)clickDown:(id)sender {

        [self enlargeView];
    
    [[self superview] addSubview:enlargeView];
}

- (void)clickUpinside:(id)sender {
//    NSLog(@"upinside");
    [enlargeView removeFromSuperview];
}

- (void)clickOutside:(id)sender {
//    NSLog(@"outinside");
    [enlargeView removeFromSuperview];
}

- (void)enlargeView {
    UIImage *image = [UIImage imageNamed:@"c_numKeyboardSmallLightButton"];
    CGRect rect = self.frame;
    rect.size.height *= 2;
    rect.size.width *= 2;
    rect.origin.x -= rect.size.width / 4;
    rect.origin.y -= rect.size.height;
    enlargeView = [[UIImageView alloc] initWithFrame:rect];
    [enlargeView setImage:image];
    
    UILabel *label = [[UILabel alloc] init];
    [label setFrame:enlargeView.bounds];
    [label setText:self.titleLabel.text];
    [label setTextColor:[UIColor blackColor]];
    [label setFont:[UIFont fontWithName:@"Avenir-Black" size:25.0f]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [enlargeView addSubview:label];
//    [enlargeView setImage:[ImageUtils imageWithView:self]];
//    NSLog(@"%f, %f", rect.size.width, rect.size.height);
//    [enlargeView setFrame:self.frame];
}

@end
