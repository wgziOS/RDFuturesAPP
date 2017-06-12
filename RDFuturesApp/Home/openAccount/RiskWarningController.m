//
//  RiskWarningController.m
//  RDFuturesApp
//
//  Created by user on 17/3/11.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "RiskWarningController.h"

@interface RiskWarningController ()
{
    int pointer ;//指针指向第几个View;
}
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *allBtn;
@property (weak, nonatomic) IBOutlet UILabel *workerNumName;
@property (weak, nonatomic) IBOutlet UIImageView *workerImageIcon;
@property (weak, nonatomic) IBOutlet UILabel *workerNumCard;
@property (weak, nonatomic) IBOutlet UIView *zero;

@property (strong, nonatomic) IBOutlet UIView *first;
@property (strong, nonatomic) IBOutlet UIView *second;
@property (strong, nonatomic) IBOutlet UIView *third;
@property (strong, nonatomic) IBOutlet UIView *fouth;
@property (strong, nonatomic) IBOutlet UIView *allView;
@property(strong, nonatomic) NSMutableArray *viewArray;
@property (weak, nonatomic) IBOutlet UIView *bgView;//背景View;
@property (weak, nonatomic) IBOutlet UIButton *backStep;//返回上一步
@property (weak, nonatomic) IBOutlet UIButton *nextStep;

@end

@implementation RiskWarningController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    pointer = 1;
    [self addView];
    [self.backStep setHidden:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)next:(id)sender {
    UIButton *button = sender;
    
    switch (pointer) {
        case 1:
            [self.zero removeFromSuperview];
            [self.view addSubview:self.first];
            pointer++;//1
            [button setTitle:@"我已明白，查看下一条" forState:UIControlStateNormal];
            
            break;
        case 2:
            [self.first removeFromSuperview];
            [self.view addSubview:self.second];
            [self.backStep setHidden:NO];
            [button setTitle:@"我已明白，查看下一条" forState:UIControlStateNormal];
            
            pointer++;//2
            break;
        case 3:
            [self.second removeFromSuperview];
            [self.view addSubview:self.third];
            pointer++;//3
            [button setTitle:@"我已明白，查看下一条" forState:UIControlStateNormal];
            
            break;
        case 4:
            [self.third removeFromSuperview];
            [self.view addSubview:self.fouth];
            pointer++;//4
            [button setTitle:@"我已清楚明白全部风险" forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    
    NSLog(@"%d",pointer);
    
}
//返回上一步
- (IBAction)ReturnToPreviousStep:(id)sender {
    
    switch (pointer) {
        case 2:
            [self.second removeFromSuperview];
            [self.view addSubview:self.first];
            [self.backStep setHidden:YES];
            [self.nextStep setTitle:@"我已明白，查看下一条" forState:UIControlStateNormal];
            
            break;
        case 3:
            [self.second removeFromSuperview];
            [self.view addSubview:self.first];
            [self.backStep setHidden:YES];
            [self.nextStep setTitle:@"我已明白，查看下一条" forState:UIControlStateNormal];
            
            pointer--;
            break;
        case 4:
            [self.third removeFromSuperview];
            [self.view addSubview:self.second];
            [self.nextStep setTitle:@"我已明白，查看下一条" forState:UIControlStateNormal];
            
            pointer--;
            
            break;
        case 5:
            [self.fouth removeFromSuperview];
            [self.view addSubview:self.third];
            [self.nextStep setTitle:@"我已明白，查看下一条" forState:UIControlStateNormal];
            
            pointer--;
            break;
        default:
            break;
    }
    NSLog(@"%d",pointer);
    
}
//全部播放
- (IBAction)allStepPlay:(id)sender {
    UIButton *button =  sender;
    if (button.selected == YES) {
        [self.allView removeFromSuperview];
        [self.view addSubview:self.first];
        [self.nextStep setTitle:@"我已明白，查看下一条" forState:UIControlStateNormal];
    }else{
        switch (pointer) {
            case 2:
                [self.second removeFromSuperview];
                break;
            case 3:
                [self.second removeFromSuperview];
                break;
            case 4:
                [self.third removeFromSuperview];
                break;
            case 5:
                [self.fouth removeFromSuperview];
                break;
            default:
                break;
        }
        [self.backStep setHidden:YES];
        [self.nextStep setTitle:@"我已清楚明白全部风险" forState:UIControlStateNormal];
        pointer=2;
        [self.view addSubview:self.allView];
    }
    button.selected = !button.selected;
}
//播放当前步骤
- (IBAction)playCurrentStep:(id)sender {
    
}
//我有疑问
- (IBAction)IHaveQuestions:(id)sender {
    
    UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"提示" message:@"如有疑问，请拨打客服电话XXXXXXXXXXXX联系持牌代表解答你的疑问。" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"拨打");

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://8208208820"] options:@{} completionHandler:^(BOOL success) {
            
        }];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:^{
        NSLog(@"presented");
    }];
    
    
}
-(void)addView{
    [self.viewArray addObject:self.first];
    [self.viewArray addObject:self.second];
    [self.viewArray addObject:self.third];
    [self.viewArray addObject:self.fouth];
    [self.viewArray addObject:self.allView];
}
-(UIView *)first{
    
    _first.frame = CGRectMake(0, getTop(self.bgView), self.view.frame.size.width, 145);
    return _first;
}
-(UIView *)second{
    
    _second.frame = CGRectMake(0, getTop(self.bgView), self.view.frame.size.width, 145);
    
    
    return _second;
}
-(UIView *)third{
    
    _third.frame = CGRectMake(0, getTop(self.bgView), self.view.frame.size.width, 145);
    
    
    return _third;
}
-(UIView *)fouth{
    
    _fouth.frame = CGRectMake(0, getTop(self.bgView), self.view.frame.size.width, 145);
    
    
    return _fouth;
}
-(UIView *)allView{
    
    _allView.frame = CGRectMake(0, getTop(self.bgView), self.view.frame.size.width, 145);
    
    
    return _allView;
}
-(NSMutableArray *)viewArray{
    
    if (!_viewArray) {
        _viewArray = [[NSMutableArray alloc] init];
        
    }
    
    return _viewArray;
}

@end
