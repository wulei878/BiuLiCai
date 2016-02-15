//
//  MBProgressHUD+CommonShow.m
//  Meet
//
//  Created by lihui on 14-5-22.
//  Copyright (c) 2014年 renren. All rights reserved.
//

#import "MBProgressHUD+CommonShow.h"

static NSTimeInterval kNotificationDefaultDuration = 0.8f;
static NSInteger const kShortAndLongTextThreshold = 10;
@implementation MBProgressHUD (CommonShow)

+ (void)showTimedTextHUDOnView:(UIView *)view message:(NSString *)message animated:(BOOL)animated
{
    if (message.length > kShortAndLongTextThreshold) {
        [self showTimedLongTextHUDOnView:view message:message animated:animated];
    } else {
        [self showTimedShortTextHUDOnView:view message:message animated:animated];
    }
}

+ (void)showTimedShortTextHUDOnView:(UIView *)view message:(NSString *)message animated:(BOOL)animated
{
    if (!view) {
        return;
    }
    [self removeAllHUDOnView:view animated:animated];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.labelFont = [UIFont boldSystemFontOfSize:18.0f];
    hud.margin = 10.0f;
    hud.yOffset = 0.0f;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:animated];
    [hud hide:animated afterDelay:kNotificationDefaultDuration];
}

+ (void)showTimedLongTextHUDOnView:(UIView *)view message:(NSString *)message animated:(BOOL)animated
{
    if (!view) {
        return;
    }
    [self removeAllHUDOnView:view animated:animated];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = message;
    hud.detailsLabelFont = [UIFont boldSystemFontOfSize:18.0f];
    hud.margin = 10.0f;
    hud.yOffset = 0.0f;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:animated];
    [hud hide:animated afterDelay:kNotificationDefaultDuration];
}

+ (void)showTimedTextHUDOnView:(UIView *)view
                       message:(NSString *)message
                      animated:(BOOL)animated
               completionBlock:(MBProgressHUDCompletionBlock)completionBlock
{
    if (message.length > kShortAndLongTextThreshold) {
        [self showTimedLongTextHUDOnView:view message:message animated:animated completionBlock:completionBlock];
    } else {
        [self showTimedShortTextHUDOnView:view message:message animated:animated completionBlock:completionBlock];
    }
}

+ (void)showTimedTextHUDOnView:(UIView *)view
                       message:(NSString *)message
                      animated:(BOOL)animated
                       yOffset:(CGFloat)yOffset
               completionBlock:(MBProgressHUDCompletionBlock)completionBlock
{
    if (message.length > kShortAndLongTextThreshold) {
        [self showTimedLongTextHUDOnView:view message:message animated:animated yOffset:yOffset completionBlock:completionBlock];
    } else {
        [self showTimedShortTextHUDOnView:view message:message animated:animated yOffset:yOffset completionBlock:completionBlock];
    }
}

+ (void)showTimedTextHUDOnView:(UIView *)view message:(NSString *)message animated:(BOOL)animated yOffset:(CGFloat)yOffset
{
    if (!view) {
        return;
    }

    [self removeAllHUDOnView:view animated:animated];

    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.labelFont = [UIFont boldSystemFontOfSize:18.0f];
    hud.margin = 10.0f;
    hud.yOffset = yOffset;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:animated];
    [hud hide:animated afterDelay:kNotificationDefaultDuration];
}

+ (void)showLoadingHUDOnView:(UIView *)view message:(NSString *)message animated:(BOOL)animated
{
    [self showLoadingHUDOnView:view yOffset:0.0 message:message animated:animated];
}

+ (void)showLoadingHUDOnView:(UIView *)view yOffset:(CGFloat)yOffset message:(NSString *)message animated:(BOOL)animated
{
    if (!view) {
        return;
    }

    [self removeAllHUDOnView:view animated:animated];

    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = message;
    hud.margin = 10.f;
    hud.yOffset = yOffset;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:animated];
}

