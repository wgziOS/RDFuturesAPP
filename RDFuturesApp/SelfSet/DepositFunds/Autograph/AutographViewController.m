//
//  AutographViewController.m
//  RDFuturesApp
//
//  Created by user on 17/5/10.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "AutographViewController.h"
#import "PPSSignatureView.h"


#define kAutographHeight (SCREEN_WIDTH-30)*1.15
#define kButtonWidth  (SCREEN_WIDTH-65)*0.5

@interface AutographViewController ()
@property(nonatomic,strong)UIView *titleView;
@property(nonatomic,strong)PPSSignatureView *autographView;
@property(nonatomic,strong)UIButton *eliminate;//清除按钮
@property(nonatomic,strong)UIButton *nextStep;//下一步
@property(nonatomic,strong)UIImageView *nextStepBg;//下一步
@property(nonatomic,strong)UIButton *dissButton;//关闭按钮
@end

@implementation AutographViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"签名"];
   
    [self.view setBackgroundColor:[UIColor whiteColor]];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.autographView];
    [self.view addSubview:self.eliminate];
    [self.view addSubview:self.nextStepBg];
    [self.view addSubview:self.nextStep];
    [self.view addSubview:self.dissButton];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotate

{
    
    return NO;
    
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations

{
    
    return UIInterfaceOrientationMaskLandscape;
    
}


-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationLandscapeRight;
}
-(void)bindViewModel{
    
}

-(void)eraseView{
    [self.autographView erase];
}
-(void)nextStepClick{
    if (self.AutographBlock) {
        self.AutographBlock(YES);
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}
-(void)dissmissViewController{
    [self dismissViewControllerAnimated:NO completion:nil];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
-(PPSSignatureView *)autographView{
    if (!_autographView) {
        _autographView = [[PPSSignatureView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        [_autographView commonInit];
        [_autographView setBackgroundColor:[UIColor clearColor]];
        
    }
    return _autographView;
}
-(UIButton *)eliminate{
    if (!_eliminate) {
        _eliminate = [UIButton buttonWithType:UIButtonTypeCustom];
        [_eliminate setTitle:@"重签" forState:UIControlStateNormal];
        [_eliminate setFrame:CGRectMake(15, getTop(self.autographView)+10, kButtonWidth, 40)];
        [_eliminate addTarget:self action:@selector(eraseView) forControlEvents:UIControlEventTouchUpInside];
        _eliminate.layer.borderColor = [RGB(40, 146, 255) CGColor];
        _eliminate.layer.borderWidth = 0.5f;
        _eliminate.layer.masksToBounds = YES;
        _eliminate.layer.cornerRadius =3;
        [_eliminate setTitleColor:RGB(40, 146, 255) forState:UIControlStateNormal];
    }
    return _eliminate;
}
-(UIButton *)nextStep{
    if (!_nextStep) {
        _nextStep = [UIButton buttonWithType:UIButtonTypeSystem];
        [_nextStep setTitle:@"完成" forState:UIControlStateNormal];
        [_nextStep setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextStep setFrame:CGRectMake(getLeft(self.eliminate)+35, getTop(self.autographView)+10, kButtonWidth, 40)];
        [_nextStep addTarget:self action:@selector(nextStepClick) forControlEvents:UIControlEventTouchUpInside];
        _nextStep.layer.masksToBounds = YES;
        _nextStep.layer.cornerRadius =3;
    }
    return _nextStep;
}
-(UIImageView *)nextStepBg{
    if (!_nextStepBg) {
        _nextStepBg = [[UIImageView alloc] initWithFrame:CGRectMake(getLeft(self.eliminate)+35, getTop(self.autographView)+10, kButtonWidth, 40)];
        [_nextStepBg setImage:[UIImage imageNamed:@"b_btn"]];
    }
    return _nextStepBg;
}
-(UIView *)titleView{
    if (!_titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.5-100, 10, 200, 30)];
        label.text = @"请在此空白区域签写您的姓名";
        label.font = [UIFont rdSystemFontOfSize:14];
        [_titleView addSubview:label];
        [_titleView setBackgroundColor:[UIColor whiteColor]];
    }
    return _titleView;
}
-(UIButton *)dissButton{
    if (!_dissButton) {
        _dissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dissButton setTitle:@"x" forState:UIControlStateNormal];
        [_dissButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_dissButton.titleLabel setFont:[UIFont rdSystemFontOfSize:20]];
        [_dissButton setFrame:CGRectMake(10, 0, 30, 40)];
        [_dissButton addTarget:self action:@selector(dissmissViewController) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dissButton;
}
@end
