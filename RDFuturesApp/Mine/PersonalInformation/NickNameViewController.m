//
//  NickNameViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/8.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NickNameViewController.h"

@interface NickNameViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation NickNameViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view setBackgroundColor:BACKGROUNDCOLOR];
    self.title = @"修改昵称";
    [self rightButton];

    /*
     ###34、提交昵称信息
     
     /api/user/changeUserName.api
    
    *请求参数*
    
    1、username                 用户昵称
     */
}
//save
-(void)saveBtnClick:(id)sender{
    
    NSString * str = [NSString stringWithFormat:@"%@",_textField.text];
    if (str.length == 0) {
        showMassage(@"昵称不能为空哦");
        return;
    }
        loading(@"正在上传数据");
    __weak __typeof(self)weakSelf = self;
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [dic setObject:str forKey:@"username"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error ;
        
        RDRequestModel * model = [RDRequest getWithApi:@"/api/user/changeUserName.api" andParam:dic error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if (error==nil) {
                showMassage(model.Message);                
                if ([model.Message isEqualToString:@"成功"]) {
                    self.backblock(model.Data[@"username"]);
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
                
            }else{
                [MBProgressHUD showError:@"请求失败"];
            }
        });
        
    });
}
- (UIBarButtonItem *)rightButton
{
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45, 35)];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont rdSystemFontOfSize:15];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];//设置按钮的点击事件
    return [[UIBarButtonItem alloc] initWithCustomView:btn];;
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
