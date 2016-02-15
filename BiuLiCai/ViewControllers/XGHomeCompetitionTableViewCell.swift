//
//  XGHomeCompetitionTableViewCell.swift
//  XGCG
//
//  Created by Sean on 15/4/11.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

import UIKit

protocol XGHomeCompetitionTableViewCellDelegate:NSObjectProtocol {
    func didTapPKButton(cell:XGHomeCompetitionTableViewCell)
}
class XGHomeCompetitionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var headIconImageView: UIImageView?
    @IBOutlet weak var todayROIRatioLabel: UILabel!
    @IBOutlet weak var stockNameLabel: UILabel?
    
    @IBOutlet weak var ratioPercentLabel: UILabel!
    @IBOutlet weak var ratioDescLabel: UILabel!
    var champion: XGChampionItem?
    var delegate:XGHomeCompetitionTableViewCellDelegate?
    @IBAction func didTapPKButton(sender: AnyObject) {
        self.delegate?.didTapPKButton(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        headIconImageView?.image = UIImage(named:"avatar_\(rand() % 3)")
    }

    func loadChampionItem(championItem: XGChampionItem) {
//        champion = championItem
//        nameLabel?.text = championItem.name
//        if (championItem.headIconUrl != nil) {
//            headIconImageView?.sd_setImageWithURL(NSURL(string: championItem.headIconUrl!))
//        }
//        stockNameLabel?.text = championItem.stockName
//        todayROIRatioLabel?.text = String(format: "%.0f", championItem.todayROIRatio ?? 0.0)
//        ratioDescLabel.textColor = kXGStockRizeTextColor
//        todayROIRatioLabel.textColor = ratioDescLabel.textColor
//        ratioPercentLabel.textColor = ratioDescLabel.textColor
    }
}
