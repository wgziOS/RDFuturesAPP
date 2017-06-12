


//
//  MessageViewModel.m
//  RDFuturesApp
//
//  Created by user on 17/5/11.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "MessageViewModel.h"

@implementation MessageViewModel

-(RACSubject *)cellClickSubject{
    if (!_cellClickSubject) {
        
        _cellClickSubject = [RACSubject subject];
        
    }
    return _cellClickSubject;
}
@end