+ (void)removeAllHUDOnView:(UIView *)view animated:(BOOL)animated
{
    if (!view) {
        return;
    }

    [MBProgressHUD hideAllHUDsForView:view animated:animated];
}

+ (void)showTimedHUDOnView:(UIView *)view text:(NSString *)text image:(UIImage *)image animated:(BOOL)animated
{
    [self removeAllHUDOnView:view animated:animated];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc]initWithImage:image];
    hud.labelText = text;
    hud.margin = 30.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:animated];
    [hud hide:animated afterDelay:kNotificationDefaultDuration];
}

+ (void)showTimedDetailsTextHUDOnView:(UIView *)view message:(NSString *)message animated:(BOOL)animated
{
    [self showTimedDetailsTextHUDOnView:view message:message animated:animated time:0];
}

+ (void)showTimedDetailsTextHUDOnView:(UIView *)view message:(NSString *)message animated:(BOOL)animated time:(CGFloat)time
{
    if (!view) {
        return;
    }

    [self removeAllHUDOnView:view animated:animated];

    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = message;
    hud.detailsLabelFont = [UIFont boldSystemFontOfSize:18.0f];
    hud.margin = 10.0f;
    hud.yOffset = 0.0f;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:animated];
    time = time ? : kNotificationDefaultDuration;
    [hud hide:animated afterDelay:time];
}

+ (void)showTimedLongTextHUDOnView:(UIView *)view
                           message:(NSString *)message
                          animated:(BOOL)animated
                   completionBlock:(MBProgressHUDCompletionBlock)completionBlock
{
    if (!view) {
        return;
    }
    [self removeAllHUDOnView:view animated:animated];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = message;
    hud.detailsLabelFont = [UIFont boldSystemFontOfSize:18.0f];
    hud.margin = 10.0f;
    hud.yOffset = 0.0f;
    hud.completionBlock = completionBlock;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:animated];
    [hud hide:animated afterDelay:kNotificationDefaultDuration];
}

+ (void)showTimedShortTextHUDOnView:(UIView *)view
                            message:(NSString *)message
                           animated:(BOOL)animated
                    completionBlock:(MBProgressHUDCompletionBlock)completionBlock
{
    if (!view) {
        return;
    }
    [self removeAllHUDOnView:view animated:animated];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.labelFont = [UIFont boldSystemFontOfSize:18.0f];
    hud.margin = 10.0f;
    hud.yOffset = 0.0f;
    hud.completionBlock = completionBlock;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:animated];
    [hud hide:animated afterDelay:kNotificationDefaultDuration];
}

+ (void)showTimedLongTextHUDOnView:(UIView *)view
                           message:(NSString *)message
                          animated:(BOOL)animated
                           yOffset:(CGFloat)yOffset
                   completionBlock:(MBProgressHUDCompletionBlock)completionBlock
{
    if (!view) {
        return;
    }
    [self removeAllHUDOnView:view animated:animated];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = message;
    hud.detailsLabelFont = [UIFont boldSystemFontOfSize:18.0f];
    hud.margin = 10.0f;
    hud.yOffset = yOffset;
    hud.completionBlock = completionBlock;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:animated];
    [hud hide:animated afterDelay:kNotificationDefaultDuration];
}

+ (void)showTimedShortTextHUDOnView:(UIView *)view
                            message:(NSString *)message
                           animated:(BOOL)animated
                            yOffset:(CGFloat)yOffset
                    completionBlock:(MBProgressHUDCompletionBlock)completionBlock
{
    if (!view) {
        return;
    }
    [self removeAllHUDOnView:view animated:animated];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.labelFont = [UIFont boldSystemFontOfSize:18.0f];
    hud.margin = 10.0f;
    hud.yOffset = yOffset;
    hud.completionBlock = completionBlock;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:animated];
    [hud hide:animated afterDelay:kNotificationDefaultDuration];
}

@end
