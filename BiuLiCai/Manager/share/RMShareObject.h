//
//  RMShareObject.h
//  MiMi-iOS
//
//  Created by 史良 on 14-4-23.
//  Copyright (c) 2014年 Renren Inc. All rights reserved.
//

#import "RMShareDefine.h"

@interface RMShareObject : NSObject

@property (nonatomic, strong) UIImage *imageData;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *feedID;
@property (nonatomic, copy) NSString *detailContent;
@property (nonatomic, copy) NSString *linkURL;
@property (nonatomic, assign) ShareDestination shareDestination;
@property (nonatomic, assign) ShareContentType shareContentType;

@end