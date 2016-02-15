//
//  XGUserItem.h
//  XGCG
//
//  Created by Owen on 15/4/26.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGPersonItem.h"
#import "UMSocial.h"
#import "XGAccountItem.h"

@interface XGUserItem : XGPersonItem
@property(nonatomic,strong)UMSocialAccountEntity *account;
@property(nonatomic,strong)XGAccountItem *accountItem;
@property(nonatomic,assign)float monthUpdownRate;
@property(nonatomic,assign)NSInteger flower;
@property(nonatomic,assign)NSInteger followCount;
@property(nonatomic,assign)NSInteger fans;
@property(nonatomic,assign)NSInteger collectionCount;
@end
