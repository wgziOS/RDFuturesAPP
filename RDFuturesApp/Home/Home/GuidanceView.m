//
//  GuidanceView.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/6/23.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//
#define kScrollHeight SCREEN_WIDTH*0.453
#import "GuidanceView.h"
#import "OpenAccountFileCell.h"
static CGFloat kTransitionDuration = 0.3;
@interface GuidanceView ()
@end
@implementation GuidanceView
-(id)init {
    
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)closeBtnClick:(id)sender{
    [self dismissAlert];
}
#pragma mark - 继续按钮
-(void)goonAction:(UIButton *)sender
{
    //代码块回掉
    
    //    [self dismissAlert];
    if (self.goonBlock) {
        self.goonBlock();
        
    }
    [self dismissAlert];
}

/*
 * 展示自定义AlertView
 */
- (void)show
{
    UIViewController *topVC = [self appRootViewController];
    self.frame = CGRectMake(0,0, SCREEN_WIDTH , SCREEN_HEIGHT);
    self.backgroundColor = [UIColor whiteColor];
    self.alpha = 1.0f;

    [topVC.view addSubview:self];
}


- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}


- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    UIViewController *topVC = [self appRootViewController];
    
    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame:topVC.view.bounds];
        self.backImageView.backgroundColor = [UIColor whiteColor];
        self.backImageView.alpha = 1.0f;
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    [topVC.view addSubview:self.backImageView];
    
    // 一系列动画效果,达到反弹效果
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.05, 0.05);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounceAnimationStopped)];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    [UIView commitAnimations];
    
    [super willMoveToSuperview:newSuperview];
}

#pragma mark - 缩放
- (void)bounceAnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce2AnimationStopped)];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    [UIView commitAnimations];
}

#pragma mark - 缩放
- (void)bounce2AnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    [UIView commitAnimations];
}


- (void)dismissAlert
{
    [self remove];
}


- (void)remove
{
    [self.backImageView removeFromSuperview];
    
    [self removeFromSuperview];
    
}
-(id)initWithGuidance{

    self = [super init];
    if (self) {
        WS(weakself)
       
        //guidance_bgView
        
        UIImageView * bgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guidance_bgView"]];
        [self addSubview:bgView];
        bgView.contentMode = UIViewContentModeScaleAspectFill;
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.edges.equalTo(weakSelf);
        }];
        bgView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goonAction:) ];
        [bgView addGestureRecognizer:tap];

    }
    return self;
}






@end
