//
//  AreaTableViewCell.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/23.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kAreaTableViewCell = @"AreaTableViewCell";
@interface AreaTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;

@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@end
