//
//  XGSearchResultCell.swift
//  BiuLiCai
//
//  Created by Owen on 15/6/7.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

import UIKit

class XGSearchResultCell: UITableViewCell {
    @IBOutlet weak var stockName: UILabel!
    @IBOutlet weak var stockID: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configData(item:XGStockInfoItem) {
        stockName.text = item.stockName;
        stockID.text = item.stockID.stringValue;
    }

}
