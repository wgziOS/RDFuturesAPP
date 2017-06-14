//
//  ChangeNumSecondViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/5.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "ChangeNumSecondViewController.h"
#import "ChangeSecondView.h"
#import "ChangeSecondViewModel.h"
@interface ChangeNumSecondViewController ()
@property(nonatomic,strong) ChangeSecondViewModel * viewModel;
@property(nonatomic,strong) ChangeSecondView * secondView;

@end

@implementation ChangeNumSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title  = @"更换手机号";
    
    [self.view addSubview:self.secondView];
    /*
     更换手机号(新手机验证)
     
     /api/user/newPhoneValidation.api*
    
    *请求参数*
    
    1、newPhone	       	   	新手机号码
    2、validate_code	        验证码
    
    *返回参数*
    
    1、isRight             验证码是否正确（1：正确 无：错误）
     */
}

-(void)bindViewModel{

}

-(void)updateViewConstraints{
    
    WS(weakself)
    
    [self.secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];
}

-(ChangeSecondView *)secondView{
    
    if (!_secondView) {
        _secondView = [[ChangeSecondView alloc]initWithViewModel:self.viewModel];
        _secondView.backgroundColor = [UIColor whiteColor];
    }
    return _secondView;
}

-(ChangeSecondViewModel *)viewModel{
    
    if (!_viewModel) {
        _viewModel = [[ChangeSecondViewModel alloc]init];
        
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
