//
//  MessageViewController.m
//  RDFuturesApp
//
//  Created by user on 17/5/11.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageView.h"
#import "MessageViewModel.h"
#import "RDNoitceViewController.h"


@interface MessageViewController ()
@property(nonatomic,strong)MessageView *messageView;
@property(nonatomic,strong)MessageViewModel *messageViewModel;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"消息"];
    [self.view addSubview:self.messageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateViewConstraints{
    WS(weakself)
    
    [self.messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];
    
}

-(void)bindViewModel{
    [[self.messageViewModel.cellClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        RDNoitceViewController *rdNotice = [[RDNoitceViewController alloc] init];
        
        [self.navigationController pushViewController:rdNotice animated:YES];
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(MessageView *)messageView{
    if (!_messageView) {
        _messageView = [[MessageView alloc] initWithViewModel:self.messageViewModel];
    }
    return _messageView;
}
-(MessageViewModel *)messageViewModel{
    if (!_messageViewModel) {
        _messageViewModel = [[MessageViewModel alloc] init];
    }
    return _messageViewModel;
}
@end
