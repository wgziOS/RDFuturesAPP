//
//  AccountSecurityViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/25.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "AccountSecurityViewController.h"
#import "AccountSecurityFirstCell.h"
#import "AccountSecuritySecondCell.h"
#import "ChangePhoneNumViewController.h"
#import "TestViewController.h"
#import "PromptView.h"
@interface AccountSecurityViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray * titleArray;
@property (nonatomic,strong) NSString * phoneNumStr;
@property (nonatomic,strong) NSString * idStr;
@end

@implementation AccountSecurityViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    _phoneNumStr = [userdefault objectForKey:@"phoneNumber"];
    _idStr = [userdefault objectForKey:@"user_id"];

    
    self.title = @"账户安全";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:kAccountSecurityFirstCell bundle:nil] forCellReuseIdentifier:kAccountSecurityFirstCell];
    [self.tableView registerNib:[UINib nibWithNibName:kAccountSecuritySecondCell bundle:nil] forCellReuseIdentifier:kAccountSecuritySecondCell];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self titleArray];
    
}

-(NSArray *)titleArray{
    
    if (!_titleArray) {
        _titleArray = @[@"ID号",@"手机号",@"邮箱"];
    }
    return _titleArray;
}

-(void)loadPromptView{


}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    AccountSecurityFirstCell * firstCell = [tableView dequeueReusableCellWithIdentifier:kAccountSecurityFirstCell];
    AccountSecuritySecondCell * secondCell = [tableView dequeueReusableCellWithIdentifier:kAccountSecuritySecondCell];
    firstCell.separatorInset = UIEdgeInsetsMake(0,15, 0, 15);
    secondCell.separatorInset = UIEdgeInsetsMake(0,15, 0, 15);
    WS(weakself)
    
    switch (indexPath.row) {
        case 0:{
            
            firstCell.leftLabel.text = _titleArray[0];
            firstCell.rightLabel.text = _idStr;
            return firstCell;
        }
            break;
            
        case 1:{
            
            secondCell.titleLabel.text = _titleArray[1];
            
            NSMutableString * str1 = [[NSMutableString alloc]initWithString:_phoneNumStr];
            [str1 replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
            secondCell.phoneLabel.text = str1;
            
            secondCell.bBlock = ^(){
                NSString * str = [NSString stringWithFormat:@"您正在更换认证手机号,发送验证短信到\n%@",self.phoneNumStr];
                NSMutableString * str1 = [[NSMutableString alloc]initWithString:str];
                [str1 replaceCharactersInRange:NSMakeRange(22, 4) withString:@"****"];
                PromptView * pView = [[PromptView alloc]initWithTitleString:@"提示" SubTitleString:str1];
                [pView show];
                pView.goonBlock = ^{
                
                    [weakSelf pushNextVC];
                
                };
                
                
            };
            return secondCell;
        }
            break;
            
        case 2:{
            
            firstCell.leftLabel.text = _titleArray[2];
            firstCell.rightLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
            return firstCell;
        }
            break;
            
        default:
            break;
    }

    
    return nil;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArray.count;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row == 2) {
//        TestViewController * XVC = [[TestViewController alloc]init];
//        //            [self.navigationController pushViewController:XVC animated:YES];
//        [self presentViewController:XVC animated:YES completion:nil];
//    }
    
}
-(void)pushNextVC{
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:_phoneNumStr forKey:@"phone"];
    [dic setObject:@"2" forKey:@"check_type"];//1 验证类型（1：找回密码 2：注册 3：开户）
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error ;
        
        RDRequestModel *model = [RDRequest postSendValidateCodeWithParam:dic error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error==nil) {
                showMassage(model.Message);
                
                ChangePhoneNumViewController * CVC = [[ChangePhoneNumViewController alloc]init];
                CVC.phoneNum = _phoneNumStr;
                [self.navigationController pushViewController:CVC animated:YES];
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
