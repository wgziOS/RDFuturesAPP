//
//  NavigationBaseController.m
//  RDFuturesApp
//
//  Created by user on 17/2/28.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NavigationBaseController.h"
#import "NotificationModel.h"
#import "MessageViewController.h"

@interface NavigationBaseController ()
@property(nonatomic,strong)NSMutableArray *array;
@end

@implementation NavigationBaseController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self leftBarItem];
//    [self getNotify];

}
+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    
//    icon_navigationbar_backgroundImage
    [bar setBackgroundImage:[UIImage imageNamed:@"navigation_redBackgroundImage"] forBarMetrics:UIBarMetricsDefault];
    bar.translucent = YES;
    
    NSMutableDictionary *barAttrs = [NSMutableDictionary dictionary];
    barAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:15];
    [bar setTitleTextAttributes:barAttrs];
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    
    NSMutableDictionary *disabledAttrs = [NSMutableDictionary dictionary];
    disabledAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:disabledAttrs forState:UIControlStateDisabled];

    
    
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                  NSFontAttributeName:[UIFont boldSystemFontOfSize:18]
                                  }];
    
//    .titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_navigation_image"]];
}
-(void)leftBarItem{
    

}



/**
 * 可以在这个方法中拦截所有push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
        //        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        ////        [button setTitle:@"返回" forState:UIControlStateNormal];
        //        [button setImage:[UIImage imageNamed:@"backBtn"] forState:UIControlStateNormal];
        //        [button setImage:[UIImage imageNamed:@"backBtn"] forState:UIControlStateHighlighted];
        //        button.size = CGSizeMake(70, 30);
        //
        //        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //
        //        button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        //        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        //        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        //        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        //        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
    
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

#pragma mark - <UIGestureRecognizerDelegate>
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.childViewControllers.count > 1;
}
-(NSMutableArray *)array{
    if (!_array) {
        _array = [[NSMutableArray alloc] init];
        
    }
    return _array;
}
@end
