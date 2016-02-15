//
//  PTFileInfo.m
//  Student
//
//  Created by dash on 14/11/18.
//  Copyright (c) 2014年 renren. All rights reserved.
//

#import "XGFileInfo.h"

@implementation XGFileInfo

+ (NSString *)filePathWithString:(NSString *)plistName
{
    NSArray *paths= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    NSString *filePath = [plistPath stringByAppendingPathComponent:plistName];
    return filePath;
}

+ (NSString *)filePathAppendingUserIDWithString:(NSString *)plistName
{
//    NSArray *paths= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//    NSString *plistPath = [paths objectAtIndex:0];
//    NSString *filePath = [plistPath stringByAppendingPathComponent:@([PTCurrentUserManager sharedInstance].currentUserId).stringValue];
//    filePath = [filePath stringByAppendingPathComponent:plistName];
    return nil;
}

@end