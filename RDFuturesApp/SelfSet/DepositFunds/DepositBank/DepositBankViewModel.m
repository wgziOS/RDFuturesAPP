


//
//  DepositBankViewModel.m
//  RDFuturesApp
//
//  Created by user on 17/5/9.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "DepositBankViewModel.h"

@implementation DepositBankViewModel

-(RACSubject *)nextStepClickSubject{
    if (!_nextStepClickSubject) {
        _nextStepClickSubject = [RACSubject subject];
        
    }
    return _nextStepClickSubject;
}
@end
