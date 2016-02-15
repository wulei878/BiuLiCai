//
//  XGProfileViewController.swift
//  XGCG
//
//  Created by Sean on 15/4/11.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

import UIKit

class XGProfileViewController: UITableViewController {
    
    @IBOutlet var separatorLineHeightConstraints: [NSLayoutConstraint] = []
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var headerImageView: UIImageView!
    class func getInstance() -> XGProfileViewController {
        return UIStoryboard(name: "XGProfileViewController", bundle: nil).instantiateInitialViewController() as! XGProfileViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for constraint in separatorLineHeightConstraints {
            constraint.constant = constraint.constant  / UIScreen.mainScreen().scale
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
        (self.navigationController?.parentViewController as! XGMainViewController).showTabBar()
        nameLabel.text = XGCurrentUserManager.sharedInstance().userItem.account.userName
        headerImageView.sd_setImageWithURL(NSURL(string: XGCurrentUserManager.sharedInstance().userItem.account.iconURL), placeholderImage: UIImage(named: "avatar_0"))
        headerImageView.clipsToRound()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        if indexPath.row == 1 {
            self.navigationController?.pushViewController(XGMyHomePageViewController.getInstance(), animated: true)
        }else if indexPath.row == 3 {
            var viewController = self.navigationController?.parentViewController as! XGMainViewController
            viewController.tabButtonDidTapped(viewController.stockButton)
        } else if indexPath.row == 4 {
            self.navigationController?.pushViewController(XGMyHoldingViewController.getInstance(), animated: true)
        } else if indexPath.row == 6 {
            self.navigationController?.pushViewController(XGAddFriendViewController.getInstance(), animated: true)
        }
    }
}
