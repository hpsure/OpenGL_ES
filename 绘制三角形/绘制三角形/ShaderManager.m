//
//  ShaderManager.m
//  OpenGL_test1
//
//  Created by hpsure on 1/9/21.
//  Copyright © 2021 hpsure. All rights reserved.
//

#import "ShaderManager.h"
@interface ShaderManager()
@property (nonatomic, assign)GLuint mProgram;
@end
@implementation ShaderManager
+ (instancetype)shareManager {
    static dispatch_once_t once;
    static ShaderManager *_intance;
    dispatch_once(&once, ^{
        _intance = [[ShaderManager alloc] init];
    });
    return _intance;
}

- (GLuint)loadShader:(NSString*)vertPath withfrag:(NSString *)fragPath {
    GLuint verShader,fragShader;
    GLuint program = glCreateProgram();
    [self compileShader:&verShader type:GL_VERTEX_SHADER file:vertPath];
    [self compileShader:&fragShader type:GL_FRAGMENT_SHADER file:fragPath];
    
    glAttachShader(program, verShader);
    glAttachShader(program, fragShader);
    
    glDeleteShader(verShader);
    glDeleteShader(fragShader);
    self.mProgram = program;
    return program;
}

//编译shader
- (void)compileShader:(GLuint*)shader type:(GLenum)type file:(NSString *)file {
    NSString *content = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    const GLchar *source = (GLchar*)[content UTF8String];
    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
    GLint compileResult = GL_TRUE;
    glGetShaderiv(*shader,GL_COMPILE_STATUS,&compileResult);
    if (compileResult == GL_FALSE) {
        GLchar message[512];
        glGetShaderInfoLog(*shader,sizeof(message),0,&message[0]);
        NSString *messageString = [NSString stringWithUTF8String:message];
        NSLog(@"Program Compile  Error:%@",messageString);
        return;
    }
    NSLog(@"Program Compile Success");
}

- (BOOL)linkProgram {
   glLinkProgram(self.mProgram);
    GLint linkStatus;
    glGetProgramiv(self.mProgram, GL_LINK_STATUS, &linkStatus);
    if (linkStatus == GL_FALSE) {
        GLchar message[512];
        glGetProgramInfoLog(self.mProgram, sizeof(message), 0, &message[0]);
        NSString *messageString = [NSString stringWithUTF8String:message];
        NSLog(@"Program Link Error:%@",messageString);
        return NO;
    }else{
        NSLog(@"Program Link Success");
        return YES;
    }

}

@end
