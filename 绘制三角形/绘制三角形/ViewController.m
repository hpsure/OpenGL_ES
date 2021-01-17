//
//  ViewController.m
//  绘制三角形
//
//  Created by hpsure on 1/9/21.
//  Copyright © 2021 hpsure. All rights reserved.
//

#import "ViewController.h"
#import "RenderView.h"
#import "GLESMath.h"
#import "GLESUtils.h"
@interface ViewController ()<GLKViewDelegate>
@property (nonatomic, strong)RenderView *renderView;
@property (nonatomic, assign)GLuint mPramgram;
@property (nonatomic, assign)CGFloat ScaleStride;
@property (nonatomic, strong)CADisplayLink *displayLink;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.renderView.delegate = self;
    [self.view addSubview:self.renderView];
    [self.displayLink setPaused:NO];
    self.ScaleStride = 0.05;
}

- (void)drawTriangle {
       static GLfloat triangleData[] = {
           0.5f, -0.5f, -0.0f,     1.0f, 0.0f, 0.0f,
           -0.5f, 0.5f, -0.0f,     0.0f, 1.0f, 1.0f,
           -0.5f, -0.5f, -0.0f,    0.0f, 0.0f, 0.7f,

           0.5f, 0.5f, -0.0f,      1.0f, 1.0f, 0.5f,
           -0.5f, 0.5f, -0.0f,     0.0f, 1.0f, 0.9f,
           0.5f, -0.5f, -0.0f,     1.0f, 0.0f, 0.3f,

       };
    GLuint attrBuffer;
    //(2)申请一个缓存区标识符
    glGenBuffers(1, &attrBuffer);
    //(3)将attrBuffer绑定到GL_ARRAY_BUFFER标识符上
    glBindBuffer(GL_ARRAY_BUFFER, attrBuffer);
    //(4)把顶点数据从CPU内存复制到GPU上
    glBufferData(GL_ARRAY_BUFFER, sizeof(triangleData), triangleData, GL_DYNAMIC_DRAW);

    GLuint vPosition = glGetAttribLocation(self.mPramgram, "vPosition");
    glEnableVertexAttribArray(vPosition);
    GLuint color = glGetAttribLocation(self.mPramgram, "color");
    glEnableVertexAttribArray(color);
    
    glVertexAttribPointer(vPosition, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(GLfloat), (float *)NULL);
    glVertexAttribPointer(color, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(GLfloat), (float *)NULL + 3);
    glDrawArrays(GL_TRIANGLES, 0, 6);
}

#pragma mark -Action
- (void)displayLinkAction:(CADisplayLink*)displayLink {
    [self.renderView display];
}

#pragma mark -GLKViewDelegate
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    self.ScaleStride += 2;
    glClearColor(0.2f, 0.5f, 0.7f, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    glUseProgram(self.mPramgram);
    GLuint projectionMatrix = glGetUniformLocation(self.mPramgram, "projectionMatrix");
    GLuint modelViewMatrix = glGetUniformLocation(self.mPramgram, "modelViewMatrix");
        float width = self.view.frame.size.width;
        float height = self.view.frame.size.height;
        KSMatrix4 _projectionMatrix;
        ksMatrixLoadIdentity(&_projectionMatrix);
        float aspect = width / height;
        ksPerspective(&_projectionMatrix, 30.0, aspect, 5.0f, 30.0f);
        glUniformMatrix4fv(projectionMatrix, 1, GL_FALSE, (GLfloat*)&_projectionMatrix.m[0][0]);
        KSMatrix4 _modelViewMatrix;
        ksMatrixLoadIdentity(&_modelViewMatrix);
        
        ksTranslate(&_modelViewMatrix, 0.0, 0.0, -10.0);
        KSMatrix4 _rotationMatrix;
        ksMatrixLoadIdentity(&_rotationMatrix);
        ksRotate(&_rotationMatrix, _ScaleStride, 0.0, 1, 0.0);
        ksMatrixMultiply(&_modelViewMatrix, &_rotationMatrix, &_modelViewMatrix);
        glUniformMatrix4fv(modelViewMatrix, 1, GL_FALSE, (GLfloat*)&_modelViewMatrix.m[0][0]);



    [self drawTriangle];
}

#pragma mark -getter
- (RenderView *)renderView {
    if (!_renderView) {
        _renderView = [[RenderView alloc] initWithFrame:self.view.bounds];
        _mPramgram = _renderView.program;
    }
    return _renderView;
}

- (CADisplayLink *)displayLink
{
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction:)];
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        _displayLink.paused = NO;
    }
    return _displayLink;
}
@end
