//
//  BZWButton.m
//  发送验证码后button读秒功能
//
//  Created by captain on 16/3/12.
//  Copyright © 2016年 codeIsMyGirl. All rights reserved.
//

#import "BZWButton.h"

@interface BZWButton ()

@property (nonatomic,assign) int seconds;

@end

@implementation BZWButton


#pragma mark - 按钮读秒功能 和 计时时间
- (void)buttonCountDownWithSeconds:(int )seconds {
    
    self.seconds = seconds;
    
    // 关闭 用户交互
    [self setEnabled:NO];
    
    // 创建 计时器 设置 即使间隔
    NSTimer *clockTimer = [NSTimer timerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(oneSecondPass:)
                                                userInfo:nil
                                                 repeats:YES];
    
    // 添加到RunLoop
    [[NSRunLoop mainRunLoop] addTimer:clockTimer forMode:NSDefaultRunLoopMode];
    
}


#pragma mark - 计时器调用的方法
- (void)oneSecondPass:(NSTimer *)clockTimer {
    
    if (self.seconds > 0) {
        
        --self.seconds;

        NSString *str = [NSString stringWithFormat:@"%d", self.seconds];
        
        // 设置当前状态的 label Title
        [self setTitle:str forState:UIControlStateDisabled];
        
        return;
    }
    
    // 开启
    [self setEnabled:YES];
    
    // 取消计时
    [clockTimer invalidate];
    
    // 释放计时器
    clockTimer = nil;
    
    // 设为空  否则 不完美
    NSString *str = @"";
    
    // 设置当前状态的 label Title
    [self setTitle:str forState:UIControlStateDisabled];
    
    // 安全判断 是否实现了block
    if (self.buttonCompletionBlock) {
        
        self.buttonCompletionBlock();
    }
    
}

@end
