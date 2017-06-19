//
//  APIServiceViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/6/15.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "APIServiceViewController.h"

@interface APIServiceViewController (){

    BOOL is_Algostar;

    int topClick;
    
    int readClick;
}

@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UILabel *middleLabel;
@property (weak, nonatomic) IBOutlet UIButton *readBtn;
@property (weak, nonatomic) IBOutlet UIButton *patentButton;
@end

@implementation APIServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"API服务申请";
    [self setLabelTap];
    [self loadBtnStatus];
    
    
}
//下一步
- (IBAction)nextBtnClick:(id)sender {
    
    NSString * str;
    
    str = is_Algostar?@"1":@"2";
    
}

//弹框
-(void)pushImportantNotice{
    
}

-(void)loadBtnStatus{
    
    topClick = 1;
    is_Algostar = YES;
    [self AlgostarIsYES];
    readClick = 1;
    [_readBtn setImage:[UIImage imageNamed:@"untick_icon"] forState:UIControlStateNormal];
    
    [_patentButton setBackgroundImage:[UIImage imageNamed:@"gray_btn"] forState:UIControlStateNormal];
}

- (IBAction)firstBtnClick:(id)sender {
    
    if (is_Algostar) {
        return;
    }
    if (topClick == 1) {
        
        [self konwDerivativesIsNO];
        is_Algostar = NO;
        
        topClick =2;
        return;
    }
    if (topClick ==2) {
        
        [self AlgostarIsYES];
        is_Algostar = YES;
        topClick = 1;
        return;
    }
}
- (IBAction)secondBtnClick:(id)sender {
    if (!is_Algostar) {
        return;
    }
    if (topClick == 1) {
        
        [self konwDerivativesIsNO];
        //打钩
        is_Algostar = NO;
        topClick =2;
        return;
    }
    if (topClick ==2) {
        
        [self AlgostarIsYES];
        is_Algostar = YES;
        
        topClick = 1;
        return;
    }
}

-(void)AlgostarIsYES{
    
    [_firstBtn setImage:[UIImage imageNamed:@"tick_icon"] forState:UIControlStateNormal];
    [_secondBtn setImage:[UIImage imageNamed:@"untick_icon"] forState:UIControlStateNormal];
}
-(void)konwDerivativesIsNO{
    
    [_firstBtn setImage:[UIImage imageNamed:@"untick_icon"] forState:UIControlStateNormal];
    //打钩
    [_secondBtn setImage:[UIImage imageNamed:@"tick_icon"] forState:UIControlStateNormal];
}
//已读
- (IBAction)readbtnClick:(id)sender {
    if (readClick == 1) {
        [_readBtn setImage:[UIImage imageNamed:@"tick_icon"] forState:UIControlStateNormal];
        _patentButton.userInteractionEnabled = YES;
        [_patentButton setBackgroundImage:[UIImage imageNamed:@"b_btn"] forState:UIControlStateNormal];
        readClick =2;
        return;
    }
    if (readClick ==2) {
        [_readBtn setImage:[UIImage imageNamed:@"untick_icon"] forState:UIControlStateNormal];
        _patentButton.userInteractionEnabled = NO;
        [_patentButton setBackgroundImage:[UIImage imageNamed:@"gray_btn"] forState:UIControlStateNormal];
        readClick = 1;
        return;
    }

    
}

-(void)setLabelTap{
    if (SCREEN_WIDTH == 320) {
        self.middleLabel.font = [UIFont rdSystemFontOfSize:12.0f];
    }else self.middleLabel.font = [UIFont rdSystemFontOfSize:14.0f];
    
    self.middleLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushImportantNotice)];
    [self.middleLabel addGestureRecognizer:tap];
    
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

@end
