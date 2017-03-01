//
//  TabBarBaseController.m
//  RDFuturesApp
//
//  Created by user on 17/2/28.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "TabBarBaseController.h"

@interface TabBarBaseController ()

@end

@implementation TabBarBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.barStyle = UIBarStyleDefault;
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.tintColor = [UIColor darkGrayColor];
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.delegate = self;

    
}
-(instancetype)init{
    if (self=[super init]) {
        [self addChildViewController];
    }
    return self;
}
-(void)addChildViewController{

    HomeViewController *home = [[HomeViewController alloc] init];
    NavigationBaseController *homeNav = [[NavigationBaseController alloc] initWithRootViewController:home];
    UITabBarItem* marketItem = [[UITabBarItem alloc] initWithTitle:@"瑞达" image:[UIImage imageNamed:@"icon_tabBarHome_defult"] tag:0];
    marketItem.selectedImage = [UIImage imageNamed:@"icon_tabBarHome_defult"];
    homeNav.tabBarItem = marketItem;
    [self addChildViewController:homeNav];
    
    ViewController *selfSet = [[ViewController alloc] init];
    NavigationBaseController *selfNav = [[NavigationBaseController alloc] initWithRootViewController:selfSet];
    UITabBarItem* selfItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"icon_tabBarSelf_defult"] tag:1];
    selfItem.selectedImage = [UIImage imageNamed:@"icon_tabBarSelf_defult"];
    selfNav.tabBarItem = selfItem;
    [self addChildViewController:selfNav];

//    self.tabBarController.viewControllers = @[home,selfSet];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
//    UITabBarItem *tabbarItem = tabBar.items[2];
    NSLog(@"2");
    
    
}
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSLog(@"1");
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
