//
//  BizListener.h
//  rcsdk
//
//  Created by CC on 14-5-8.
//  Copyright (c) 2014-2015 RongCloud. All rights reserved.
//

#ifndef rcsdk_BizListener_h
#define rcsdk_BizListener_h

#define BIZ_ERROR_SUCCESS               (0)                 //成功

#define BIZ_ERROR_BASE                  (33001)                 //业务层错误号从33001开始
#define BIZ_ERROR_CLIENT_NOT_INIT       (BIZ_ERROR_BASE + 0)    //未调用初始化函数
#define BIZ_ERROR_DATABASE_ERROR        (BIZ_ERROR_BASE + 1)    //数据库初始化失败
#define BIZ_ERROR_INVALID_PARAMETER     (BIZ_ERROR_BASE + 2)    //传入参数无效
#define BIZ_ERROR_NO_CHANNEL            (BIZ_ERROR_BASE + 3)    //通道未创建
#define BIZ_ERROR_RECONNECT_SUCCESS     (BIZ_ERROR_BASE + 4)    //重连成功
#define BIZ_ERROR_CONNECTING            (BIZ_ERROR_BASE + 5)    //正在连接中，禁止重连



#define BIZ_DATA_BASE                   (0)                     //业务层数据类别从0开始
#define BIZ_DATA_DEFAULT                (BIZ_DATA_BASE + 0)     //新消息通知阻止
#define BIZ_DATA_BLOCK_PUSH             (BIZ_DATA_BASE + 100)   //新消息通知阻止
#define BIZ_DATA_NOT_IN_BLACKLIST       (BIZ_DATA_BASE + 101)   //查询结果，不在黑名单中


#define BIZ_TYPE_BASE                   (0)
#define BIZ_TYPE_CONNECT                (BIZ_TYPE_BASE + 1)     //连接


#ifndef int64_t
typedef	long long		int64_t;
#endif

/**
 *  数据缓存管理类
 *  数据自动申请与释放
 */
class CDataBuffer
{
public:
    CDataBuffer();
    ~CDataBuffer();
    
    /**
     *  获取数据，返回字串型的数据
     *
     *  @return 数据
     */
    char* GetData();
    
    /**
     *  设置数据，设置字串型的数据
     *
     *  @param data 数据
     */
    void SetData(const char* pData);
    
    /**
     *  获取数据长度
     *
     *  @return 数据长度
     */
    int GetLength();
    
    /**
     *  获取数据，外部指针空间需确保长度足够
     *
     *  @param pData 数据
     *  @param nLen  长度
     */
    void GetData(char* pData,int& nLen);
    
    /**
     *  设置数据
     *
     *  @param data 数据
     *  @param len  长度
     */
    void SetData(const char* pData,int nLen);
    
protected:
    char*   m_pBuffer;
    int     m_nLen;
private:
    CDataBuffer(const CDataBuffer&);
    CDataBuffer& operator= (const CDataBuffer&);
};

/**
 *  用户信息数据管理类
 *  数据自动申请与释放
 */
class CUserInfo
{
public:
    CDataBuffer     m_Id;               //用户id
    int             m_categoryId;       //类别id
    CDataBuffer     m_Name;             //用户名
    CDataBuffer     m_Portrait;         //用户url
    int             m_BlockPush;        //新消息通知阻止状态 0 - 未阻止 100 - 阻止
    CDataBuffer     m_AccountExtra;     //用户account
};

/**
 *  讨论组或群组信息数据管理类
 *  数据自动申请与释放
 */
class CDiscussionInfo
{
public:
    CDataBuffer     m_Id;               //讨论组或群组id
    CDataBuffer     m_Name;             //讨论组名称
    CDataBuffer     m_AdminId;          //管理员id
    CDataBuffer     m_UserIds;          //群组成员id,使用\n分割
    int             m_ConversationType; //通道类型 1-PRIVATE 2-DISCUSSION 3-GROUP 4-CHATROOM 5-CUSTOMSERVICE
    int             m_InviteStatus;     //开放邀请状态   0 - 开放邀请 1 - 关闭开放邀请
    int             m_BlockPush;        //新消息通知阻止状态 0 - 未阻止 100 - 阻止
};

