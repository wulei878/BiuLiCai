//
//  XGHomeViewController.swift
//  XGCG
//
//  Created by Sean on 15/4/10.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

import UIKit

let kXGHomeTableHeaderViewHeight: CGFloat = 155.0

class XGHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,XGHomeCompetitionTableViewCellDelegate,XGHomeHeaderTabViewDelegate,XGHomeAddFriendCellDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var statusBarBackgroundView: UIView!
    @IBOutlet weak var headerBackgroundViewHeightConstraint: NSLayoutConstraint!
    let sectionHeaderView: XGHomeHeaderTabView! = XGHomeHeaderTabView.getInstance()
    
    @IBOutlet weak var tableHeaderView: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userHeadIconImageView: UIImageView!
    @IBOutlet weak var userTodayROIRatioLabel: UILabel!
    @IBOutlet weak var userTodayROIRatioSignLabel: UILabel!
    
    @IBOutlet weak var userHeadView: UIImageView!
    var championsArray = []
    var tableHeaderType:XGHomeHeaderType = XGHomeHeaderType.Compete
    var friendsArray:[XGWeiboFriendItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        let platformName = UMSocialSnsPlatformManager.getSnsPlatformString(UMSocialSnsTypeSina)
        if UMSocialAccountManager.isOauthAndTokenNotExpired(platformName) {
            let account = UMSocialAccountManager.socialAccountDictionary()[platformName] as! UMSocialAccountEntity
            var userItem = XGUserItem()
            userItem.account = account
            XGCurrentUserManager.sharedInstance().userItem = userItem
            XGHttpManager.sharedManager().checkAllStockVersionWithSuccessBlock(nil, failBlock: nil)
        } else {
            var nav = UINavigationController(rootViewController: XGLoginViewController.getInstance())
            self.presentViewController(nav, animated: false, completion: nil)
        }
        tableView.separatorColor = UIColor(red: 228.0 / 255.0, green: 229.0 / 255.0, blue: 230.0 / 255.0, alpha: 1.0)
        tableView.contentInset = UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0);
        tableHeaderView.backgroundColor = UIColor.hexColor(0x2C2A31)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if XGCurrentUserManager.sharedInstance().didLogin() {
            self.loadUserInfo()
        }
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        if self.navigationController!.respondsToSelector("interactivePopGestureRecognizer") {
            self.navigationController!.interactivePopGestureRecognizer.delegate = nil;
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        (self.navigationController?.parentViewController as! XGMainViewController).showTabBar()
    }
    
    func requestFriendsData() {
        MBProgressHUD.showLoadingHUDOnView(self.view, message: nil, animated: true)
        UMSocialDataService.defaultDataService().requestSnsFriends(UMShareToSina, completion: { (response) -> Void in
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            self.configFriendsData(response)
        })
    }
    
    func configFriendsData(response:UMSocialResponseEntity!) {
        friendsArray = []
        for (key,value) in response.data {
            var friendID = key as! String
            var dic = value as! [String:AnyObject]
            var item = XGWeiboFriendItem(friendID: friendID, dictionary: dic)
            friendsArray?.append(item)
        }
        self.tableView.reloadData()
    }
    
    func loadUserInfo() {
        userNameLabel.text = XGCurrentUserManager.sharedInstance().userItem.account.userName
        userHeadIconImageView.sd_setImageWithURL(NSURL(string: XGCurrentUserManager.sharedInstance().userItem.account.iconURL), placeholderImage: UIImage(named: "large_avatar_\(rand()%3)"))
        userHeadIconImageView.clipsToRound()
//        userTodayROIRatioLabel.text = String(format: "%.02f", abs(userInfo?.todayROIRatio ?? 0.0))
//        userTodayROIRatioSignLabel.text = userInfo?.todayROIRatio >= 0 ? "+" : "-"
    }
    
    // MARK: - scroll view delegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        headerBackgroundViewHeightConstraint.constant = max(-scrollView.contentOffset.y, 0)
        if scrollView.contentOffset.y >= kXGHomeTableHeaderViewHeight && UIApplication.sharedApplication().statusBarStyle == .LightContent {
            UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.Default, animated: false)
            statusBarBackgroundView?.hidden = false
        } else if scrollView.contentOffset.y < kXGHomeTableHeaderViewHeight && UIApplication.sharedApplication().statusBarStyle == .Default {
            UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
            statusBarBackgroundView?.hidden = true
        }
    }
    
    // MARK: - table view date source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableHeaderType == XGHomeHeaderType.Compete {
           return 10
        } else if let friends = friendsArray {
            return friends.count
        } else {
            return 2
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        if tableHeaderType == XGHomeHeaderType.Compete {
            var cell = tableView.dequeueReusableCellWithIdentifier("XGHomeCompetitionTableViewCell", forIndexPath: indexPath) as! XGHomeCompetitionTableViewCell
//            var champion: XGChampionItem = championsArray[indexPath.row] as! XGChampionItem
//            cell.loadChampionItem(champion)
            cell.delegate = self
            return cell
        } else {
            if friendsArray == nil {
                if indexPath.row == 0 {
                    var cell = tableView.dequeueReusableCellWithIdentifier("homeFriendCell", forIndexPath: indexPath) as! XGHomeFriendCell
                    cell.configMyData()
                    return cell
                } else if indexPath.row == 1 {
                    var cell = tableView.dequeueReusableCellWithIdentifier("addFriendCell", forIndexPath: indexPath) as! XGHomeAddFriendCell
                    return cell
                }

            } else {
                var cell = tableView.dequeueReusableCellWithIdentifier("homeFriendCell", forIndexPath: indexPath) as! XGHomeFriendCell
                cell.configData(friendsArray![indexPath.row],index:indexPath.row)
                return cell
            }
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableHeaderType == XGHomeHeaderType.Friends && friendsArray == nil && indexPath.row == 1 {
            return 256
        }
        return 75
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsMake(0.0, 15.0, 0.0, 15.0)
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        sectionHeaderView.delegate = self
        sectionHeaderView.addBottomLine()
        return sectionHeaderView
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        if tableHeaderType == XGHomeHeaderType.Compete {
            var viewController = XGStockDetailViewController.getInstance()
            self.navigationController?.pushViewController(viewController, animated: true)
        } else if tableHeaderType == XGHomeHeaderType.Friends {
            if friendsArray == nil {
                if indexPath.row == 0 {
                    self.navigationController?.pushViewController(XGMyHomePageViewController.getInstance(), animated: true)
                }
                return
            } else {
                var viewController = XGMyHomePageViewController.getInstance()
                viewController.userID = "1"
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func didTapPKButton(cell: XGHomeCompetitionTableViewCell) {
        self.navigationController?.pushViewController(XGStockIncomeViewController.getInstance(), animated: true)
    }

    @IBAction func didTapMyCollectionButton(sender: AnyObject) {
        self.navigationController?.pushViewController(XGMyCollectionStockViewController.getInstance(), animated: true)
    }
    @IBAction func didTapMyHoldingButton(sender: AnyObject) {
        let tap = sender as! UITapGestureRecognizer
        var touchPoint = tap.locationInView(tap.view)
        
        if CGRectContainsPoint(userHeadIconImageView.frame, touchPoint) {
            self.navigationController?.pushViewController(XGMyHomePageViewController.getInstance(), animated: true)
        } else {
            self.navigationController?.pushViewController(XGMyHoldingViewController.getInstance(), animated: true)
        }
    }
    
    @IBAction func didTapMessageButton(sender: AnyObject) {
        let chatService = XGServiceChatViewController.getInstance()
        chatService.targetId = "1111"
        chatService.targetName = "客服"
        chatService.title = "客服"
        chatService.conversationType = RCConversationType.ConversationType_CUSTOMERSERVICE
        self.navigationController?.pushViewController(chatService, animated: true)
    }
    
    func didTapCompeteButton() {
        tableHeaderType = XGHomeHeaderType.Compete
        tableView.reloadData()
    }
    
    func didTapFriendsButton() {
        tableHeaderType = XGHomeHeaderType.Friends
        if friendsArray == nil {
//            self.requestFriendsData()
        }
        tableView.reloadData()
    }
    
    func didTapAddFriendButton() {
        //TODO 邀请好友
    }
}
