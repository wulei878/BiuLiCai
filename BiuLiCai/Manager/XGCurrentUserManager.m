//
//  XGCurrentUserManager.m
//  XGCG
//
//  Created by Owen on 14-11-3.
//  Copyright (c) 2014年 renren. All rights reserved.
//

#import "XGCurrentUserManager.h"

@interface  XGCurrentUserManager ()

@end

@implementation XGCurrentUserManager
- (NSInteger)currentUserId
{
    if (self.userItem) {
       return [self.userItem.userID integerValue];
    }
    return 0;
}

- (BOOL)didLogin
{
    return self.userItem.account.usid != nil;
}

- (NSString *)currentUserDirectory
{
    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *userDir = [documentDir stringByAppendingPathComponent:self.userItem.userID];
    if (![[NSFileManager defaultManager] fileExistsAtPath:userDir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:userDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return userDir;
}
@end
