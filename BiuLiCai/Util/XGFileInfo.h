//
//  PTFileInfo.h
//  Student
//
//  Created by dash on 14/11/18.
//  Copyright (c) 2014年 renren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XGFileInfo : NSObject

+ (NSString *)filePathWithString:(NSString *)plistName;
+ (NSString *)filePathAppendingUserIDWithString:(NSString *)plistName;
@end

static NSString *kAllStockList = @"AllStockList";
