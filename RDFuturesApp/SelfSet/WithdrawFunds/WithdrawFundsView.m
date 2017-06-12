//
//  WithdrawFundsView.m
//  RDFuturesApp
//
//  Created by user on 17/5/9.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "WithdrawFundsView.h"
#import "MATextFieldTableViewCell.h"
#import "MAChooseTableViewCell.h"
#import "WithdrawFundsViewModel.h"
#import "WithdrawFundsTableViewCell.h"


@interface WithdrawFundsView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)WithdrawFundsViewModel *viewModel;
@property(nonatomic,strong)UIView *footView;
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)UIButton *nextStep;
@property(nonatomic,strong)UIImageView *btnImage;
@end

@implementation WithdrawFundsView

-(void)setupViews{
    [self addSubview:self.tableView];
    [self.footView addSubview:self.btnImage];
    [self.footView addSubview:self.nextStep];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)updateConstraints{
    WS(weakself)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf);
        
    }];
    [self.footView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    
        [self.nextStep mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.footView);
            make.centerX.equalTo(weakSelf.tableView);
            make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-40, 40));
        }];
        [self.btnImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.footView);
            make.centerX.equalTo(weakSelf.footView);
            make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-40, 40));
        }];
    
    
    [super updateConstraints];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    switch (indexPath.row) {
        case 0:{
            MAChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MAChooseTableViewCell class])] forIndexPath:indexPath];
            cell.title = self.titleArray[indexPath.row];
            return cell;
            
        }
            break;
        case 1:{
            MATextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MATextFieldTableViewCell class])] forIndexPath:indexPath];
            cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
            cell.titleStr = self.titleArray[indexPath.row];
            cell.placeholderStr = @"可提金额";
            return cell;
            
        }
            break;
        case 2:{
            MAChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MAChooseTableViewCell class])] forIndexPath:indexPath];
            cell.title = self.titleArray[indexPath.row];
            return cell;
            
        }
            break;
            
        case 3:{
            MAChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MAChooseTableViewCell class])] forIndexPath:indexPath];
            cell.title = self.titleArray[indexPath.row];
            return cell;
        }
            break;
        case 4:{
            MATextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MATextFieldTableViewCell class])] forIndexPath:indexPath];
            cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
            cell.titleStr = self.titleArray[indexPath.row];
            return cell;
            
        }
            break;
        case 5:{
            MATextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MATextFieldTableViewCell class])] forIndexPath:indexPath];
            cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
            cell.titleStr = self.titleArray[indexPath.row];
            return cell;
            
        }
            break;
        case 6:{
            MATextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MATextFieldTableViewCell class])] forIndexPath:indexPath];
            cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
            cell.titleStr = self.titleArray[indexPath.row];
            return cell;
            
        }
            break;
        case 7:{
            WithdrawFundsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([WithdrawFundsTableViewCell class])] forIndexPath:indexPath];
            cell.titleStr = self.titleArray[indexPath.row];
            return cell;
            
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}
-(void)nextStepClick{
        [self.viewModel.nextStepClickSubject sendNext:nil];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"提款币种",@"提款金额",@"提取方式",@"收款银行",@"收款人",@"银行账号",@"银行地址",@"国际汇款编码 SWIFT#", nil];
    }
    return _titleArray;
}
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (WithdrawFundsViewModel*)viewModel;
    return [super initWithViewModel:viewModel];
}
-(UIView *)footView{
    if (!_footView) {
        _footView = [[UIView alloc] init];
    }
    return _footView;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = self.footView;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [_tableView registerClass:[MAChooseTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([MAChooseTableViewCell class])]];
        [_tableView registerClass:[MATextFieldTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([MATextFieldTableViewCell class])]];
        [_tableView registerClass:[WithdrawFundsTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([WithdrawFundsTableViewCell class])]];
        
    }
    return _tableView;
}
-(UIButton *)nextStep{
    if (!_nextStep) {
        _nextStep = [UIButton buttonWithType:UIButtonTypeSystem];
        [_nextStep setTitle:@"下一步,选择存入银行" forState: UIControlStateNormal];
        [_nextStep setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextStep addTarget:self action:@selector(nextStepClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextStep;
}
-(UIImageView *)btnImage{
    if (!_btnImage) {
        _btnImage = [[UIImageView alloc] init];
        [_btnImage setImage:[UIImage imageNamed:@"b_btn"]];
    }
    return _btnImage;
}

@end
