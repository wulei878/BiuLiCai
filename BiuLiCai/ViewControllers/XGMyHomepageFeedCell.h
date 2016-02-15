//
//  XGMyHomepageFeedCell.h
//  BiuLiCai
//
//  Created by Owen on 15/5/25.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XGMyHomepageFeedCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *feedContent;
@property (weak, nonatomic) IBOutlet UILabel *feedTime;
@property (weak, nonatomic) IBOutlet UILabel *earnRate;

@end
