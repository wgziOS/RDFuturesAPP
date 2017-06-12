//
//  BaseScrollView.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/18.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BaseScrollView.h"

@implementation BaseScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        [self bindViewModel];
    }
    return self;
}



- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel andFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        [self bindViewModel];
        
    }
    return self;
    
}

- (void)bindViewModel {
}

- (void)setupViews {
}


@end
