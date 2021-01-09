//
//  ShaderManager.h
//  OpenGL_test1
//
//  Created by hpsure on 1/9/21.
//  Copyright © 2021 hpsure. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES3/gl.h>
#import <OpenGLES/ES3/glext.h>
NS_ASSUME_NONNULL_BEGIN

@interface ShaderManager : NSObject
+ (instancetype)shareManager;
- (GLuint)loadShader:(NSString*)vertPath withfrag:(NSString *)fragPath;
- (BOOL)linkProgram;
@end

NS_ASSUME_NONNULL_END
