//
//  RMShareDefine.h
//  MiMi-iOS
//
//  Created by 史良 on 14-4-23.
//  Copyright (c) 2014年 Renren Inc. All rights reserved.
//

typedef NS_ENUM(NSInteger, ShareDestination) {
    ShareToNone = 0,
    shareToRenrenAnonyMous,
    ShareToRenren,
    ShareToRenrenFriend,
    ShareToFriendCircle,
    ShareToWeChat,
    ShareToWeibo,
    ShareToMessage,
    ShareToSecretMessage,
    ShareToQQFriend,
    ShareToQQZone,
    loginOnRenren,
    loginOnWeibo,
    loginOnWeiboBind
};

typedef NS_ENUM(NSInteger, ShareContentType) {
	ShareContentTypeImageAndText = 0, //图文混排
	ShareContentTypeText = 1,         //纯文本
	ShareContentTypeImage = 2,        //图片模式,
};

typedef void (^ ShareCompletion)(NSInteger errorNumber, NSDictionary *userInfo);

#ifdef InHouse
#define kDefaultRenrenAppID @"268334"
#define kDefaultRenrenApiKey @"36254542e1814259b84391b90a59f567"
#define kDefaultRenrenSecretKey @"Key：f87cdbb4a6e8434fa069c4fbf147a982"
#else
#define kDefaultRenrenAppID @"473791"
#define kDefaultRenrenApiKey @"a8831184737f44eabd8457046a8f018b"
#define kDefaultRenrenSecretKey @"7498edb0383148bd80ac04012f4f2c42"
#endif

#define kDefaultWeChatAppID @"wx1263de362e2d405e"
#define kDefaultWeChatAppSecretKey @"551eb97b231d07e920f4deccb64c4456"
#define kDefaultQQAppID @"101071380"
#define kDefaultQQApiKey @"ff6cb13e145a52d8e40b83ab6a45a935"

#define kDefaultWeiBoAppID @"538762849"
#define kDefaultWeiBoAppSecretKey @"6db9b6d63052fec44264f6d3d36c0b2a"
