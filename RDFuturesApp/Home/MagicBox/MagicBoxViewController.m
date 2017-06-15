//
//  MagicBoxViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/6/14.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "MagicBoxViewController.h"
#import "BusinessHandlingCell.h"
@interface MagicBoxViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSArray * array;
@end

@implementation MagicBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"百宝箱";
    [self array];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:kBusinessHandlingCell bundle:nil] forCellReuseIdentifier:kBusinessHandlingCell];
    _tableView.separatorStyle = UITableViewCellAccessoryNone;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(weakself)
    switch (indexPath.row) {
        case 0:
            [weakSelf puchBreedRules];//品种细则

            break;
        case 1:
            [weakSelf puchBankInformation];//银行信息

            break;
        case 2:
            [weakSelf puchBond];//保证金
            
            break;
        case 3:
            [weakSelf puchLastTradingDay];//最后交易日
            break;
        case 4://个人客户开户需知
            
            break;
        case 5://机构客户开户需知
            
            break;
        case 6://出入金流程
            
            break;
        case 7://品种介绍
            
            break;
        case 8://交易需知
            
            break;
            
        default:
            break;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BusinessHandlingCell *cell = [tableView dequeueReusableCellWithIdentifier:kBusinessHandlingCell];
    cell.titleLabel.text = _array[indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _array.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
-(NSArray *)array{

    if (!_array) {
        _array = [NSArray arrayWithObjects:@"品种细则",@"银行信息",@"品种保证金",@"最后交易日",@"个人客户开户需知",@"机构客户开户需知",@"出入金流程",@"品种介绍",@"交易需知" ,nil];
    }
    return _array;
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
