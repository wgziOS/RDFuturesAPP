//
//  NewsFifthViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/17.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NewsFifthViewController.h"
#import "NewsFifthView.h"
#import "NewsFifthViewModel.h"
#import "DetailsViewController.h"
@interface NewsFifthViewController ()
@property (nonatomic,strong)NewsFifthView * firstView;
@property (nonatomic,strong)NewsFifthViewModel* newsViewModel;
@end

@implementation NewsFifthViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.firstView];
}


-(void)bindViewModel{
    
    
    //    WS(weakself)
    
    [[self.newsViewModel.cellClick takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        
        //发个信号给rootVC去接收
        [self.rootViewModel.firstCellClick sendNext:x];
        
        
    }];
    
    
}

-(void)updateViewConstraints{
    WS(weakself)
    [self.firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}
-(NewsFifthViewModel *)newsViewModel{
    
    if (!_newsViewModel) {
        _newsViewModel = [[NewsFifthViewModel alloc]init];
    }
    return _newsViewModel;
}
-(NewsFifthView *)firstView{
    
    if (!_firstView) {
        _firstView = [[NewsFifthView alloc]initWithViewModel:self.newsViewModel];
    }
    return _firstView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
