//
//  ViewController.m
//  绘制三角形
//
//  Created by hpsure on 1/9/21.
//  Copyright © 2021 hpsure. All rights reserved.
//

#import "ViewController.h"
#import "RenderView.h"
@interface ViewController ()<GLKViewDelegate>
@property (nonatomic, strong)RenderView *renderView;
@property (nonatomic, assign)GLuint mPramgram;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.renderView.delegate = self;
    [self.view addSubview:self.renderView];
}

- (void)drawTriangle {
       static GLfloat triangleData[] = {
           0.5f, -0.5f, -1.0f,     1.0f, 0.0f, 0.0f,
           -0.5f, 0.5f, -1.0f,     0.0f, 1.0f, 1.0f,
           -0.5f, -0.5f, -1.0f,    0.0f, 0.0f, 0.7f,
           
           0.5f, 0.5f, -1.0f,      1.0f, 1.0f, 0.5f,
           -0.5f, 0.5f, -1.0f,     0.0f, 1.0f, 0.9f,
           0.5f, -0.5f, -1.0f,     1.0f, 0.0f, 0.3f,

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

#pragma mark -GLKViewDelegate
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(0.2f, 0.5f, 0.7f, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    glUseProgram(self.mPramgram);
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
@end
