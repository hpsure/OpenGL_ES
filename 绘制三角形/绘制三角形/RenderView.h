//
//  RenderView.h
//  绘制三角形
//
//  Created by hpsure on 1/9/21.
//  Copyright © 2021 hpsure. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface RenderView : GLKView
@property (nonatomic,assign,readonly)GLuint program;
@end

NS_ASSUME_NONNULL_END
