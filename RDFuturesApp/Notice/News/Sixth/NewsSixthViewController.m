//
//  NewsSixthViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/17.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NewsSixthViewController.h"
#import "NewsSixthView.h"
#import "NewsSixthViewModel.h"
#import "DetailsViewController.h"

@interface NewsSixthViewController ()
@property (nonatomic,strong)NewsSixthView * firstView;
@property (nonatomic,strong)NewsSixthViewModel* newsViewModel;
@end

@implementation NewsSixthViewController

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
-(NewsSixthViewModel *)newsViewModel{
    
    if (!_newsViewModel) {
        _newsViewModel = [[NewsSixthViewModel alloc]init];
    }
    return _newsViewModel;
}
-(NewsSixthView *)firstView{
    
    if (!_firstView) {
        _firstView = [[NewsSixthView alloc]initWithViewModel:self.newsViewModel];
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
