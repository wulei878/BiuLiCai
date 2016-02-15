//
//  XGHomeHeaderTabView.swift
//  XGCG
//
//  Created by Sean on 15/4/12.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

import UIKit

enum XGHomeHeaderType {
    case Compete
    case Friends
}

protocol XGHomeHeaderTabViewDelegate:NSObjectProtocol {
    func didTapCompeteButton()
    func didTapFriendsButton()
}

class XGHomeHeaderTabView: UIView {

    @IBOutlet var buttons: [UIButton]!
    var delegate:XGHomeHeaderTabViewDelegate?
    var buttonBottomView:UIView!
    @IBOutlet weak var separatorHeightConstraint: NSLayoutConstraint! {
        didSet {
            separatorHeightConstraint.constant = separatorHeightConstraint.constant / UIScreen.mainScreen().scale
        }
    }
    
    class func getInstance() -> XGHomeHeaderTabView {
        return UINib(nibName: "XGHomeHeaderTabView", bundle: nil).instantiateWithOwner(nil, options: nil).first as! XGHomeHeaderTabView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.whiteColor()
    }
    
    func addBottomLine() {
        if buttonBottomView == nil {
            buttonBottomView = UIView(frame: CGRectMake(0, 0, 110, 1))
            buttonBottomView.backgroundColor = UIColor.hexColor(0x687377)
            buttonBottomView.bottom = self.height
            buttonBottomView.left = (screen_width/2 - buttonBottomView.width)/2
            self.addSubview(buttonBottomView)
        }
    }

    @IBAction func didTapButton(sender: UIButton) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.buttonBottomView.centerX = sender.centerX
        })
        for button in self.buttons {
            if button != sender {
                button.selected = false
            }
        }
        sender.selected = true
        if sender.tag == 1 {
            self.delegate?.didTapCompeteButton()
        } else {
            self.delegate?.didTapFriendsButton()
        }
    }
}
