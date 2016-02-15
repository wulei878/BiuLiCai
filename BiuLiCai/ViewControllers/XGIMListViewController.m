//
//  XGIMListViewController.m
//  XGCG
//
//  Created by Owen on 15/5/17.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGIMListViewController.h"

@implementation XGIMListViewController
+(instancetype)getInstance
{
    return [[UIStoryboard storyboardWithName:@"XGIMListViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"XGIMListViewController"];
}

-(void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
{
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType =model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.targetName =model.conversationTitle;
    conversationVC.title = model.conversationTitle;
    [self.navigationController pushViewController:conversationVC animated:YES];
}

-(void)rightBarButtonItemPressed:(id)sender
{
    // 您需要根据自己的 App 选择场景触发聊天。这里的例子是一个 Button 点击事件。
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType =ConversationType_PRIVATE; //会话类型，这里设置为 PRIVATE 即发起单聊会话。
    conversationVC.targetId = @"11111"; // 接收者的 targetId，这里为举例。
    conversationVC.targetName = @"小莫西干"; // 接受者的 username，这里为举例。
    conversationVC.title = @"小莫西干"; // 会话的 title。
    
    // 把单聊视图控制器添加到导航栈。
    [self.navigationController pushViewController:conversationVC animated:YES];
    
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
