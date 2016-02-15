//
//  XGSearchTextField.swift
//  BiuLiCai
//
//  Created by Owen on 15/5/25.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

import Foundation

class XGSearchTextField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.layer.masksToBounds = true
//        self.layer.borderColor = UIColor.hexColor(0x363344).CGColor
//        self.layer.borderWidth  = 1
//        self.layer.cornerRadius = 8
        var attributeString = NSAttributedString(string: "输入股票代码/全拼/首字母", attributes: [NSForegroundColorAttributeName:UIColor.hexColor(0x747083),NSFontAttributeName:UIFont(name: "STHeitiSC-Light", size: 12.0)!])
        self.attributedPlaceholder = attributeString
        var imageView = UIImageView(image: UIImage(named: "search_button"))
        imageView.frame.size = CGSizeMake(15, 15)
        self.leftView = imageView
        self.leftViewMode = UITextFieldViewMode.Always
        self.background = UIImage(named: "searchBorder")
        self.textColor = UIColor.hexColor(0x747083)
        self.font = UIFont(name: "STHeitiSC-Light", size: 12.0)!
        var rightView = UIImageView(image: UIImage(named: "clear_button"))
        self.rightView = rightView
        self.rightViewMode = UITextFieldViewMode.WhileEditing
        rightView.userInteractionEnabled = true
    }
    
    override func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectMake(7 + 5 + 15, bounds.origin.y, bounds.size.width, bounds.size.height)
    }
    
    override func leftViewRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectMake(7, (bounds.height - 15) / 2, 15, 15)
    }
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectMake(7 + 5 + 15, bounds.origin.y, bounds.size.width, bounds.size.height)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectMake(7 + 5 + 15, bounds.origin.y, bounds.size.width, bounds.size.height)
    }
    
    override func rightViewRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectMake(bounds.width - 8 - 14, (bounds.height - 14) / 2, 14, 14)
    }

}