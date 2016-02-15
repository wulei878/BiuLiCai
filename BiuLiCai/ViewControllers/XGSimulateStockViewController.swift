//
//  XGSimulateStockViewController.swift
//  XGCG
//
//  Created by ran.shi on 15/4/17.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

import UIKit
class XGSimulateStockViewController: UIViewController,UITextFieldDelegate,UIScrollViewDelegate {
    
    @IBOutlet weak var headerContainerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textField: XGSearchTextField!
    @IBOutlet var actionButtons: [UIButton] = []
    @IBOutlet var separatorLineHeightConstraints: [NSLayoutConstraint] = []
    var topView:UIView!
    @IBOutlet weak var tipsView: UIView!
    var stockAccount:XGAccountItem?
    @IBOutlet weak var earnLabel: UILabel!
    @IBOutlet weak var stockValueLabel: UILabel!
    
    @IBOutlet weak var cashLabel: UILabel!
    @IBOutlet weak var earnRateLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    class func getInstance() -> XGSimulateStockViewController {
        return UIStoryboard(name: "XGSimulateStockViewController", bundle: nil).instantiateInitialViewController() as! XGSimulateStockViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIButton.changeButtonsVertical(0, buttons: actionButtons)
        self.view.backgroundColor = kXGNavigationBarTintColor
        self.headerContainerView.backgroundColor = self.view.backgroundColor
        self.topView = UIView(frame: CGRectMake(0, self.scrollView.contentOffset.y, self.view.width, 0))
        self.topView.backgroundColor = self.view.backgroundColor
        self.view.addSubview(self.topView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.requestData()
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
        (self.navigationController?.parentViewController as! XGMainViewController).showTabBar()
    }
    
    func requestData() {
        MBProgressHUD.showLoadingHUDOnView(self.view, message: nil, animated: true)
        XGHttpManager.sharedManager().getStockAccountWithSuccessBlock({ (data) -> Void in
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            self.loadData(data)
        }, failBlock: { (errorMessage) -> Void in
            MBProgressHUD.showTimedDetailsTextHUDOnView(self.view, message: errorMessage, animated: true)
        })
    }
    
    func loadData(data:AnyObject) {
        stockAccount = XGAccountItem.getInstanceWithDictionary((data as! Dictionary)["account_info"])
        if let stock = stockAccount {
            accountLabel.text = String(format: "%.2f", stock.stockAccount)
            earnLabel.text = String(format: "%.2f", stock.earnValue)
            earnRateLabel.text = stock.earnRate >= 0.0 ? String(format:"+%.2f%%",stock.earnRate) : String(format:"%.2f%%",stock.earnRate)
            earnRateLabel.textColor = stock.earnRate >= 0.0 ? kXGStockRizeTextColor : kXGStockfallTextColor
            stockValueLabel.text = String(format: "%.2f", stock.stockValue)
            cashLabel.text = String(format: "%.2f", stock.cash)
        }
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        self.navigationController?.pushViewController(XGSearchStockViewController.getInstance(), animated: false)
        return false
    }
    

    @IBAction func closeTipsAction(sender: AnyObject) {
        tipsView.hidden = true
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 {
            self.topView.height = -scrollView.contentOffset.y
        } else {
            self.topView.height = 0
        }
    }
}
