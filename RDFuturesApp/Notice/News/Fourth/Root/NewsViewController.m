//
//  NewsViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/17.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsFirstViewController.h"
#import "NewsSecondViewController.h"
#import "NewsThirdViewController.h"
#import "NewsFourthViewController.h"
#import "NewsFifthViewController.h"
#import "NewsSixthViewController.h"
#import "NewsSeventhViewController.h"
#import "NewsEighthViewController.h"
#import "NewsTitleLabel.h"

#import "NewsViewModel.h"
#import "NewsTitleScrollView.h"
#import "NewsContentScrollView.h"
#import "NewsMain.h"
#import "DetailsViewController.h"
#import "MessageViewController.h"
@interface NewsViewController ()<UIScrollViewDelegate>




@property (nonatomic, strong)NewsViewModel * viewModel;
@property (nonatomic, strong)NewsTitleScrollView * titleScrollView;
@property (nonatomic, strong)NewsContentScrollView * contentScrollView;
@property (nonatomic, strong)NewsMain * mainView;
@property (nonatomic,strong)UIButton * messageButton;
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.view addSubview:self.mainView];
    
    
    
}
- (UIBarButtonItem *)rightButton
{
    return [[UIBarButtonItem alloc] initWithCustomView:self.messageButton];
}
-(UIButton *)messageButton{
    if (!_messageButton) {
        _messageButton  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [_messageButton setImage:[UIImage imageNamed:@"icon_navigationbar_message"] forState:UIControlStateNormal];//设置左边按钮的图片
        [_messageButton setImage:[UIImage imageNamed:@"icon_navigationbar_message_select"] forState:UIControlStateSelected];//设置左边按钮的图片
        [_messageButton addTarget:self action:@selector(actionOnTouchBackButton:) forControlEvents:UIControlEventTouchUpInside];//设置按钮的点击事件
    }
    return _messageButton;
}
-(void)actionOnTouchBackButton:(id)sender{
    if(![[RDUserInformation getInformation] getLoginState]){
        [self puchLogin];
        return ;
    }
    MessageViewController *message = [[MessageViewController alloc] init];
    [self.navigationController pushViewController:message animated:YES];
}
-(NewsMain *)mainView{

    if (!_mainView) {
        _mainView = [[NewsMain alloc]initWithViewModel:self.viewModel];
        
    }
    return _mainView;
}
-(void)updateViewConstraints{
    WS(weakself)
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];
}
-(UIBarButtonItem *)leftButton{
    return nil;
}
-(void)setupViews{
    
}
-(void)bindViewModel{
    
    [[self.viewModel.firstCellClick takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        //push详情页
        DetailsViewController * DVC = [[DetailsViewController alloc]init];

        DVC.urlStr = [NSString stringWithFormat:@"%@",x];
        DVC.titleString = @"详情";
        [self.navigationController pushViewController:DVC animated:YES];

    }];
    
    
}
-(NewsTitleScrollView *)titleScrollView{

    if (!_titleScrollView) {
        _titleScrollView = [[NewsTitleScrollView alloc]initWithViewModel:self.viewModel];
        
    }
    
    return _titleScrollView;
}


-(NewsContentScrollView *)contentScrollView{

    if (!!_contentScrollView) {
        _contentScrollView = [[NewsContentScrollView  alloc]initWithViewModel:self.viewModel];
        
    }
    return _contentScrollView;
}

-(NewsViewModel *)viewModel{

    if (!_viewModel) {
        _viewModel = [[NewsViewModel alloc]init];
    }
    return _viewModel;
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
