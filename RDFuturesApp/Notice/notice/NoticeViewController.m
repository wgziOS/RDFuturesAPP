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


-(NoticeView *)noticeView{
    if (!_noticeView) {
        _noticeView = [[NoticeView alloc] initWithViewModel:self.noticeViewModel andFrame:self.view.bounds];
    }
    return _noticeView;
}
-(NoticeViewModel *)NoticeViewModel{
    
    if (!_noticeViewModel) {
        _noticeViewModel = [[NoticeViewModel alloc] init];
    }
    return _noticeViewModel;
}

@end
