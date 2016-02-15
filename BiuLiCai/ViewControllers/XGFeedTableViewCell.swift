//
//  XGFeedTableViewCell.swift
//  XGCG
//
//  Created by ran.shi on 15/4/15.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

import UIKit

protocol XGFeedTableViewCellDelegate:NSObjectProtocol {
    func didTapCommentDetailButton(sender:XGFeedTableViewCell)
}

class XGFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var stockContainerView: UIView?
    @IBOutlet var separatorLineHeightConstraints: [NSLayoutConstraint] = []
    weak var delegate:XGFeedTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.stockContainerView?.layer.borderColor = UIColor(red: 228.0/255.0, green: 229.0/255.0, blue: 230.0/255.0, alpha: 1.0).CGColor
        self.stockContainerView?.layer.borderWidth = 1.0
        self.stockContainerView?.layer.cornerRadius = 2.0
        for constraint in separatorLineHeightConstraints {
            constraint.constant = constraint.constant  / UIScreen.mainScreen().scale
        }
    }
    
    @IBAction func didTapCommentButton(sender: AnyObject) {
        self.delegate?.didTapCommentDetailButton(self)
        
    }
    
}
