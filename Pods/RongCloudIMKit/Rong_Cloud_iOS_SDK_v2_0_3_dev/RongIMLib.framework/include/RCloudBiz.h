//
//  RCloudBiz.h
//  rcsdk
//
//  Modify by 刘亚丰 on 2014-09-16.
//  1.分类整理接口函数
//  2.接口参数调整
//  3.接口添加注释信息
//  Copyright (c) 2014-2015 RongCloud. All rights reserved.
//

#ifndef rcsdk_Biz_h
#define rcsdk_Biz_h
#include "BizListener.h"

#include <string>
using namespace std;

class ICallback;
#ifdef __cplusplus
extern "C" {
#endif
    
    /**
     *  初始化全局实例
     *
     *  @param appid        应用id
     *  @param appName      应用名称
     *  @param deviceId     设备id
     *  @param localPath    缓存路径
     *  @param databasePath 数据库存储路径
     *
     *  @return client指针   NULL - 失败 非NULL - 成功
     */
    void* InitClient(const char *appId,const char* appName,const char* deviceId,const char* localPath,const char* databasePath);
    
    /**
     *  建立服务器连接
     *
     *  @param token    登录token，由后台配置从网站得到
     *  @param listener 监听 连接结果通过监听中的函数通知
     */
    void ConnectTo(const char* token,ConnectAckListener* listener);

    /**
     *  断开服务器连接，不会删除全局实例
     *
     *  @param state 断开时指定的状态
     */
    void Disconnect(int state);
    
    /**
     *  iOS设置DeviceToken
     *
     *  @param deviceId DeviceToken
     */
    void SetDeviceId(const char* deviceId);
   
    /**
     *  设置消息监听
     *
     *  @param listener 消息监听器
     */
    void SetMessageListener(MessageListener* listener);
    
    /**
     *  设置异常监听
     *
     *  @param listener 监听器
     */
    void SetExceptionListener(ExceptionListener* listener);
    
    /**
     *  注册信息类别
     *
     *  @param clazzName   信息类别
     *  @param operateBits 操作位 1 - 是否入库 2 - 是否标记为已读
     *
     *  @return 操作结果 true - 成功 false - 失败
     */
    bool RegisterMessageType(const char* clazzName,const unsigned int operateBits);
    
    /**
     *  备注：
     *  上层定义的 PRIVATE DISCUSSION 等值需要与此对应，因为暂时的CHATROOM和TEMPGROUP都未使用，
     *  使用时，这两个值需匹配上。
     *  PB中通道的定义如下
     *  enum ChannelType 
     *  {
     *      PERSON = 1,
     *      PERSONS = 2,
     *      GROUP = 3,
     *      TEMPGROUP = 4,
     *      CUSTOMERSERVICE = 5
     *  };
     */
    
    /*
     ************************************************
     *  会话处理相关函数
     ************************************************
     */
    
    /**
     *  发送消息
     *
     *  @param targetId     交互方id
     *  @param categoryId   通道类型 
                                    1 - PRIVATE             单人
                                    2 - DISCUSSION          讨论组
                                    3 - GROUP               群组
                                    4 - CHATROOM            聊天室
                                    5 - CUSTOMERSERVICE     客服
                                    6 - SYSTEM              系统消息
                                    7 - MC                  MC消息
                                    8 - MP                  MP消息
     *  @param transferType 传输类别 
                                    1 - S 消息数据服务器不缓存，不保证信息到达接收方
                                    2 - N 消息数据服务器缓存，交互方会收到通知消息
                                    3 - P 消息数据服务器缓存，交互方不在线会收到PUSH消息
     *  @param clazzname    消息类别
     *  @param message      消息内容 json内容
     *  @param messageId    消息id 消息在数据库中的Id
     *  @param listener     发送监听
     */
    void SendMessage(const char* targetId, int categoryId, int transferType,const char* clazzname,const char* message,const char* push,long messageId,PublishAckListener* listener);
    
    /**
     *  信息入库
     *
     *  @param targetId   交互方id
     *  @param categoryId 通道类型
     *  @param clazzName  消息类别
     *  @param senderId   发送方id
     *  @param message    消息内容
     *
     *  @return 信息在库中的id -1 失败 >0 成功
     */
    long SaveMessage(const char* targetId, int categoryId, const char* clazzName, const char* senderId, const char* message,const char* push);
    
    /**
     *  设置草稿
     *
     *  @param targetId     交互方id
     *  @param categoryId   通道类型
     *  @param draftMessage 草稿内容 NULL - 清除草稿 非NULL - 设置草稿
     *
     *  @return 操作结果 true - 成功 false - 失败
     */
    bool SetTextMessageDraft(const char* targetId,int categoryId,const char* draftMessage);
    
    /**
     *  获取草稿
     *
     *  @param targetId     交互方id
     *  @param categoryId   通道类型
     *  @param draftMessage 草稿内容
     *
     *  @return 操作结果 true - 成功 false - 失败
     */
    bool GetTextMessageDraft(const char* targetId,int categoryId,CDataBuffer& draftMessage);
    
    /**
     *  设置会话置顶
     *
     *  @param targetId   交互方id
     *  @param categoryId 通道类型
     *  @param bTop       是否置顶 true - 置顶 false - 取消置顶
     *
     *  @return 操作结果 true - 成功 false - 失败
     */
    bool SetIsTop(const char* targetId,int categoryId,bool bTop);
    
    /**
     *  删除消息
     *
     *  @param targetId   交互方id
     *  @param categoryId 通道类型
     *
     *  @return 操作结果 true - 成功 false - 失败
     */
    bool ClearMessages(const char* targetId,int categoryId);
    
    /**
     *  删除某个会话
     *
     *  @param targetId   交互方id
     *  @param categoryId 通道类型
     *
     *  @return 操作结果 true - 成功 false - 失败
     */
    bool RemoveConversation(const char* targetId,int categoryId);
    
    /**
     *  清除会话消息的未读状态
     *
     *  @param targetId   交互方id
     *  @param categoryId 通道类型
     *
     *  @return 操作结果 true - 成功 false - 失败
     */
    bool ClearUnread(const char* targetId,int categoryId);

    /**
     *  获取分页消息，result需要在外面delete
     *
     *  @param targetId   交互方id
     *  @param categoryId 通道类型
     *  @param lastId     消息id
     *  @param count      选取消息条数
     *  @param result     json结构的消息列表
     *
     *  @return 操作结果 true - 成功 false - 失败
     */
    bool GetPagedMessage(const char* targetId,int categoryId,long lastId,int count,CDataBuffer& dataBuffer);
    bool GetPagedMessageEx(const char* targetId,int categoryId,long lastId,int count,CMessageInfo** mi,int& cnt);
    bool SearchMessages(const char* searchText,long lastId,int count,CDataBuffer& dataBuffer);
    bool SearchMessagesEx(const char* searchText,long lastId,int count,CMessageInfo** mi,int& cnt);

    bool LoadHistoryMessage(const char* targetId,int categoryId,int64_t recordTime, int rowCount);
    void SubscribeAccount(const char* targetId,int categoryId,bool subscribe, PublishAckListener* listener);
    
    void DownloadAccounts();
    
    bool LoadAccountInfo(CAccountInfo** ai,int& count);
    /**
     *  获取分页消息，result需要在外面delete
     *
     *  @param targetId   交互方id
     *  @param categoryId 通道类型
     *  @param lastId     消息id
     *  @param count      选取消息条数
     *  @param result     json结构的消息列表
     *
     *  @return 操作结果 true - 成功 false - 失败
     */
    bool GetHistoryMessages(const char* targetId,int categoryId,const char* clazzName,long lastId,int count,CDataBuffer& dataBuffer);

    bool GetHistoryMessagesEx(const char* targetId,int categoryId,const char* clazzName,long lastId,int count,CMessageInfo** mi,int& cnt);
    /**
     *  获取最近消息，result需要在外面delete
     *
     *  @param targetId   交互方id
     *  @param categoryId 通道类型
     *  @param count      选取消息条数
     *  @param result     json结构的消息列表
     *
     *  @return 操作结果 true - 成功 false - 失败
     */
    bool GetLatestMessage(const char* targetId,int categoryId,int count,CDataBuffer& dataBuffer);
    bool GetLatestMessageEx(const char* targetId,int categoryId,int count,CMessageInfo** mi,int& cnt);

    /**
     *  获取最近的会话列表
     *
     *  @param conversationDict  交互方id
     *  @param conversationCount 通道类型
     *  @param DataBuffer        json结构的会话列表
     *
     *  @return 操作结果 true - 成功 false - 失败
     */
    bool GetConversationList(const ConversationEntry conversationDict[],int conversationCount,CDataBuffer& dataBuffer);
    
    bool GetConversationListEx(const ConversationEntry conversationDict[],int conversationCount,CConversation** conversations,int& count);
    
    /**
     *  获取首页最近的会话列表
     *
     *  @param conversationDict  交互方id
     *  @param conversationCount 通道类型
     *  @param DataBuffer        json结构的会话列表
     *
     *  @return 操作结果 true - 成功 false - 失败
     */
    bool GetTopConversationList(const ConversationEntry conversationDict[],int conversationCount,CDataBuffer& dataBuffer);
    
    bool GetTopConversationListEx(const ConversationEntry conversationDict[],int conversationCount,CConversation** conversations,int count);
    
    
    /**
     *  获取最近的某类信息的会话列表
     *
     *  @param targetId   交互方id
     *  @param categoryId 通道类型
     *  @param result     json结构的会话列表
     *
     *  @return 操作结果 true - 成功 false - 失败
     */
    bool GetConversation(const char* targetId,int categoryId,CDataBuffer& dataBuffer);
    
    bool GetConversationEx(const char* targetId,int categoryId,CConversation& conversation);
    
    /**
     *  获取未读消息数
     *
     *  @return >=0 未读信息条数-客服未读数 -1 数据库未初始化 
     */
    int GetTotalUnreadCount();
    /**
     *  获取未读信息数
     *
     *  @param targetId   交互方id
     *  @param categoryId 通道类型
     *
     *  @return >=0 未读消息数目 -1 数据库未初始化
     */
    int GetUnreadCount(const char* targetId,int categoryId);
    /**
     *  获取未读信息数
     *
     *  @param conversationDict  通道类型数组
     *  @param conversationCount 数组元素个数
     *
     *  @return >=0 未读消息数目 -1 数据库未初始化
     */
    int GetCateUnreadCount(const ConversationEntry conversationDict[],int conversationCount);
    
    /**
     *  设置阻止push信息
     *
     *  @param targetId   交互方id
     *  @param categoryId 通道类型
     *  @param block      是否阻止 true - 阻止 false - 取消阻止
     *  @param listener   监听器 推送值：0-未阻止 100-已阻止
     */
    void SetBlockPush(const char* targetId,int categoryId,bool block,BizAckListener* listener);
    
    /**
     *  获取阻止状态
     *
     *  @param targetId    交互方id
     *  @param categoryId  通道类型
     *  @param fetchRemote 是否从服务器获取 true - 服务器 false - 本地
     *  @param listener    监听器 推送值：0-未阻止 100-已阻止
     */
    void GetBlockPush(const char* targetId,int categoryId,BizAckListener* listener);
    
    bool GetBlockPushSync(const char* targetId,int categoryId,int& status);

    /**
     *  获取用户信息
     *
     *  @param userId      用户id
     *  @param listener    监听器 推送：用户id 用户名称 用户url
     */
    void GetUserInfo(const char* userId,UserInfoListener* listener);
    void GetUserInfoEx(const char* userId,int categoryId,UserInfoListener* listener);
    
    bool GetUserInfoSync(const char* userId,CUserInfo& ui);
    bool GetUserInfoExSync(const char* userId,int category_id,CUserInfo& ui);
    
    bool ClearConversations(const ConversationEntry conversationDict[],int conversationCount);

    /*
     ************************************************
     *  单条信息处理函数
     ************************************************
     */

    /**
     *  删除消息
     *
     *  @param messageId    消息id数组
     *  @param messageCount 消息数组数目
     *
     *  @return 操作结果：true - 成功 false - 失败
     */
    bool DeleteMessage(long messageId[],int messageCount);
    
    /**
     *  设置消息内容
     *
     *  @param messageId 消息id
     *  @param content   消息内容
     *
     *  @return 操作结果：true - 成功 false - 失败
     */
    bool SetMessageContent(long messageId,const char* content);
    bool SetMessageDisplayText(long messageId,const char* content);

    /**
     *  设置附加信息
     *
     *  @param messageId    消息id
     *  @param extraMessage 附加信息内容
     *
     *  @return 操作结果：true - 成功 false - 失败
     */
    bool SetTextMessageExtra(long messageId,const char* extraMessage);
   
    /**
     *  设置消息读取状态
     *
     *  @param messageId  消息id
     *  @param readStatus 消息读取状态 0 - 未读 1 - 已读
     *
     *  @return 操作结果：true - 成功 false - 失败
     */
    bool SetReadStatus(long messageId,int readStatus);
    
    /**
     *  设置消息发送状态
     *
     *  @param messageId  消息id
     *  @param readStatus 消息读取状态 10 - 发送中 20 - 发送失败 30 - 发送成功
     *
     *  @return 操作结果：true - 成功 false - 失败
     */
    bool SetSendStatus(long messageId,int sendStatus);
    

    /**
     *  获取本地时间与服务器时间的差值
     *
     *  @return 差值 = 本地时间 - 服务器时间
     */
    int64_t GetDeltaTime();
    

    /*
     ************************************************
     *  文件处理函数
     ************************************************
     */
    
    void GetUploadToken(int nType, TokenListener* pListener);
    void GetDownloadToken(int nType, const char* mimeKey, TokenListener* pListener);
    
    /**
     *  上传文件
     *
     *  @param targetId   交互方id
     *  @param categoryId 通道类型
     *  @param nType      媒体类型 1 - Image 2 - Audio 3 - Video
     *  @param pbData     媒体数据
     *  @param nl         数据长度
     *  @param pListener  图片监听器 推送：进度 操作结果：成功 推送网络地址 失败 失败原因
     */
    void SendFileWithUrl(const char* targetId,int categoryId,int nType,const unsigned char* pbData, long nl, ImageListener* pListener);
    
    /**
     *  下载文件
     *
     *  @param targetId   交互方id
     *  @param categoryId 通道类型
     *  @param nType      媒体类型 1 - Image 2 - Audio 3 - Video
     *  @param pszUrl     媒体网络地址
     *  @param pListener  图片监听器 推送：进度 操作结果：成功 推送网络地址 失败 失败原因
     */
    void DownFileWithUrl(const char* targetId,int categoryId,int nType,const char* pszUrl, ImageListener* pListener);
    
    /*
     ************************************************
     *  讨论组相关函数
     ************************************************
     */
    
    /**
     *  创建讨论组
     *
     *  @param discussionName 讨论组名称
     *  @param listener       监听器 推送 成功 - 讨论组id 失败 - 出错原因
     */
    void CreateDiscussion(const char* discussionName, CreateDiscussionListener* listener);
    
    /**
     *  创建讨论组
     *
     *  @param discussionName 讨论组名称
     *  @param userIds        邀请成员id数组
     *  @param idCount        数组元素个数
     *  @param listener       监听器 推送 成功 - 讨论组id 失败 - 出错原因
     */
    void CreateInviteDiscussion(const char* discussionName, const TargetEntry userIds[],int idCount, CreateDiscussionListener* listener);
    
    /**
     *  退出讨论组
     *
     *  @param discussionId  讨论组id
     *  @param listener      监听器 推送 0 - 成功 非0 - 失败
     */
    void QuitDiscussion(const char* discussionId, PublishAckListener* listener);
    
    /**
     *  邀请加入讨论组
     *
     *  @param discussionId 讨论组id
     *  @param userIds      用户id数组
     *  @param idCount      数组原始个数
     *  @param listener     监听器 推送 0 - 成功 非0 - 失败
     */
    void InviteMemberToDiscussion(const char* discussionId, const TargetEntry userIds[],int idCount, PublishAckListener* listener);
    
    /**
     *  将某人踢出讨论组
     *
     *  @param discussionId 讨论组id
     *  @param userId       踢出的用户id
     *  @param listener     监听器 推送 0 - 成功 非0 - 失败
     */
    void RemoveMemberFromDiscussion(const char* discussionId,const char* userId, PublishAckListener* listener);
    
    /**
     *  获取讨论组信息
     *
     *  @param discussionId 讨论组id
     *  @param categoryId   通道类型 只能是 discussion ，此参数稍后将被去掉
     *  @param listener     监听器 推送 0 - 成功，返回讨论组信息 非0 - 失败
     */
    void GetDiscussionInfo(const char* discussionId,int categoryId, DiscussionInfoListener* listener);
    
    bool GetDiscussionInfoSync(const char* discussionId,int categoryId,CDiscussionInfo& di);
    
    /**
     *  获取用户所有讨论组信息
     *
     *  @param startPage    起始页
     *  @param countPerPage 每页记录数
     *  @param listener     监听器 推送 0 - 成功，返回讨论组信息数组 非0 - 失败
     */
    void SelfDiscussions(int startPage, int countPerPage, DiscussionInfoListener* listener);
    
    /**
     *  讨论组改名
     *
     *  @param discussionId   讨论组id
     *  @param discussionName 讨论组名称
     *  @param listener       监听器 推送 0 - 成功 非0 - 失败
     */
    void RenameDiscussion(const char* discussionId,const char* discussionName, PublishAckListener* listener);
    
    /**
     *  设置讨论组开放成员邀请
     *
     *  @param discussionId 讨论组id
     *  @param inviteStatus 邀请状态 0 - 开放邀请 1 - 关闭开放邀请
     *  @param listener     监听器 推送 0 - 成功 非0 - 失败
     */
    void SetInviteStatus(const char* discussionId,int inviteStatus, PublishAckListener* listener);
    
    /**
     *  设置讨论组、群组会话状态
     *
     *  @param targetId    讨论组id
     *  @param categoryId  类别
     *  @param groupStatus 状态值 406-不在讨论组中 407-讨论组不存在
     *
     *  @return 返回 成功 失败
     */
    bool SetGroupStatus(const char* targetId, int categoryId, int groupStatus);
    
    /*
     ************************************************
     *  群组相关函数
     ************************************************
     */
    
    /**
     *  同步群组，将群组发送到服务器
     *
     *  @param groupIds 群组id数组
     *  @param idCount  数组元素个数
     *  @param listener 监听器 推送 0 - 成功 非0 - 失败
     */
    void SyncGroups(TargetEntry groupIds[],int idCount,PublishAckListener* listener);
    
    /**
     *  加入群组，将群组发送到服务器
     *
     *  @param groupIds 群组id数组
     *  @param idCount  数组元素个数
     *  @param listener 监听器 推送 0 - 成功 非0 - 失败
     */
    void JoinGroup(TargetEntry groupIds[],int idCount,PublishAckListener* listener);
    
    /**
     *  退出群组，将群组发送到服务器
     *
     *  @param groupIds 群组id数组
     *  @param idCount  数组元素个数
     *  @param listener 监听器 推送 0 - 成功 非0 - 失败
     */
    void QuitGroup(TargetEntry groupIds[],int idCount,PublishAckListener* listener);
    
    void JoinChatRoom(const char* targetId,int conversationType,int messageCount,PublishAckListener* listener);
    
    void QuitChatRoom(const char* targetId,int conversationType,PublishAckListener* listener);
    
    /*
     ************************************************
     *  黑名单系列函数
     ************************************************
     */
    
    /**
     *  加入黑名单
     *
     *  @param userId   用户id
     *  @param listener 监听器 推送 0 - 成功 非0 - 失败
     */
    void AddToBlacklist(const char* userId, PublishAckListener* listener);
    
    /**
     *  移出黑名单
     *
     *  @param userId   用户id
     *  @param listener 监听器 推送 0 - 成功 非0 - 失败
     */
    void RemoveFromBlacklist(const char* userId, PublishAckListener* listener);
    
    /**
     *  获取用户黑名单状态
     *
     *  @param userId   用户id
     *  @param listener 监听器 推送 0 - 成功 非0 - 失败
     */
    void GetBlacklistStatus(const char* userId, BizAckListener* listener);
    
    /**
     *  获取黑名单列表
     *
     *  @param listener 监听器 推送 0 - 黑名单列表信息 非0 - 失败
     */
    void GetBlacklist(BlacklistInfoListener* listener);
    
    /**
     *  设置关闭push时间
     *
     *  @param startTime 关闭起始时间 格式 HH:MM:SS
     *  @param spanMins  间隔分钟数 0 < t < 1440
     */
    void AddPushSetting(const char* startTime,int spanMins,PublishAckListener* listener);
    void RemovePushSetting(PublishAckListener* listener);
    void QueryPushSetting(PushSettingListener* listener);

    
    /**
     *  接收应用的环境改变事件通知
     *
     *  @param nType     事件类型，101-网络切换，102-应用进入后台，103-应用进入前台，104-锁屏，105-心跳，106-屏幕解锁
     *  @param pbData    依据nType的事件附加数据，待定
     *  @param nDataSize 数据大小，字节数
     *  @param pListener 事件改变的回调
     */
    void EnvironmentChangeNotify(int nType, unsigned char* pbData, int nDataSize, EnvironmentChangeNotifyListener* pListener);
    /**
     *  android设置唤醒的监听器
     *
     *  @param pListener 唤醒监听器
     */
    void SetWakeupQueryListener(WakeupQueryListener* pListener);
    /**
     *  获取SDK版本号
     */
    const char*  BizGetSDKPackageVersion();
    /**
     *  设置导航地址
     *
     *  @param pszUrl 导航地址
     */
    bool BizSetNaviUrl(const char* pszUrl);
    
    /**
     *  设置设备信息
     *
     *  @param manufacturer 设备生产商
     *
     *  @param model 设备型号
     *
     *  @param osVersion 设备系统版本
     *
     *  @param network 设备当前使用的网络
     *
     *  @param networkOperator 网络运营商
     */
    void SetDeviceInfo(const char* manufacturer,const char* model,const char* osVersion,const char* network,const char* networkOperator);
    
    int RcCheckNetwork(bool flag);
    
    void SearchAccount(const char* targetId,int businessType,int searchType,AccountListener* listener);
    
    void SetUserData(const char* ext,PublishAckListener* listener);
    void GetUserData(CreateDiscussionListener* listener);
    
#ifdef __cplusplus
}
#endif

#endif