typedef CDiscussionInfo CGroupInfo;


/**
 *  单条信息数据管理类
 *  数据自动申请与释放
 */
class CMessageInfo
{
public:
    CDataBuffer     m_TargetId;         //交互方id
    CDataBuffer     m_SenderId;         //发方id
    CDataBuffer     m_ClazzName;        //类别
    CDataBuffer     m_Message;          //信息
    CDataBuffer     m_ExtraMessage;     //附加信息
    CDataBuffer     m_Push;
    
    int             m_ConversationType; //通道类型  1-PRIVATE 2-DISCUSSION 3-GROUP 4-CHATROOM 5-CUSTOMSERVICE
    long            m_MessageId;        //消息id   消息在数据库中的id号
    bool            m_Direction;        //消息方向  0-发送的消息 1-接收的消息
    int             m_ReadStatus;       //读取状态  0-未读 1-已读
    int             m_SendStatus;       //发送状态  10-发送中 20-发送失败 30-发送成功
    int64_t         m_SndTime;          //发送时间
    int64_t         m_RcvTime;          //接收时间
    int             m_MessageType;      //信息类别  0-实时接收信息 1-历史漫游
};


class CConversationInfo
{
public:
    CDataBuffer     m_TargetId;
    CDataBuffer     m_Title;
    CDataBuffer     m_Draft;
    int             m_ConversationType;
    int             m_IsTop;
    int             m_BlockPush;
    int             m_GroupStatus; // 0 406 407
    int             m_UnreadCount;
    int64_t         m_LastTime;
 };

class CConversation
{
public:
    CConversationInfo   m_Conversation;
    CMessageInfo        m_Message;
    CUserInfo           m_User;
};

class CAccountInfo
{
public:
    CDataBuffer     m_AccountId;
    CDataBuffer     m_AccountName;
    int             m_AccountType;
    int64_t         m_LastTime;
    CDataBuffer     m_AccountUri;
    CDataBuffer     m_Extra;
};

//class CConversationListener
//{
//public:
//    virtual ~CConversationListener(){}
//    virtual void OnReceive(CConversation* c,int nLeft) = 0;
//};

/**
 *  图片发送接收监听器
 */
class ImageListener
{
public:
    virtual ~ImageListener(){}
    /**
     *  进度
     *
     *  @param nProgress 进度值
     */
    virtual void OnProgress(int nProgress) = 0;
    /**
     *  操作结果回调
     *
     *  @param nErrorCode     错误码 0 - 成功 非0 - 失败
     *  @param pszDescription 信息描述 成功，返回图片uri 失败 返回错误描述
     */
    virtual void OnError(int nErrorCode, const char* pszDescription) = 0;
};

class TokenListener
{
public:
    virtual ~TokenListener(){}
    
    /**
     *  操作结果回调
     *
     *  @param nErrorCode     错误码 0 - 成功 非0 - 失败
     *  @param pszDescription 信息描述 成功，上传返回上传token，下载返回图片uri 失败 返回错误描述
     */
    virtual void OnError(int nErrorCode, const char* pszDescription) = 0;
};

/**
 *  异常监听器
 */
class ExceptionListener
{
public:
    virtual ~ExceptionListener(){}
    /**
     *  操作结果回调
     *
     *  @param nStatus        错误码 0 - 成功 非0 - 失败
     *  @param pszDescription 信息描述
     */
    virtual void OnError(int nStatus, const char* pszDescription) = 0;
};

/**
 *  讨论组信息监听器
 */
class DiscussionInfoListener
{
public:
    virtual ~DiscussionInfoListener(){}
    /**
     *  信息接收回调函数
     *
     *  @param di    讨论组信息
     *  @param count 数量
     */
    virtual void OnReceive(CDiscussionInfo *di,int count) = 0;
    /**
     *  操作结果回调
     *
     *  @param status 错误码 0 - 成功 非0 - 失败
     */
    virtual void OnError(int status)=0;
};

/**
 *  消息监听器
 */
class MessageListener
{
public:
    virtual ~MessageListener(){}
    /**
     *  信息接收回调函数
     *
     *  @param mi    消息记录
     *  @param nLeft 剩余消息数
     */
    virtual void OnReceive(CMessageInfo* mi,int nLeft) = 0;
};


