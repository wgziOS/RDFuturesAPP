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
    [self setupChildVc:[[HomeViewController alloc] init] title:@"瑞达" image:@"tabbar_home_default" selectedImage:@"tabbar_home_selected"];
    
    [self setupChildVc:[[NewsViewController alloc] init] title:@"新闻" image:@"tabbar_news_default" selectedImage:@"tabbar_news_seected"];
    
    [self setupChildVc:[[NoticeViewController alloc] init] title:@"圈子" image:@"tabbar_group_default" selectedImage:@"tabbar_group_seected"];
    
    [self setupChildVc:[[MineViewController alloc] init] title:@"我的" image:@"tabbar_self_default" selectedImage:@"tabbar_self_selected"];
    
    
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
            login.puchTheWay = 1;
            NavigationBaseController *nav = [[NavigationBaseController alloc] initWithRootViewController:login];
            [self presentViewController:nav animated:YES completion:nil];
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
        
        switch ([model.inward_id intValue]) {
            case 1:
            {
                MessageViewController *message = [[MessageViewController alloc] init];
//                UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:message];
//                [weakSelf presentViewController:nav animated:YES completion:nil];
//                                                self.tabBarController.childViewControllers[0];
                                UIView *view = [[UIApplication sharedApplication].windows lastObject];
                                UIResponder *responder = view;
                                //循环获取下一个响应者,直到响应者是一个UIViewController类的一个对象为止,然后返回该对象.
                                while ((responder = [responder nextResponder])) {
                                    if ([responder isKindOfClass:[UINavigationController class]]) {
                                        UINavigationController *viewController =  (UINavigationController *)responder;
                                        [viewController.navigationController pushViewController:message animated:YES];
                                    }
                                }
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
                UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:message];
                [weakSelf presentViewController:nav animated:YES completion:nil];
            }
                break;
                
            default:
                break;
        }
    }];
    
    
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [self.selectedViewController beginAppearanceTransition: YES animated: animated];
//}
//
//-(void) viewDidAppear:(BOOL)animated
//{
//    [self.selectedViewController endAppearanceTransition];
//}
//
//-(void) viewWillDisappear:(BOOL)animated
//{
//    [self.selectedViewController beginAppearanceTransition: NO animated: animated];
//}
//
//-(void) viewDidDisappear:(BOOL)animated
//{
//    [self.selectedViewController endAppearanceTransition];
//}
@end
