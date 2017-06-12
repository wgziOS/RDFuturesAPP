//
//  OtherInforCell.h
//  RDFuturesApp
//
//  Created by user on 17/3/10.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <UIKit/UIKit.h>



static NSString * const kOtherInforFirstCell  = @"OtherInforFirstCell";
static NSString * const kOtherInforSecondCell = @"OtherInforSecondCell";
static NSString * const kOtherInforThirdCell  = @"OtherInforThirdCell";

@interface OtherInforFirstCell : UITableViewCell

@end





@interface OtherInforSecondCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UITextField *context;
@end



@interface OtherInforThirdCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *context;
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;

@end
