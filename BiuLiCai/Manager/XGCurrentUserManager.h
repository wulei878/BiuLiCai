//
//  XGCurrentUserManager.h
//  XGCG
//
//  Created by Owen on 14-11-3.
//  Copyright (c) 2014年 renren. All rights reserved.
//

#import "XGSingletonObject.h"
#import "XGUserItem.h"

@interface XGCurrentUserManager : XGSingletonObject
@property (nonatomic,strong) XGUserItem *userItem;
@property (nonatomic,strong) NSMutableArray *weiboFriends;
- (NSInteger)currentUserId;
- (BOOL)didLogin;

///获取当前用户的存储路径
- (NSString *)currentUserDirectory;
@end
