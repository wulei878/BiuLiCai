//
//  RCConversationViewController.h
//  RongIMKit
//
//  Created by xugang on 15/1/22.
//  Copyright (c) 2015年 RongCloud. All rights reserved.
//

#ifndef __RCConversationViewController
#define __RCConversationViewController
#import <UIKit/UIKit.h>
#import "RCBaseViewController.h"
#import "RCPluginBoardView.h"
#import "RCChatSessionInputBarControl.h"
#import "RCEmojiBoardView.h"
#import "RCThemeDefine.h"

@class RCMessageBaseCell;
@class RCMessageModel;

/**
 *  RCConversationViewController
 */
@interface RCConversationViewController : RCBaseViewController
/**
 *  targetId
 */
@property(nonatomic, strong) NSString *targetId;
/**
 *  targetName
 */
@property(nonatomic, strong) NSString *targetName;
/**
 *  conversationType
 */
@property(nonatomic) RCConversationType conversationType;
/**
 *  sendingCount
 */
@property(nonatomic, readonly) NSInteger sendingCount;
/**
 *  conversationMessageCollectionView
 */
@property(nonatomic, strong)
    UICollectionView *conversationMessageCollectionView;
/**
 *  conversationDataRepository
 */
@property(nonatomic, strong) NSMutableArray *conversationDataRepository;
/**
 *  UICollectionViewFlowLayout
 */
@property(nonatomic, strong) UICollectionViewFlowLayout *customFlowLayout;
/**
 *  输入工具栏
 */
@property(nonatomic, strong)
    RCChatSessionInputBarControl *chatSessionInputBarControl;
/**
 *  功能板
 */
@property(nonatomic, strong) RCPluginBoardView *pluginBoardView;
/**
 *  emoji
 */
@property(nonatomic, strong) RCEmojiBoardView *emojiBoardView;

/**
 *  init method
 *
 *  @param conversationType conversationType
 *  @param targetId         targetId
 *
 *  @return converation
 */
- (id)initWithConversationType:(RCConversationType)conversationType
                      targetId:(NSString *)targetId;

/**
 *  设置头像样式,请在viewDidLoad之前调用
 *
 *  @param avatarStyle avatarStyle
 */
- (void)setMessageAvatarStyle:(RCUserAvatarStyle)avatarStyle;
/**
 *  设置头像大小,请在viewDidLoad之前调用
 *
 *  @param size size
 */
- (void)setMessagePortraitSize:(CGSize)size;

/**
 *  注册消息Cell
 *
 *  @param cellClass  cellClass
 *  @param identifier identifier
 */
- (void)registerClass:(Class)cellClass
    forCellWithReuseIdentifier:(NSString *)identifier;
/**
 *  在会话界面删除消息并更新会话界面
 *
 *  @param model  被删除消息的model
 */
- (void)deleteMessage:(RCMessageModel *)model;
#pragma mark override
/**
 *  返回方法，如果继承，请重写该方法，并且优先调用父类方法;
 *
 *  @param sender 发送者
 */
- (void)leftBarButtonItemPressed:(id)sender;

#pragma mark override
/**
 *  重写方法实现自定义消息的显示
 *
 *  @param collectionView collectionView
 *  @param indexPath      indexPath
 *
 *  @return RCMessageTemplateCell
 */
- (RCMessageBaseCell *)rcConversationCollectionView:
                           (UICollectionView *)collectionView
                             cellForItemAtIndexPath:(NSIndexPath *)indexPath;
#pragma mark override
/**
 *  将要显示会话消息，可以修改RCMessageBaseCell的头像形状，添加自定定义的UI修饰
 *
 *  @param cell      cell
 *  @param indexPath indexPath
 */
- (void)willDisplayConversationTableCell:(RCMessageBaseCell *)cell
                             atIndexPath:(NSIndexPath *)indexPath;

#pragma mark override
/**
 *  重写方法实现自定义消息的显示的高度
 *
 *  @param collectionView       collectionView
 *  @param collectionViewLayout collectionViewLayout
 *  @param indexPath            indexPath
 *
 *  @return 显示的高度
 */
- (CGSize)
rcConversationCollectionView:(UICollectionView *)collectionView
                      layout:(UICollectionViewLayout *)collectionViewLayout
      sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark override
/**
 *  点击消息内容
 *
 *  @param model 数据
 */
- (void)didTapMessageCell:(RCMessageModel *)model;

#pragma mark override
/**
 *  点击头像事件
 *
 *  @param userId 用户的ID
 */
- (void)didTapCellPortrait:(NSString *)userId;

#pragma mark override
/**
 *  长按消息内容
 *
 *  @param model 数据
 */
- (void)didLongTouchMessageCell:(RCMessageModel *)model;

#pragma mark override
/**
 *  打开大图。开发者可以重写，自己下载并且展示图片。默认使用内置controller
 *
 *  @param model 图片消息model
 */
- (void)presentImagePreviewController:(RCMessageModel *)model;

#pragma mark override
/**
 *  打开地理位置。开发者可以重写，自己根据经纬度打开地图显示位置。默认使用内置地图
 *
 *  @param locationMessageContent 位置消息
 */
- (void)presentLocationViewController:
    (RCLocationMessage *)locationMessageContent;

#pragma mark override
/**
 *  重写方法，过滤消息或者修改消息
 *
 *  @param messageCotent 消息内容
 *
 *  @return 返回消息内容
 */
- (RCMessageContent *)willSendMessage:(RCMessageContent *)messageCotent;

#pragma mark override
/**
 *  重写方法，消息发送完成触发
 *
 *  @param stauts        0,成功，非0失败
 *  @param messageCotent 消息内容
 */
- (void)didSendMessage:(NSInteger)stauts
               content:(RCMessageContent *)messageCotent;

/**
 *  发送消息
 *
 *  @param messageContent 消息
 *
 *  @param pushContent push显示内容
 */
- (void)sendMessage:(RCMessageContent *)messageContent
        pushContent:(NSString *)pushContent;

/**
 *  发送图片消息，此方法会先上传图片到融云指定的图片服务器，在发送消息。
 *
 *  @param imageMessage 消息
 *
 *  @param pushContent push显示内容
 */
- (void)sendImageMessage:(RCImageMessage *)imageMessage
             pushContent:(NSString *)pushContent;

#pragma mark override
/**
 语音消息开始录音
 */
- (void)onBeginRecordEvent;

#pragma mark override
/**
 语音消息录音结束
 */
- (void)onEndRecordEvent;

#pragma mark override
/**
 *  点击pluginBoardView上item响应事件
 *
 *  @param pluginBoardView pluginBoardView
 *  @param index           index
 */
- (void)pluginBoardView:(RCPluginBoardView *)pluginBoardView
     clickedItemAtIndex:(NSInteger)index;
#pragma mark override
/**
 *  重写方法，通知更新未读消息数目，用于导航显示未读消息，当收到别的会话消息的时候，会触发一次。
 */
- (void)notifyUpdateUnReadMessageCount;
#pragma mark override
/**
 *  重写方法，输入框监控方法
 *
 *  @param inputTextView inputTextView 输入框
 *  @param range         range 范围
 *  @param text          text 文本
 */
- (void)inputTextView:(UITextView *)inputTextView
    shouldChangeTextInRange:(NSRange)range
            replacementText:(NSString *)text;
@end
#endif