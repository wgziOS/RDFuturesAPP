//
//  ViewBaseController.m
//  RDFuturesApp
//
//  Created by user on 17/2/28.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "ViewBaseController.h"
#import "OpenAccountFirstViewController.h"
#import "OtherInforViewController.h"
#import "AccountChooseController.h"
#import "RiskWarningController.h"
#import "TakePhotoController.h"


@interface ViewBaseController ()

@end

@implementation ViewBaseController

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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


- (void) setUpNavigationBar
{
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title.png"] forBarMetrics:UIBarMetricsDefault];//设置导航栏图片
    [self.navigationController.navigationBar setBarTintColor:RGB(255, 165, 33)];//设置导航栏的背景颜色
    
    //    self.navigationController.navigationBar.alpha = 0;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    self.navigationItem.leftBarButtonItem = [self leftButton];//设置导航栏左边按钮
    self.navigationItem.rightBarButtonItem = [self rightButton];//设置导航栏右边按钮
    self.navigationItem.titleView = [self centerView];//设置titel
    if([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (UIBarButtonItem *)leftButton
{
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [btn setImage:[UIImage imageNamed:@"et_back.png"] forState:UIControlStateNormal];//设置左边按钮的图片
    [btn addTarget:self action:@selector(actionOnTouchBackButton:) forControlEvents:UIControlEventTouchUpInside];//设置按钮的点击事件
    return [[UIBarButtonItem alloc] initWithCustomView:btn];;
    
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
-(void)gotoGoshopViewController{
    
}
-(void)gotoStoreViewController{
    
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    ViewBaseController *vc = [super allocWithZone:zone];
    @weakify(vc);
    [[vc rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        @strongify(vc)
        [vc addChildView];
        [vc bindViewModel];
    }];
    
    [[vc rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
        
        @strongify(vc)
        [vc layoutNavigation];
        [vc getNewData];
        
        
    }];
    
    return vc;
}




-(void)addChildView{
    
}
-(void)bindViewModel{
    
}
-(void)getNewData{
    
}
-(void)layoutNavigation{
    
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

-(void)puchOpenfirst{
    
    OpenAccountFirstViewController *open = [[OpenAccountFirstViewController alloc] init];
    [self.navigationController pushViewController:open animated:YES];
    
}
-(void)puchtakePhoto{
    
    TakePhotoController *takePhoto = [[TakePhotoController alloc] init];
    [self.navigationController pushViewController:takePhoto animated:YES];
    
}
-(void)puchOtherInformation{

    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"OtherInfor" bundle:nil];
    OtherInforViewController *secondViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"OtherInforViewController"];
    [self.navigationController pushViewController:secondViewController animated:YES];
}
-(void)puchAccountChoose{
    AccountChooseController *account = [[AccountChooseController alloc] init];
    [self.navigationController pushViewController:account animated:YES];
}

-(void)puchRiskWarning{
    RiskWarningController *account = [[RiskWarningController alloc] init];
    [self.navigationController pushViewController:account animated:YES];
}
@end
