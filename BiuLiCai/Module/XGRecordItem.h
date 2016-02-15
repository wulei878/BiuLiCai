//
//  XGRecordItem.h
//  XGCG
//
//  Created by Owen on 15/5/22.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGBaseItem.h"

typedef NS_ENUM(NSUInteger, EOperationType) {
    EOperationTypeRecharge,
    EOperationTypeWithdraw,
    EOperationTypeBuyIn,
    EOperationTypeSellOut
};

typedef NS_ENUM(NSUInteger, ERecordStatus) {
    ERecordStatusInProcess,
    ERecordStatusCompleted,
    ERecordStatusCanceled,
};
@interface XGRecordItem : XGBaseItem
@property(nonatomic,assign)ERecordStatus status;
@property(nonatomic,copy)NSString *stockName;
@property(nonatomic,copy)NSString *stockID;
@property(nonatomic,assign)float deal;
@property(nonatomic,assign)float price;
@property(nonatomic,assign)EOperationType operationType;
@property(nonatomic,copy)NSString *recordID;
@property(nonatomic,strong)NSNumber *volume;
@property(nonatomic,strong)NSDate *operationTime;
@end
