//
//  XGCGGlobalVariables.m
//  XGCG
//
//  Created by Owen on 14-10-29.
//  Copyright (c) 2014年 renren. All rights reserved.
//

#import "XGGlobalVariables.h"
#import <Security/Security.h>

@implementation XGGlobalVariables
NSString *kCurrentUserDefaultPersistPath = @"kCurrentUserDefaultPersistPath";
NSString *kDistrictPersisPath = @"kDistrictPersisPath";
@end


NSString *kUUIDStringKey() {
    return [NSString stringWithFormat:@"%@.UUIDString", [[NSBundle mainBundle] bundleIdentifier]];
}

extern NSString *kUUIDString() {
    NSString *UUIDString;
    NSDictionary *keychainQuery = @{(__bridge id)kSecClass:(__bridge id)kSecClassGenericPassword,
                                    (__bridge id)kSecAttrAccount:kUUIDStringKey(),
                                    (__bridge id)kSecAttrAccessible:(__bridge id)kSecAttrAccessibleAlwaysThisDeviceOnly,
                                    (__bridge id)kSecReturnData:(id)kCFBooleanTrue,
                                    (__bridge id)kSecMatchLimit:(__bridge id)kSecMatchLimitOne};
    CFDataRef keyData = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData);
    if (status == noErr) {
        @try {
            UUIDString = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *exception) {
            NSLog(@"Unarchive of %@ failed: %@", kUUIDStringKey(), exception);
            SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    if (!UUIDString) {
        UUIDString = [UIDevice currentDevice].identifierForVendor.UUIDString;
        NSMutableDictionary *keychainQuery = [@{(__bridge id)kSecClass:(__bridge id)kSecClassGenericPassword,
                                                (__bridge id)kSecAttrAccount:kUUIDStringKey(),
                                                (__bridge id)kSecAttrAccessible:(__bridge id)kSecAttrAccessibleAlwaysThisDeviceOnly} mutableCopy];
        SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
        [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:UUIDString] forKey:(__bridge id)kSecValueData];
        SecItemAdd((__bridge CFDictionaryRef)keychainQuery, NULL);
    }
    return UUIDString;
}
