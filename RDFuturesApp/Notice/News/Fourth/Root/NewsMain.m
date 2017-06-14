//
//  NewsMain.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/18.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NewsMain.h"
#import "NewsViewModel.h"
#import "NewsTitleScrollView.h"
#import "NewsContentScrollView.h"

@interface NewsMain()<UIScrollViewDelegate>

@property (nonatomic ,strong)NewsViewModel * viewModel;

@property (nonatomic ,strong)NewsTitleScrollView * titleScrollView;
@property (nonatomic ,strong)NewsContentScrollView * contentScrollView;

@end
@implementation NewsMain

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{

    self.viewModel = (NewsViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews{
 
    [self addSubview:self.titleScrollView];
    [self addSubview:self.contentScrollView];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)updateConstraints{
    WS(weakself)
    
    [self.titleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(weakSelf);
        make.centerX.equalTo(weakSelf);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 35));
    }];
    
    //
    [self.contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf).mas_offset(35);
        make.centerX.equalTo(weakSelf);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-35-64-45));
    }];
    
    [super updateConstraints];
}

-(NewsContentScrollView *)contentScrollView{
    
    if (!_contentScrollView) {
        _contentScrollView = [[NewsContentScrollView alloc]initWithViewModel:self.viewModel];
        _contentScrollView.contentSize = CGSizeMake(8*[UIScreen mainScreen].bounds.size.width, 0);
        _contentScrollView.pagingEnabled = YES;
    }
    return _contentScrollView;
}

-(NewsTitleScrollView *)titleScrollView{

    if (!_titleScrollView) {
        _titleScrollView = [[NewsTitleScrollView alloc]initWithViewModel:self.viewModel];
        _titleScrollView.contentSize = CGSizeMake(70*8, 0);
        [_titleScrollView setBackgroundColor:[UIColor whiteColor]];
        _titleScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _titleScrollView;
}
@end
