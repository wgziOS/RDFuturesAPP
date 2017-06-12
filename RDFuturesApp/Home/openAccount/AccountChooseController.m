//
//  AccountChooseController.m
//  RDFuturesApp
//
//  Created by user on 17/3/11.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "AccountChooseController.h"
#import "ShootExampleView.h"
#import "ChooseBankView.h"


@interface AccountChooseController ()
@property (weak, nonatomic) IBOutlet UIButton *NextButton;
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;
@property (weak, nonatomic) IBOutlet UIButton *cashBtn;
@property (weak, nonatomic) IBOutlet UIButton *financingButton;
@property (weak, nonatomic) IBOutlet UILabel *chooseLabel;
@property (strong, nonatomic)NSMutableArray *btnArray;

@end

@implementation AccountChooseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self addBtnImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addBtnImage{
    [self.cashBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.financingButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//    // 指定为拉伸模式，伸缩后重新赋值
    
    UIImage *imgselected = [self resizableImageWithName:@"account_choose_selected"];

    [self.cashBtn setBackgroundImage:imgselected forState:UIControlStateSelected];
    [self.financingButton setBackgroundImage:imgselected forState:UIControlStateSelected];

    self.cashBtn.selected = YES;
    [self.btnArray addObject:self.cashBtn];

}
- (IBAction)AccountChooseClick:(id)sender {
    UIButton *btn = sender;
    if (self.btnArray.count==1) {
    }
    
    btn.selected = !btn.selected;

    if (btn.selected ==NO) {
        if (self.btnArray.count==1) {
            btn.selected=YES;
        }else{
            [self.btnArray removeObject:btn];
        }
    }else{
//        if (self.btnArray.count==2) {
//            <#statements#>
//        }
        [self.btnArray addObject:btn];
    }
   
    
}
- (IBAction)howToSelectAnAccount:(id)sender {
    ShootExampleView * view = [[ShootExampleView alloc] initViewTitleImgString:@"选择账户类型" cachString:@"现金账户：使用本人自有资金进行现金交易，不允许透支，不允许卖空股票。" financingString:@"融资账户：亦称孖展账户。除使用自有资金交易，客户亦可通过该账户向瑞达期货借入资金来买入股票，起到放大交易杠杆的作用。融资可放大收益率，同事也会放大投资风险。因此建议参与融资的客户需要较强的风险承受能力。"];
    [view showCachAccount];
    
}
-(UIImage *)resizableImageWithName:(NSString*)name{
    UIImage *normal = [UIImage imageNamed:name];
    // 左端盖宽度
    NSInteger leftCapWidth = 1;
    // 顶端盖高度
    NSInteger topCapHeight = 1;
   
    
    // 重新赋值
    return [normal stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
}
- (IBAction)chooseDerivativesTrading:(id)sender {
    
    NSArray * array = [[NSArray alloc] initWithObjects:@"我无意进行衍生产品买卖",@"我有意进行衍生产品买卖", nil];
    //弹框列表
    ChooseBankView * chooseView = [[ChooseBankView alloc]initWithDataArray:array];
    [chooseView show];
    
    chooseView.callBackBlock = ^(NSString * tStr){
        //赋值
        self.chooseLabel.text = array[[tStr intValue]];
    };
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(NSMutableArray *)btnArray{
    if (!_btnArray) {
        _btnArray = [[NSMutableArray alloc] init];
    }
    return _btnArray;
}
@end
