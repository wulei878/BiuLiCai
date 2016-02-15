//
//  XGMyHomePageViewController.h
//  XGCG
//
//  Created by Owen on 15/4/30.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XGMyHomePageViewController : UIViewController<PTFactoryProtocol>
@property (nonatomic,copy) NSString *userID;
@property (nonatomic,assign) BOOL isMyself;
+ (instancetype)getInstance;
@end
