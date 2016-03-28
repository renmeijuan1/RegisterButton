//
//  BZWButton.h
//  发送验证码后button读秒功能
//
//  Created by captain on 16/3/12.
//  Copyright © 2016年 codeIsMyGirl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonCompletionBlock)();

@interface BZWButton : UIButton

/// 按钮读秒功能 和 计时时间
- (void)buttonCountDownWithSeconds:(int )seconds;

/// 结束 倒计时 的回调
@property (nonatomic,copy) ButtonCompletionBlock buttonCompletionBlock;

@end
