//
//  NewsSecondViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/17.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NewsSecondViewController.h"
#import "NewsSecondView.h"
#import "NewsSecondViewModel.h"
#import "DetailsViewController.h"

@interface NewsSecondViewController ()
@property (nonatomic,strong)NewsSecondView * firstView;
@property (nonatomic,strong)NewsSecondViewModel * newsViewModel;
@end

@implementation NewsSecondViewController
-(void)viewDidAppear:(BOOL)animated{

   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
     [self.view addSubview:self.firstView];
}


-(void)bindViewModel{
    
    
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
-(NewsSecondViewModel *)newsViewModel{
    
    if (!_newsViewModel) {
        _newsViewModel = [[NewsSecondViewModel alloc]init];
    }
    return _newsViewModel;
}
-(NewsSecondView *)firstView{
    
    if (!_firstView) {
        _firstView = [[NewsSecondView alloc]initWithViewModel:self.newsViewModel];
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
