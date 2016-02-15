//
//  XGFeedViewController.swift
//  XGCG
//
//  Created by Sean on 15/4/10.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

import UIKit

class XGFeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,XGFeedTableViewCellDelegate {
    
    class func getInstance() -> XGFeedViewController {
        return UIStoryboard(name: "XGFeedViewController", bundle: nil).instantiateInitialViewController() as! XGFeedViewController
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        (self.navigationController?.parentViewController as! XGMainViewController).showTabBar()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("XGFeedTableViewCell", forIndexPath: indexPath) as! XGFeedTableViewCell
        cell.delegate = self
        return cell
    }
    
    @IBAction func didTapCommentButton(sender: AnyObject) {
        var nav = UINavigationController(rootViewController: XGCommentViewController.getInstance())
        self.presentViewController(nav, animated: true, completion: nil)
    }
    func didTapCommentDetailButton(sender: XGFeedTableViewCell) {
        self.navigationController?.pushViewController(XGCommentDetailViewController.getInstance(), animated: true)
    }
}
