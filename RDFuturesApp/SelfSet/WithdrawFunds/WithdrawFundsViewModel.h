//
//  WithdrawFundsViewModel.h
//  RDFuturesApp
//
//  Created by user on 17/5/9.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BaseViewModel.h"

@interface WithdrawFundsViewModel : BaseViewModel
@property(nonatomic,strong)RACSubject *nextStepClickSubject;

@end