/**
 *  创建讨论组监听器
 */
class CreateDiscussionListener
{
public:
    virtual ~CreateDiscussionListener(){}
    /**
     *  创建成功回调函数
     *
     *  @param discussionId 讨论组id
     */
    virtual void OnSuccess(const char* discussionId)=0;
    /**
     *  创建失败回调函数
     *
     *  @param status 错误码
     */
    virtual void OnError(int status)=0;
};

/**
 *  用户信息监听器
 */
class UserInfoListener
{
public:
    virtual ~UserInfoListener(){}
    /**
     *  用户信息回调函数
     *
     *  @param userId       用户id
     *  @param userName     用户名称
     *  @param userPortrait 用户头像
     */
    virtual void OnResponse(const char* userId,const char* userName,const char* userPortrait)=0;
    /**
     *  错误信息回调函数
     *
     *  @param status 错误码
     */
    virtual void OnError(int status)=0;
};

/**
 *  关闭PUSH信息监听器
 */
class PushSettingListener
{
public:
    virtual ~PushSettingListener(){}
    /**
     *  用户信息回调函数
     *
     *  @param userId       用户id
     *  @param userName     用户名称
     *  @param userPortrait 用户头像
     */
    virtual void OnSuccess(const char* startTime,int spanMins)=0;
    /**
     *  错误信息回调函数
     *
     *  @param status 错误码
     */
    virtual void OnError(int status)=0;
};

class AccountListener
{
public:
    virtual ~AccountListener(){}
    /**
     *  信息接收回调函数
     *
     *  @param mi    消息记录
     *  @param nLeft 剩余消息数
     */
    virtual void OnReceive(CAccountInfo* ai,int nSize) = 0;
    
    /**
     *  操作结果回调
     *
     *  @param status 错误码 0 - 成功 非0 - 失败
     */
    virtual void OnError(int status)=0;
};


/**
 *  连接监听器
 */
class ConnectAckListener
{
public:
    virtual ~ConnectAckListener(){}
    /**
     *  操作结果回调函数
     *
     *  @param status 错误码   0-成功 非0-失败
     *  @param userId 描述信息 成功，返回用户id，失败，返回错误描述
     */
    virtual void operationComplete(int status,const char* userId) = 0;
};

/**
 *  通用监听器
 */
class PublishAckListener
{
public:
    virtual ~PublishAckListener(){}
    /**
     *  操作结果回调
     *
     *  @param status 操作结果 0-成功 非0-失败
     */
    virtual void operationComplete(int status) = 0;
};

/**
 *  业务监听器
 */
class BizAckListener
{
public:
    virtual ~BizAckListener(){}
    /**
     *  操作结果回调
     *
     *  @param opStatus  操作结果    0-成功 非0-失败
     *  @param bizStatus 业务数据值  根据具体业务返回响应的业务数据值
     */
    virtual void operationComplete(int opStatus,int bizStatus)=0;
    
};

//=====

class EnvironmentChangeNotifyListener
{
public:
    virtual ~EnvironmentChangeNotifyListener(){}
    /**
     *  环境改变，底层处理后的回调
     *
     *  @param nType 类型
     *  @param pData 附带数据
     */
    virtual void Complete(int nType, char* pData) = 0;
};

class WakeupQueryListener
{
public:
    virtual ~WakeupQueryListener(){}
    /**
     *  请求唤醒
     *
     *  @param nType 请求类型
     */
    virtual void QueryWakeup(int nType) = 0;
    /**
     *  释放唤醒锁
     */
    virtual void ReleaseWakup() = 0;
};

//黑名单用户列表 多个id以回车分割
class BlacklistInfoListener
{
public:
    virtual ~BlacklistInfoListener(){}
    virtual void OnSuccess(const char* blockUserIds)=0;
	virtual void OnError(int status)=0;
};


//使用\n 或者 逗号分割的字串统一修改
//用户讨论组群组id条目
class TargetEntry
{
public:
    char targetId[64];
    char targetName[256];
    
    bool operator< (const TargetEntry &c)const;
};

//用户讨论组群组id条目
struct ConversationEntry
{
    int typeId;
};


#endif
