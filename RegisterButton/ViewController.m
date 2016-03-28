//
//  ViewController.m
//  RegisterButton
//
//  Created by xwy on 16/3/28.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "ViewController.h"
#import "DeformationButton.h"

@interface ViewController ()
{
    DeformationButton *deformationButton;
    UIButton *button;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 设置整个控制器的背景图片
    self.view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"图片"].CGImage);
    
    [self loadContent1];
    [self loadContent2];
}

- (void)loadContent1 {
    
    // 这样创建一个对象 涨知识了
    deformationButton = [[DeformationButton alloc] initWithFrame:CGRectMake(100, 100, 140, 36) withColor:[self getColor:@"e13536"]];
    
    [self.view addSubview:deformationButton];
    
    // 设置按钮显示文字
    [deformationButton.forDisplayButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    
    // 设置按钮文字大小
    [deformationButton.forDisplayButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    
    // 设置按钮文字颜色
    [deformationButton.forDisplayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    // 添加点击事件
    [deformationButton addTarget:self action:@selector(btnEvent) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loadContent2 {
    
    button = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 140, 36)];
    [button setTitle:@"发送验证码" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    button.backgroundColor = [self getColor:@"e13536"];
    // 添加点击事件
    [button addTarget:self action:@selector(btnEvent2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

#pragma mark - 按钮点击事件
- (void)btnEvent{
    
    int countDown = 10;
    
    // 调用 计时 方法
    [deformationButton buttonCountDownWithSeconds:countDown];
    
    //    [SVProgressHUD showSuccessWithStatus:@"已发送..."];
    
    __weak typeof (deformationButton) weakdeformationButton = deformationButton;
    
    // 回调
    deformationButton.buttonCompletionBlock = ^(){
        
        // 还原动画状态
        weakdeformationButton.isLoading = !weakdeformationButton.isLoading;
        
    };
    
}

#pragma mark -- 按钮点击事件
- (void)btnEvent2{
    
    // 倒计时总时间
    __block int timeout = 10;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    // 设置每秒执行一次
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    
    dispatch_source_set_event_handler(_timer, ^{
        // 进行倒计时
        if (timeout <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [button setTitle:@"获取验证码" forState:UIControlStateNormal];
                button.userInteractionEnabled = YES;
                button.alpha = 1;
            });
        } else {
            NSString *strTime = [NSString stringWithFormat:@"%d", timeout];
            dispatch_async(dispatch_get_main_queue(), ^{
                [button setTitle:[NSString stringWithFormat:@"%@s后重新获取",strTime] forState:UIControlStateNormal];
                button.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

#pragma mark - 这仅仅是返回一个颜色 真的 感觉好高大上
- (UIColor *)getColor:(NSString *)hexColor {
    
    unsigned int red,green,blue;
    
    NSRange range;
    
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}


//设置状态栏的样式
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    //白
    return UIStatusBarStyleLightContent;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
