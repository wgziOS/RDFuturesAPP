//
//  BusinessHandlingViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/6/14.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BusinessHandlingViewController.h"
#import "BusinessHandlingCell.h"
#import "WithdrawFundsViewController.h"
#import "DepositFundsViewController.h"
@interface BusinessHandlingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL isFinishAccount;
}
@end

@implementation BusinessHandlingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"业务办理";
    [self isAccount];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:kBusinessHandlingCell bundle:nil] forCellReuseIdentifier:kBusinessHandlingCell];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(![[RDUserInformation getInformation] getLoginState]){
        [self puchLogin];
    }
    
    
    if (indexPath.row== 0) {
        if (isFinishAccount) {
            DepositFundsViewController * DVC = [[DepositFundsViewController alloc]init];
            [self.navigationController pushViewController:DVC animated:YES];
        }else showMassage(@"您尚未完成开户")
        
    }else{
        
        //提取资金
        if(!isFinishAccount){

            showMassage(@"您尚未完成开户");
        }else{
            WithdrawFundsViewController * WVC = [[WithdrawFundsViewController alloc]init];
            [self.navigationController pushViewController:WVC animated:YES];
        }
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BusinessHandlingCell * cell = [tableView dequeueReusableCellWithIdentifier:kBusinessHandlingCell];
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"存入资金";
    }else cell.titleLabel.text = @"提取资金";
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 45;

}
-(void)isAccount{
    WS(weakself)
    //    speed_status			进度状态（1：资料审核 2：完成 3：失败 4：未开户）
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error ;
        
        RDRequestModel * model = [RDRequest getWithApi:@"/api/account/getQueryAccount.api" andParam:nil error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([model.State intValue]==1) {
                NSString * str = [NSString stringWithFormat:@"%@",model.Data[@"speed_status"]];
                NSLog(@"开户state=%@",model.Data);
                if ([str isEqualToString:@"2"]) {
                    isFinishAccount = YES;
                }else isFinishAccount = NO;
                [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"isFinishAccount"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [weakSelf puchOpenfirst];
            }else{
//                showMassage(@"请求失败")
            }
        });
    });
    
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
