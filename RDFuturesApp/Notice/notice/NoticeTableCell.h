//
//  NoticeTableCell.h
//  RDFuturesApp
//
//  Created by user on 17/4/11.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "NoticeModel.h"

@interface NoticeTableCell : BaseTableViewCell
@property(nonatomic,strong) NoticeModel *model;
@end
