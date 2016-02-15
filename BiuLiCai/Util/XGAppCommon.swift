//
//  XGAppCommon.swift
//  BiuLiCai
//
//  Created by Owen on 15/6/7.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

import UIKit

class XGAppCommon: NSObject {
    // App 沙盒 Documents 目录，带"/"
    class func documentPath() -> String{
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,
            NSSearchPathDomainMask.UserDomainMask,
            true)
        let path = paths[0] as! String + "/"
        return path
    }
    
    // App 沙盒 Caches 目录，带"/"
    class func cachesPath() -> String{
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let path = paths[0] as! String + "/"
        return path
    }
    
    class func AppBundleID() -> String{
        return NSBundle.mainBundle().bundleIdentifier!
    }
    
    class func CurrentUserDocumentPath()->String {
        var tempID = ((XGCurrentUserManager.sharedInstance().userItem.account.usid as NSString).longLongValue ?? 0 )
        var path:String = "\(self.documentPath())\(tempID)"
        if !NSFileManager.defaultManager().fileExistsAtPath(path) {
            var flag = NSFileManager.defaultManager().createDirectoryAtPath(path, withIntermediateDirectories: true, attributes: nil, error: nil)
            println("\(flag)")
        }
        return path
    }
}
