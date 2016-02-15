//
//  XGHomeAddFriendCell.swift
//  BiuLiCai
//
//  Created by Owen on 15/5/30.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

import UIKit
protocol XGHomeAddFriendCellDelegate:NSObjectProtocol {
    func didTapAddFriendButton()
}

class XGHomeAddFriendCell: UITableViewCell {

    @IBOutlet weak var addFriendButton: UIButton!
    var delegate:XGHomeAddFriendCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        addFriendButton.clipsToBounds = true
        addFriendButton.layer.cornerRadius = addFriendButton.height / 2
        addFriendButton.backgroundColor = UIColor.hexColor(0xfc594b)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func didTapAddFriendButton(sender: UIButton) {
        delegate?.didTapAddFriendButton()
    }
}
