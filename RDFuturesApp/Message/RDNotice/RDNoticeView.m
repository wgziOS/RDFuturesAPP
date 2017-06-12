



//
//  RDNoticeView.m
//  RDFuturesApp
//
//  Created by user on 2017/5/12.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "RDNoticeView.h"
#import "RDNoticeTableViewCell.h"
#import "RDNoticeModel.h"
#import "RDNoticeViewModel.h"

@interface RDNoticeView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)RDNoticeViewModel *viewModel;

@end

@implementation RDNoticeView

-(void)setupViews{
    [self addSubview:self.table];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints{
    
    WS(weakself)
    
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf);
        
    }];
    
    [super updateConstraints];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    return self.viewModel.dateArray.count;
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    RDNoticeModel *notice =self.viewModel.dateArray[indexPath.row];
    int height = 140;
    return height;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RDNoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([RDNoticeTableViewCell class])] forIndexPath:indexPath];
    
    return cell;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



-(UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_table registerClass:[RDNoticeTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([RDNoticeTableViewCell class])]];
    }
    return _table;
}
@end
