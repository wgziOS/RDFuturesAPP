//
//  MoneyAmountView.m
//  RDFuturesApp
//
//  Created by user on 17/5/8.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "MoneyAmountView.h"
#import "MAChooseTableViewCell.h"
#import "MATextFieldTableViewCell.h"
#import "MoneyAmountViewModel.h"

@interface MoneyAmountView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)MoneyAmountViewModel *viewModel;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)UIView *footView;
@property(nonatomic,strong)NSMutableArray *titleArray;
@property(nonatomic,strong)UIButton *nextStep;
@property(nonatomic,strong)UIImageView *btnImage;

@end


@implementation MoneyAmountView

-(void)setupViews{
    [self addSubview:self.table];
    [self.footView addSubview:self.btnImage];
    [self.footView addSubview:self.nextStep];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (MoneyAmountViewModel*)viewModel;
    return [super initWithViewModel:viewModel];
}
-(void)updateConstraints{
    WS(weakself)
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf);
        
    }];
    [self.footView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    
    [self.nextStep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.footView);
        make.centerX.equalTo(weakSelf.footView);
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
    return 60.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section; {
    
    return @"选择持有银行卡";
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:{
            MAChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MAChooseTableViewCell class])] forIndexPath:indexPath];
            cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
            return cell;

        }
            break;
        case 1:{
            MATextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MATextFieldTableViewCell class])] forIndexPath:indexPath];
            cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
            cell.titleStr = self.titleArray[indexPath.row];
            cell.placeholderStr = @"请输入银行卡号";
            return cell;
            
        }
            break;
        case 2:{
            MATextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MATextFieldTableViewCell class])] forIndexPath:indexPath];
            cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
            cell.titleStr = self.titleArray[indexPath.row];
            cell.placeholderStr = @"请输入存入金额";
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
-(NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithObjects:@"银行",@"卡号",@"存入金额", nil];
    }
    return _titleArray;
}
-(UITableView *)table{
    if(!_table){
        _table = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _table.dataSource = self;
        _table.delegate = self;
        _table.tableFooterView = self.footView;
        [_table registerClass:[MAChooseTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([MAChooseTableViewCell class])]];
        [_table registerClass:[MATextFieldTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([MATextFieldTableViewCell class])]];
    }
    return _table;
}
-(UIView *)footView{
    if (!_footView) {
        _footView = [[UIView alloc] init];
    }
    return _footView;
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
