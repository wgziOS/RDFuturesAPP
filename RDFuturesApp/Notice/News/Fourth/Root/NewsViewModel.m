//
//  NewsViewModel.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/18.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NewsViewModel.h"

@implementation NewsViewModel


-(RACSubject *)firstCellClick{
    
    if (!_firstCellClick) {
        _firstCellClick = [RACSubject subject];
        
    }
    return _firstCellClick;
}

-(RACSubject *)didEndScrollSubject{

    if (!_didEndScrollSubject) {
        _didEndScrollSubject = [RACSubject subject];
        
    }
    return _didEndScrollSubject;
}

-(RACSubject *)titleClickSubject{
    
    if (!_titleClickSubject) {
        _titleClickSubject = [RACSubject subject];
        
    }
    return _titleClickSubject;
}


@end
