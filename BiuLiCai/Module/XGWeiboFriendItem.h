//
//  XGWeiboFriendItem.h
//  XGCG
//
//  Created by Owen on 15/5/23.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGBaseItem.h"

@interface XGWeiboFriendItem : XGBaseItem
@property(nonatomic,strong)NSNumber *friendID;
@property(nonatomic,copy)NSString *friendPinyin;
@property(nonatomic,strong)NSURL *friendHeaderURL;
@property(nonatomic,copy)NSString *friendName;
@property(nonatomic,copy)NSString *friendLinkName;
-(instancetype)initWithFriendID:(NSString *)friendID dictionary:(NSDictionary *)dictionary;
@end
