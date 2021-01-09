//
//  RenderView.m
//  绘制三角形
//
//  Created by hpsure on 1/9/21.
//  Copyright © 2021 hpsure. All rights reserved.
//

#import "RenderView.h"
#import <OpenGLES/ES3/glext.h>
#import <OpenGLES/ES3/gl.h>
#import "ShaderManager.h"
@interface RenderView()
@property (nonatomic, strong)EAGLContext *mContext;
@property (nonatomic, strong)ShaderManager *shaderManager;
@property (nonatomic, assign)GLuint program;
@end
@implementation RenderView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupContext];
        [self setupShaderManager];
    }
    return self;
}
- (void)setupContext {
    self.mContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
    self.context = self.mContext;
    self.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    [EAGLContext setCurrentContext:self.mContext];
}
- (void)setupShaderManager {
    NSString *vPath = [[NSBundle mainBundle] pathForResource:@"normal" ofType:@".vsh"];
    NSString *fPath = [[NSBundle mainBundle] pathForResource:@"normal" ofType:@".fsh"];
    self.shaderManager = [ShaderManager shareManager];
    self.program = [self.shaderManager loadShader:vPath withfrag:fPath];
    [self.shaderManager linkProgram];
}
@end
