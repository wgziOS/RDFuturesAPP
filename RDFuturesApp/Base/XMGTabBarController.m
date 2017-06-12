//
//  XMGTabBarController.m
//  carport
//
//  Created by 吴桂钊 on 2016/12/5.
//  Copyright © 2016年 86gg.cn. All rights reserved.
//

#import "XMGTabBarController.h"
#import "XMGTabBar.h"
#import "XMGNavigationController.h"



@interface XMGTabBarController()
@end

@implementation XMGTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [UINavigationBar appearance];
    
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = YELLOWCOLOR;
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];

   
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // 添加子控制器
    [self setupChildVc:[[MainViewController alloc] init] title:@"首页" image:@"ysp-sy" selectedImage:@"ysp-sy-dj"];
    
    
    [self setupChildVc:[[GoodsViewController alloc] init] title:@"商品" image:@"ysp-sp" selectedImage:@"ysp-sp-dj"];


    [self setupChildVc:[[MeViewController alloc] init] title:@"我的" image:@"ysp-wdzx" selectedImage:@"ysp-wdzx-dj"];
    
    // 更换tabBar
    [self setValue:[[XMGTabBar alloc] init] forKeyPath:@"tabBar"];
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
    XMGNavigationController *nav = [[XMGNavigationController alloc] initWithRootViewController:vc];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"ysp-dhlbj"] forBarMetrics:UIBarMetricsDefault];

//    [nav.navigationBar setBarTintColor:[UIColor colorWithRed:0.30 green:0.686 blue:0.988 alpha:1.0]];
    
    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:YELLOWCOLOR,
                                               NSFontAttributeName:[UIFont boldSystemFontOfSize:18]
                                               }];
    [self addChildViewController:nav];
}
@end
