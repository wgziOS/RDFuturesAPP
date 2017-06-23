//
//  TabBarBaseController.m
//  RDFuturesApp
//
//  Created by user on 17/2/28.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "TabBarBaseController.h"
#import "NavigationBaseController.h"
#import "RDTabbar.h"
#import "LoginViewController.h"
#import "MessageViewController.h"
#import "BillViewController.h"

@interface TabBarBaseController ()
@property(nonatomic,assign)int oldIndex;
@end

@implementation TabBarBaseController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.delegate = self;
    
    [UINavigationBar appearance];
    
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    NSDictionary *attrs =@{NSForegroundColorAttributeName:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0f],NSFontAttributeName:[UIFont rdSystemFontOfSize:12]};
    
    
    NSDictionary *selectedAttrs = @{NSFontAttributeName:[UIFont rdSystemFontOfSize:12],NSForegroundColorAttributeName:[UIColor colorWithRed:237.0/255.0 green:2.0/255.0 blue:2.0/255.0 alpha:1.0f]};
    
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // 添加子控制器
    [self setupChildVc:[[HomeViewController alloc] init] title:@"瑞达" image:@"tab_home_default" selectedImage:@"tab_home_select"];
    
    [self setupChildVc:[[NewsViewController alloc] init] title:@"新闻" image:@"tab_news_default" selectedImage:@"tab_news_select"];
    
    [self setupChildVc:[[NoticeViewController alloc] init] title:@"圈子" image:@"tab_group_default" selectedImage:@"tab_group_select"];
    
    [self setupChildVc:[[MineViewController alloc] init] title:@"我的" image:@"tab_self_default" selectedImage:@"tab_self_select"];
    

    // 更换tabBar
    [self setValue:[[RDTabbar alloc] init] forKeyPath:@"tabBar"];
    [self addNSNotification];
    
}

- (UINavigationController *)yq_navigationController {
    return self.selectedViewController;
}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
    vc.navigationItem.title = title;

    vc.tabBarItem.title = title;
    
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    NavigationBaseController *nav = [[NavigationBaseController alloc] initWithRootViewController:vc];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_redBackgroundImage"] forBarMetrics:UIBarMetricsDefault];
    
    
    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                NSFontAttributeName:[UIFont boldSystemFontOfSize:18]
                                                }];


    
    [self addChildViewController:nav];
}
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    if (tabBarController.selectedIndex == 3) {
        if (![[RDUserInformation getInformation] getLoginState]) {
            
            LoginViewController *login = [[LoginViewController alloc] init];
            NavigationBaseController *vc = [self getCurrentVC];

            [vc pushViewController:login animated:YES];
            [self setSelectedIndex:self.oldIndex];
        }
        return;
    }
    self.oldIndex = (int)tabBarController.selectedIndex;
    
}
-(void)addNSNotification{
    WS(weakself)
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"NotificationCenter" object:nil] subscribeNext:^(NSNotification *notification) {
        if (![notification.name isEqualToString:@"NotificationCenter"]) {
            return ;
        }
        NotificationModel *model = (NotificationModel*)notification.object;
        if ([model.skip_type intValue]==1) {
            NavigationBaseController *vc = [weakSelf getCurrentVC];

            switch ([model.inward_id intValue]) {
                case 1:
                {
                    MessageViewController *message = [[MessageViewController alloc] init];
                    [vc pushViewController:message animated:YES];

                }
                    break;
                    
                case 2:
                {
                    weakSelf.selectedIndex = 2;
                }
                    break;
                    
                case 3:
                {
                    BillViewController *message = [[BillViewController alloc] init];
                    [vc pushViewController:message animated:YES];
                }
                    break;
                    
                default:
                    break;
            }

        }else{
            
        }
        
    }];
    
    
}
- (NavigationBaseController *)getCurrentVC
{
    NavigationBaseController *nav ;
    int index = (int)self.selectedIndex;
    switch (index) {
        case 0:
            nav = self.childViewControllers[0];
            break;
        case 1:
            nav = self.childViewControllers[1];
            break;
        case 2:
            nav = self.childViewControllers[2];
            break;
        case 3:
            nav = self.childViewControllers[3];
            break;
            
        default:
            break;
    }
    
    return nav;
}
@end
