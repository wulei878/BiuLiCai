//
//  XGLoginViewController.h
//  XGCG
//
//  Created by Owen on 15/5/13.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XGLoginViewControllerDelegate;
@interface XGLoginViewController : UIViewController<PTFactoryProtocol>
@property(nonatomic,weak)id <XGLoginViewControllerDelegate>delegate;
@end

@protocol XGLoginViewControllerDelegate <NSObject>

- (void)XGLoginSucceed;

@end