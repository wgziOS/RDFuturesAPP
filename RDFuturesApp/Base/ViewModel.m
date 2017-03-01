//
//  ViewModel.m
//  ReactiveCocoaDemo
//
//  Created by lanren on 16/5/16.
//  Copyright © 2016年 雷建民. All rights reserved.
//

#import "ViewModel.h"

@implementation ViewModel



+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    ViewModel *viewModel = [super allocWithZone:zone];
    
    if (viewModel) {
        
        [viewModel jm_initialize];
    }
    return viewModel;
}

- (instancetype)initWithModel:(id)model {
    
    self = [super init];
    if (self) {
    }
    return self;
}


- (void)jm_initialize {}

@end
