//
//  AccountBaseController.m
//  RDFuturesApp
//
//  Created by user on 17/4/6.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "AccountBaseController.h"
#import "OpenAccountFirstViewController.h"
#import "OtherInforViewController.h"
#import "IdPhotoViewController.h"
#import "BankCardInfoViewController.h"
#import "ContactInfoViewController.h"
#import "FinanceInfoViewController.h"
#import "ExperienceViewController.h"
#import "WitnessCityViewController.h"
#import "CommitInfoViewController.h"
#import "ProgressViewController.h"
#import "OpenAccountViewController.h"
#import "NavigationBaseController.h"
#import "LoginViewController.h"
#import "DerivativeViewController.h"


@interface AccountBaseController ()
@property(nonatomic,strong)NSMutableArray *itemArray;
@end

@implementation AccountBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNavigationBar];
    
    
    self.view.backgroundColor= DEFAULT_BG_COLOR;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

+(CGSize)textForFont:(int)font andMAXSize:(CGSize)size andText:(NSString*)text
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:2];
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:[UIFont systemFontOfSize:font]};
    CGRect rect = [text boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes
                                     context:nil];
    
    return rect.size;
}


- (void) setUpNavigationBar
{
   
    [self.navigationController.navigationBar setBarTintColor:RGB(255, 165, 33)];//设置导航栏的背景颜色
    
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    self.navigationItem.leftBarButtonItems = self.itemArray;//设置导航栏左边按钮
    self.navigationItem.rightBarButtonItem = [self rightButton];//设置导航栏右边按钮
    self.navigationItem.titleView = [self centerView];//设置titel
    if([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

-(NSMutableArray *)itemArray{
    if (!_itemArray) {
        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 40)];
        [backButton setImage:[UIImage imageNamed:@"backBtn"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"backBtn"] forState:UIControlStateHighlighted];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton * closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 40)];
        [closeBtn setImage:[UIImage imageNamed:@"X"] forState:UIControlStateNormal];
        closeBtn.imageEdgeInsets = UIEdgeInsetsMake(11.5, 10, 11.5, 10);
        [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItemExit = [[UIBarButtonItem alloc]initWithCustomView:closeBtn];
        UIBarButtonItem *leftItemback = [[UIBarButtonItem alloc]initWithCustomView:backButton];        
        _itemArray = [NSMutableArray arrayWithObjects:leftItemback,leftItemExit, nil];

    }
    return _itemArray;
}
- (UIBarButtonItem *)rightButton
{
    return nil;
}

- (UIView *)centerView
{
    return nil;
}

- (void)actionOnTouchBackButton:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)hideTabbar:(BOOL)hidden
{
    self.tabBarController.tabBar.hidden = hidden;//隐藏导航栏
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)closeBtnClick{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)puchOpenfirst{
    OpenAccountFirstViewController *main = [[OpenAccountFirstViewController alloc] init];
//    NavigationBaseController *nav = [[NavigationBaseController alloc] initWithRootViewController:main];
    [self.navigationController pushViewController:main animated:YES];
}

-(void)puchOtherInformation{
    OtherInforViewController *secondViewController = [[OtherInforViewController alloc] init];
    [self.navigationController pushViewController:secondViewController animated:YES];
}

-(void)puchOpenAccountFirst{
    OpenAccountFirstViewController *openFirst = [[OpenAccountFirstViewController alloc] init];
    [self.navigationController pushViewController:openFirst animated:YES];
}
-(void)puchOpenAccount{
}
-(void)puchTakeIdCardPhoto{
    IdPhotoViewController *idcard = [[IdPhotoViewController alloc] init];
    [self.navigationController pushViewController:idcard animated:YES];
}
-(void)puchBankCardInfo{
    BankCardInfoViewController *bankCardInfo = [[BankCardInfoViewController alloc] init];
    [self.navigationController pushViewController:bankCardInfo animated:YES];
}
-(void)puchContactInfo{
    ContactInfoViewController *contactInfo = [[ContactInfoViewController alloc] init];
    [self.navigationController pushViewController:contactInfo animated:YES];
}
-(void)puchFinanceInfo{
    FinanceInfoViewController *financeInfo = [[FinanceInfoViewController alloc] init];
    [self.navigationController pushViewController:financeInfo animated:YES];
}
-(void)puchExperience{
    ExperienceViewController *experience = [[ExperienceViewController alloc] init];
    [self.navigationController pushViewController:experience animated:YES];
}
-(void)puchWitnessCity{
    WitnessCityViewController *witnessCity = [[WitnessCityViewController alloc] init];
    [self.navigationController pushViewController:witnessCity animated:YES];
}
-(void)puchCommitInfo{
    CommitInfoViewController *commitInfo = [[CommitInfoViewController alloc] init];
    [self.navigationController pushViewController:commitInfo animated:YES];
}
-(void)puchProgress{
    ProgressViewController *progress = [[ProgressViewController alloc] init];
    [self.navigationController pushViewController:progress animated:YES];
}
-(void)puchLogin_register{
    LoginViewController *login_register = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:login_register animated:YES];
}
-(void)hiddenCloseBtnClick{
    UIBarButtonItem *item = self.itemArray[1];
    [item setCustomView:nil];
}
-(void)pushDerivative{
    DerivativeViewController *derivative = [[DerivativeViewController alloc] init];
    [self.navigationController pushViewController:derivative animated:YES];
}
@end
