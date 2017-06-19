//
//  ShootExampleView.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/3/3.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "ShootExampleView.h"
static CGFloat kTransitionDuration = 0.3;
@implementation ShootExampleView
-(id)init {
    
    self = [super init];
    if (self) {
        
    }
    return self;
}
//重要通知tableView
-(id)initWithImportContentStr:(NSString *)contentStr {
    
    self = [super init];
    if (self) {
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, MyEditorWidth-20, MyEditorHeight)];
        label.text = contentStr;
        [self addSubview:label];
        
        label.font = [UIFont rdSystemFontOfSize:12.0f];
        label.textColor = [UIColor darkGrayColor];
        
    }
    return self;
}

-(id)initViewTitleImgString:(NSString *)imgString TitleString:(NSString *)titleString SubTitleString:(NSString *)subTitleString BtnImgString:(NSString *)btnImgString
{
    
    self = [super init];
    if (self) {
        
        
        
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(MyEditorWidth / 2 - 50, 15, 100, 25)];
        label1.text = titleString;
        label1.font = [UIFont rdSystemFontOfSize:20];
        label1.textColor = GRAYCOLOR;
        label1.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label1];
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 65, MyEditorWidth-40, (MyEditorWidth-40)/2)];
        imageView.image = [UIImage imageNamed:imgString];
        [self addSubview:imageView];
        
        
        UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(20, 265, MyEditorWidth-40, 80)];
        label2.textColor = GRAYCOLOR;
        label2.numberOfLines = 0;
        NSMutableAttributedString* string = [[NSMutableAttributedString alloc]initWithString:subTitleString];

        NSRange range2, range3, range4;

        range2 = NSMakeRange(2, 4);
        range3 = NSMakeRange(9, 4);
        range4 = NSMakeRange(23, 4);

        [string addAttribute:NSForegroundColorAttributeName value:BLUECOLOR range:range2];
        [string addAttribute:NSForegroundColorAttributeName value:BLUECOLOR range:range3];
        [string addAttribute:NSForegroundColorAttributeName value:BLUECOLOR range:range4];
     
        [label2 setAttributedText:string];
        
        label2.font = [UIFont rdSystemFontOfSize:16];
        label2.textAlignment = NSTextAlignmentLeft;
        [self addSubview:label2];
        
        
        UIImageView * imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:btnImgString]];
        imgView.frame = CGRectMake(MyEditorWidth / 2 - 65, MyEditorHeight - 60, 130, 45);
        [self addSubview:imgView];
        
        UIButton * go_onbuuton = [UIButton buttonWithType:UIButtonTypeCustom];
        [go_onbuuton setFrame:CGRectMake(MyEditorWidth / 2 - 65, MyEditorHeight - 60, 130, 45)];
        [go_onbuuton setTitle:@"拍摄照片" forState:UIControlStateNormal];
        go_onbuuton.titleLabel.font = [UIFont rdSystemFontOfSize:16];
        [go_onbuuton setTintColor:[UIColor blueColor]];
        [go_onbuuton addTarget:self action:@selector(goonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:go_onbuuton];
        
        UIButton * closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeButton setFrame:CGRectMake(MyEditorWidth - 45, 12, 35, 35)];
        [closeButton setImage:[UIImage imageNamed:@"hei_X"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeButton];
        
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
    self.frame = CGRectMake(SCREEN_WIDTH/2-MyEditorWidth/2, SCREEN_HEIGHT/2-MyEditorHeight*0.5, MyEditorWidth, MyEditorHeight);
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
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
        self.backImageView.backgroundColor = [UIColor blackColor];
        self.backImageView.alpha = 0.6f;
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    [topVC.view addSubview:self.backImageView];
    
    // 一系列动画效果,达到反弹效果
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.05, 0.05);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounceAnimationStopped)];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
    [UIView commitAnimations];
    
    [super willMoveToSuperview:newSuperview];
}

#pragma mark - 缩放
- (void)bounceAnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce2AnimationStopped)];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.7, 0.7);
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
-(id)initViewTitleImgString:(NSString *)title cachString:(NSString *)cach financingString:(NSString *)financing
{
    
    self = [super init];
    if (self) {
        
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(MyEditorWidth / 2 - 100, 15, 200, 25)];
        label1.text = title;
        label1.font = [UIFont rdSystemFontOfSize:22];
        label1.textColor = RGB(98, 98, 98);
        label1.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label1];
        
        
        UILabel * cachlabel = [[UILabel alloc]initWithFrame:CGRectMake(20, getTop(label1)+5, MyEditorWidth-40, 80)];
        cachlabel.numberOfLines = 0;
        cachlabel.text = cach;
        cachlabel.textColor = RGB(139, 138, 138);
        cachlabel.font = [UIFont rdSystemFontOfSize:16];
        [self addSubview:cachlabel];
        
        UILabel *financinglabel = [[UILabel alloc]initWithFrame:CGRectMake(20, getTop(cachlabel)+15, MyEditorWidth-40, 130)];
        financinglabel.numberOfLines = 0;
        financinglabel.textColor = RGB(139, 138, 138);
        financinglabel.font = [UIFont rdSystemFontOfSize:16];
        financinglabel.text = financing;
        [self addSubview:financinglabel];
        
        UIButton * go_onbuuton = [UIButton buttonWithType:UIButtonTypeCustom];
        [go_onbuuton setFrame:CGRectMake(MyEditorWidth / 2 - 65, 290, 130, 45)];
        [go_onbuuton setTitle:@"我知道了" forState:UIControlStateNormal];
        [go_onbuuton setBackgroundImage:[UIImage imageNamed:@"blue_btn"] forState:UIControlStateNormal];
        [go_onbuuton addTarget:self action:@selector(goonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:go_onbuuton];
        
    }
    
    return self;
}
- (void)showCachAccount
{
    UIViewController *topVC = [self appRootViewController];
    self.frame = CGRectMake(SCREEN_WIDTH/2-MyEditorWidth/2, SCREEN_HEIGHT/2-350*0.5, MyEditorWidth, 350);
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    [topVC.view addSubview:self];
}
@end
