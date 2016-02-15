//
//  XGConstaints.swift
//  XGCG
//
//  Created by Sean on 15/4/12.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

import UIKit

extension UIColor {
    class func hexColor(hexColor:Int) -> UIColor {
        return UIColor.hexColorWithAlpha(hexColor, alpha: 1.0)
    }
    
    class func hexColorWithAlpha(hexColor: Int, alpha: CGFloat) -> UIColor {
        let red: CGFloat = CGFloat((hexColor & 0xff0000) >> 16) / 255.0
        let green: CGFloat = CGFloat((hexColor & 0x00ff00) >> 8) / 255.0
        let blue: CGFloat = CGFloat(hexColor & 0x0000ff) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension UIImage {
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect: CGRect = CGRectMake(0.0, 0.0, 1.0, 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContextRef = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

extension UIImageView {
    func clipsToRound() {
        self.clipsWithCornerRadius(self.frame.size.height / 2)
    }
    
    func clipsWithCornerRadius(cornerRadius:CGFloat) {
        self.clipsToBounds = true
        self.backgroundColor = UIColor.clearColor()
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.whiteColor().CGColor
    }
}

extension UIButton {
    class func roundCornerButtons(backgroundColor:UIColor,buttons:[UIButton]) {
        for button:UIButton in buttons {
            button.roundCornerButton(backgroundColor)
        }
    }
    
    func roundCornerButton(backgroundColor:UIColor) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height / 2
        self.setBackgroundImage(UIImage.imageWithColor(backgroundColor), forState: UIControlState.Normal)
    }
    
    class func changeButtonsVertical(spacing:CGFloat,buttons:[UIButton]) {
        for button:UIButton in buttons {
            button.changeButtonVertical(spacing)
        }
    }
    
    func changeButtonVertical(spacing:CGFloat) {
        self.titleEdgeInsets = UIEdgeInsetsMake(self.imageView!.frame.size.height + spacing, -self.imageView!.frame.width, 0.0, 0.0)
        self.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, self.titleLabel!.frame.size.height + spacing, -self.titleLabel!.frame.width)
    }
    
    class func centerButtonsWithSpacing(spacing:CGFloat,buttons:[UIButton]) {
        for button:UIButton in buttons {
            button.centerButtonWithSpacing(spacing)
        }
    }
    
    func centerButtonWithSpacing(spacing:CGFloat) {
        self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0.0, 0.0)
        self.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0, spacing)
    }
}



class XGCommonExtension: NSObject {
   
}
let kXGNavigationBarTintColor = UIColor.hexColor(0x2c2a31)
let kXGNavigationBarTextColor = UIColor.whiteColor()
let kXGStockRizeTextColor = UIColor.hexColor(0xff5845)
let kXGStockfallTextColor = UIColor.hexColor(0x1DBE5D)
let UmengAppkey = "555235f5e0f55a38220019ad"
let RONGCLOUD_IM_APPKEY = "p5tvi9dst0kx4"
let screen_width = UIScreen.mainScreen().bounds.width
let screen_height = UIScreen.mainScreen().bounds.height
//let YunpianApikey = "4805bf0345e28815a262f1a0d084075e"
//let kVerificationCodeMessage = "【Biu理财】您的验证码是#code#。如非本人操作，请忽略本短信。"
//let YunpianMessageURL = "http://yunpian.com/v1/sms/send.json"
