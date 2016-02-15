//
//  XGMainViewController.swift
//  XGCG
//
//  Created by Sean on 15/4/10.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

import UIKit

class XGMainViewController: UIViewController {
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var feedButton: UIButton!
    @IBOutlet weak var stockButton: UIButton!
    @IBOutlet weak var compButton: UIButton!
    @IBOutlet weak var profButton: UIButton!
    
    @IBOutlet weak var bottomBarBottom: NSLayoutConstraint!
    @IBOutlet weak var tabbarSeparatorHeightConstraint: NSLayoutConstraint!
    
    var viewControllers: [UIViewController!] = []
    
    var rootNavController: UINavigationController? {
        return self.childViewControllers.first as? UINavigationController
    }
    
    var tabButtons: [UIButton!] {
        return [homeButton, compButton, profButton,stockButton]
    }
    
    @IBOutlet weak var tabBarHeightConstraint: NSLayoutConstraint!
    class func getInstance() -> XGMainViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! XGMainViewController
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [rootNavController!.viewControllers.first as! XGHomeViewController, XGSimulateStockViewController.getInstance(), XGCompeteListViewController.getInstance(), XGProfileViewController.getInstance()]
        UIButton.changeButtonsVertical(5, buttons: [homeButton,stockButton,compButton,profButton])
        tabbarSeparatorHeightConstraint.constant = tabbarSeparatorHeightConstraint.constant / UIScreen.mainScreen().scale
        self.hidesBottomBarWhenPushed = true
    }
    
    override func childViewControllerForStatusBarStyle() -> UIViewController? {
        return rootNavController?.viewControllers.first as? UIViewController
    }
    
    @IBAction func tabButtonDidTapped(sender: UIButton) {
        for btn: UIButton in tabButtons {
            btn.selected = false
            btn.userInteractionEnabled = true
        }
        sender.selected = true
        sender.userInteractionEnabled = false
        
        var toRootViewController: UIViewController! = viewControllers.first!
        self.rootNavController!.navigationBarHidden = false
        switch (sender) {
        case homeButton:
            toRootViewController = viewControllers[0]
            if rootNavController!.viewControllers.first as? UIViewController != viewControllers.first {
                self.rootNavController!.setViewControllers([viewControllers.first!], animated: false)
            }
        case stockButton:
            toRootViewController = viewControllers[1]
        case compButton:
            toRootViewController = viewControllers[2]
        case profButton:
            toRootViewController = viewControllers[3]
        default:
            println("not suppose to happen")
        }

        if rootNavController!.viewControllers.first as? UIViewController != toRootViewController {
            self.rootNavController!.setViewControllers([toRootViewController!], animated: false)
        }
    }
    
    @IBAction func stockButtonDidTapped(sender: UIButton) {
        var stockNav: UINavigationController = UINavigationController(rootViewController: XGSimulateStockViewController.getInstance())
        self.presentViewController(stockNav, animated: true, completion: nil)
    }
    
    func hideTabBar() {
        self.bottomBarBottom.constant = -50
        self.view.setNeedsUpdateConstraints()
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    func showTabBar() {
        self.bottomBarBottom.constant = 0
        self.view.setNeedsUpdateConstraints()
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
}
