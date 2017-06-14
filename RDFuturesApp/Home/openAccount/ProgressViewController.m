//
//  ProgressViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/3/13.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "ProgressViewController.h"

@interface ProgressViewController ()
{
    NSString * statesStr;
}
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *AccountLabel;
@property (weak, nonatomic)  IBOutlet UIImageView *statesImgView;
@property (weak, nonatomic) IBOutlet UIView *whiteBGView;
@end

@implementation ProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"进度查询";
    
//    WS(weakself)
//    [self.whiteBGView addSubview:self.statesImgView];
//    [self.statesImgView mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.centerY.equalTo(weakSelf.whiteBGView);
////        make.left.equalTo(weakSelf.whiteBGView).with.offset(15);
////        make.size.mas_offset(CGSizeMake(100, 100*1.92));
//        make.edges.equalTo(weakSelf.whiteBGView);
//    }];
//    _statesImgView.image = [UIImage imageNamed:@"all_blue"];
    
    
    [self loadingGetData];
    [self changeImageViewAndData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.PuchStyle ==YES) {
        [self hiddenCloseBtnClick];
    }
}
-(void)loadingGetData{
    loading(@"");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSError *error;
        RDRequestModel *model = [RDRequest postSpeedInfoWithParam:nil
                                                            error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if (error ==nil) {
                if ([model.State  isEqualToString:@"1"]) {
                    NSDictionary *dic = model.Data;
                    self.nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"account_name"]];
                    self.AccountLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"account_num"]];
                    statesStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"speed_status"]];
                    [self changeImageViewAndData];
                }else{
                    showMassage(model.Message)
                }
            }else{
                [MBProgressHUD showError:promptString];
            }
            
        });
    });
}
#pragma mark - 指引按钮
- (IBAction)guideBtnClick:(id)sender {
}
#pragma mark - 完成按钮
- (IBAction)finishBtnClick:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)changeImageViewAndData{
    
    switch ([statesStr intValue]) {
        case 0:
            _statesImgView.image = [UIImage imageNamed:@"all_gray"];
            break;
        case 1:
            _statesImgView.image = [UIImage imageNamed:@"h_blue1"];
            break;
        case 2:
            _statesImgView.image = [UIImage imageNamed:@"h_blue2"];
            break;
        case 3:
            _statesImgView.image = [UIImage imageNamed:@"all_blue"];
            break;
        default:
            break;
    }
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
