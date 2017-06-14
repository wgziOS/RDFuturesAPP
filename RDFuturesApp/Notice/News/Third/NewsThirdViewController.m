//
//  NewsThirdViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/17.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NewsThirdViewController.h"
#import "NewsThirdView.h"
#import "NewsThirdViewModel.h"
#import "DetailsViewController.h"
@interface NewsThirdViewController ()
@property (nonatomic,strong)NewsThirdView * firstView;
@property (nonatomic,strong)NewsThirdViewModel * newsViewModel;
@end

@implementation NewsThirdViewController

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
-(NewsThirdViewModel *)newsViewModel{
    
    if (!_newsViewModel) {
        _newsViewModel = [[NewsThirdViewModel alloc]init];
    }
    return _newsViewModel;
}
-(NewsThirdView *)firstView{
    
    if (!_firstView) {
        _firstView = [[NewsThirdView alloc]initWithViewModel:self.newsViewModel];
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
