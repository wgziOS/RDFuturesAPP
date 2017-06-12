

//
//  MoneyAmountViewModel.m
//  RDFuturesApp
//
//  Created by user on 17/5/8.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "MoneyAmountViewModel.h"

@implementation MoneyAmountViewModel
-(RACSubject *)nextStepClickSubject{
    if (!_nextStepClickSubject) {
        
        _nextStepClickSubject = [RACSubject subject];
    }
    return _nextStepClickSubject;
}
@end
