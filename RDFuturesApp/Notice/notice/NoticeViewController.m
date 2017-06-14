//
//  NoticeViewController.m
//  RDFuturesApp
//
//  Created by user on 17/4/11.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NoticeViewController.h"
#import "NoticeView.h"
#import "NoticeViewModel.h"
#import "NoticeDetailsViewController.h"
#import "NoticeModel.h"
@interface NoticeViewController ()
@property(nonatomic,strong)NoticeView *noticeView;
@property(nonatomic,strong)NoticeViewModel *noticeViewModel;
@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.view addSubview:self.noticeView];
    
}
-(void)bindViewModel{
    WS(weakself)
    [[self.noticeViewModel.cellClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NoticeModel * model) {
        if(![[RDUserInformation getInformation] getLoginState]){
            [weakSelf puchLogin];
            return ;
        }
        NoticeDetailsViewController * noticeDetails = [[NoticeDetailsViewController alloc]init];
        noticeDetails.model = model;
        [self.navigationController pushViewController:noticeDetails animated:YES];
        
    }];
}
-(void)updateViewConstraints{
    
    [self.noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
        
    }];
    [super updateViewConstraints];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIBarButtonItem *)leftButton{
    return nil;
}
-(NoticeView *)noticeView{
    if (!_noticeView) {
        _noticeView = [[NoticeView alloc] initWithViewModel:self.noticeViewModel];
    }
    return _noticeView;
}
-(NoticeViewModel *)noticeViewModel{
    
    if (!_noticeViewModel) {
        _noticeViewModel = [[NoticeViewModel alloc] init];
    }
    return _noticeViewModel;
}

@end
