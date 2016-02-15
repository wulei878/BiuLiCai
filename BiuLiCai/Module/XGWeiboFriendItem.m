//
//  XGWeiboFriendItem.m
//  XGCG
//
//  Created by Owen on 15/5/23.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGWeiboFriendItem.h"

@implementation XGWeiboFriendItem
-(instancetype)initWithFriendID:(NSString *)friendID dictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.friendID = @([friendID longLongValue]);
        self.friendHeaderURL = [NSURL URLWithString:dictionary[@"profile_image_url"]];
        self.friendLinkName = dictionary[@"link_name"];
        self.friendName = dictionary[@"name"];
        self.friendPinyin = dictionary[@"pinyin"];
    }
    return self;
}
@end
