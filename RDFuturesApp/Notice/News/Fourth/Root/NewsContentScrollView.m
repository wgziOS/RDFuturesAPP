//
//  NewsContentScrollView.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/18.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NewsContentScrollView.h"
#import "NewsFirstViewController.h"
#import "NewsSecondViewController.h"
#import "NewsThirdViewController.h"
#import "NewsFourthViewController.h"
#import "NewsFifthViewController.h"
#import "NewsSixthViewController.h"
#import "NewsSeventhViewController.h"
#import "NewsEighthViewController.h"

@interface NewsContentScrollView()<UIScrollViewDelegate>

@property (nonatomic ,strong)NewsFirstViewController * fisrtVC;
@property (nonatomic ,strong)NewsSecondViewController * secondVC;
@property (nonatomic ,strong)NewsThirdViewController * thirdVC;
@property (nonatomic ,strong)NewsFourthViewController * fourthVC;
@property (nonatomic ,strong)NewsFifthViewController * fifthVC;
@property (nonatomic ,strong)NewsSixthViewController * sixthVC;
@property (nonatomic ,strong)NewsSeventhViewController * seventhVC;
@property (nonatomic ,strong)NewsEighthViewController * eighthVC;

@end


@implementation NewsContentScrollView


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

//    NSLog(@"%f",scrollView.contentOffset.x);
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    int index = scrollView.contentOffset.x / SCREEN_WIDTH;
    NSLog(@"%d",index);
    NSString * str = [NSString stringWithFormat:@"%d",index];
    [self.viewModel.titleClickSubject sendNext:str
     ];
}

-(void)setupViews{
    
    self.delegate =self;
    
    [self addSubview:self.fisrtVC.view];
    [self addSubview:self.secondVC.view];
    [self addSubview:self.thirdVC.view];
    [self addSubview:self.fourthVC.view];
    [self addSubview:self.fifthVC.view];
    [self addSubview:self.sixthVC.view];
    [self addSubview:self.seventhVC.view];
    [self addSubview:self.eighthVC.view];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)bindViewModel{
    
    [[self.viewModel.titleClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
       
        NSLog(@"cgll%@",x);

        CGPoint position = CGPointMake(([x intValue])*SCREEN_WIDTH, 0);
        
        [self setContentOffset:position animated:YES];
    }];
    
}
-(void)updateConstraints{

    WS(weakself)
    NSLog(@"%f", self.frame.size.height);
    [self.fisrtVC.view mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-35-64-49));
//
       
    }];
    
    [self.secondVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf.fisrtVC.view.mas_right);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-35-64-49));
    }];
    
    [self.thirdVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf.secondVC.view.mas_right);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-35-64-49));
    }];
    
    [self.fourthVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf.thirdVC.view.mas_right);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-35-64-49));
    }];
    
    [self.fifthVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf.fourthVC.view.mas_right);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-35-64-49));
    }];
    
    [self.sixthVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf.fifthVC.view.mas_right);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-35-64-49));
    }];
    
    [self.seventhVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf.sixthVC.view.mas_right);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-35-64-49));
    }];
    
    [self.eighthVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf.seventhVC.view.mas_right);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-35-64-49));
    }];
    
    [super updateConstraints];
}

-(NewsFirstViewController *)fisrtVC{
    if (!_fisrtVC) {
        _fisrtVC = [[NewsFirstViewController alloc]init];
        _fisrtVC.rootViewModel = self.viewModel;
        
        
    }
    return _fisrtVC;
}
-(NewsSecondViewController *)secondVC{
    if (!_secondVC) {
        _secondVC = [[NewsSecondViewController alloc]init];
        _secondVC.rootViewModel = self.viewModel;
    }
    return _secondVC;
}

-(NewsThirdViewController *)thirdVC{

    if (!_thirdVC) {
        _thirdVC = [[NewsThirdViewController alloc]init];
        _thirdVC.rootViewModel = self.viewModel;
    }
    return _thirdVC;
}

-(NewsFourthViewController *)fourthVC{
    
    if (!_fourthVC) {
        _fourthVC = [[NewsFourthViewController alloc]init];
        _fourthVC.rootViewModel = self.viewModel;
    }
    return _fourthVC;
}

-(NewsFifthViewController *)fifthVC{
    
    if (!_fifthVC) {
        _fifthVC = [[NewsFifthViewController alloc]init];
        _fifthVC.rootViewModel = self.viewModel;
        
    }
    return _fifthVC;
}

-(NewsSixthViewController *)sixthVC{

    if (!_sixthVC) {
        _sixthVC = [[NewsSixthViewController alloc]init];
        _sixthVC.rootViewModel = self.viewModel;
    }
    return _sixthVC;
}

-(NewsSeventhViewController *)seventhVC{

    if (!_seventhVC) {
        _seventhVC = [[NewsSeventhViewController alloc]init];
        _seventhVC.rootViewModel = self.viewModel;
    }
    return _seventhVC;
}

-(NewsEighthViewController *)eighthVC{

    if (!_eighthVC) {
        _eighthVC = [[NewsEighthViewController alloc]init];
        _eighthVC.rootViewModel = self.viewModel;
        
    }
    return _eighthVC;
}

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{


    self.viewModel = (NewsViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

@end
