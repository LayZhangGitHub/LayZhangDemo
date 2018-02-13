//
//  GLDrawController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/12/29.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "GLDrawController.h"
#import <OpenGLES/ES1/gl.h>
#import "Test01.h"
#import <GLKit/GLKit.h>

@interface GLDrawController ()<GLKViewDelegate> {
    GLfloat *vertexBuffer;
}

@end



@implementation GLDrawController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"gldemo" withLeft:[UIImage imageNamed:@"icon_back"]];
    [self glDemo];
    long a = 0;
    NSLog(@"%p", &a);
    a = 1;
    NSLog(@"%p", &a);
    a = 2;
    NSLog(@"%p", &a);
    a = 1;
    NSLog(@"%p", &a);
}

- (void)glDemo {
    
    GLKView *view = (GLKView *)self.view;
    view.backgroundColor = [UIColor clearColor];
    view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
    view.delegate = self;
    [EAGLContext setCurrentContext:view.context];
    
    vertexBuffer = (GLfloat*)calloc(sizeof(GLfloat) * 2 * 4, 1);
    memset(vertexBuffer, 0, 2 * 4 * sizeof(GLfloat));
    
    vertexBuffer[0] = -1;
    vertexBuffer[1] = 0;
    
    vertexBuffer[2] = 0;
    vertexBuffer[3] = 0.5;
    
    vertexBuffer[4] = 1;
    vertexBuffer[5] = 0;
    
    vertexBuffer[6] = 0;
    vertexBuffer[7] = -0.5;
}


- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glEnable(GL_BLEND);
    glDisable(GL_DEPTH_TEST);
    glBlendFunc(GL_SRC_ALPHA, GL_SRC_COLOR);
    
    glEnableClientState(GL_VERTEX_ARRAY);
    glClear(GL_COLOR_BUFFER_BIT);
    glColor4f(1, 0, 0, 1);
    
    glVertexPointer(2, GL_FLOAT, 0, vertexBuffer);
    glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
}

@end
