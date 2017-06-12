//
//  NoticeView.m
//  RDFuturesApp
//
//  Created by user on 17/4/11.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NoticeView.h"
#import "NoticeViewModel.h"
#import "NoticeTableCell.h"
#import "NoticeModel.h"
@interface NoticeView()
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NoticeViewModel *noticeViewModel;
@end

@implementation NoticeView
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
}
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel andFrame:(CGRect)frame{
    
    self.noticeViewModel = (NoticeViewModel *)viewModel;
    
    return [super initWithViewModel:viewModel andFrame:frame];
    
}
-(void)setupViews{
    [self addSubview:self.tableView];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NoticeTableCell * cell = [tableView dequeueReusableCellWithIdentifier:@""];
    if (self.noticeViewModel.dataArray.count>indexPath.row){
        NoticeModel *model = self.noticeViewModel.dataArray[indexPath.row];
        cell.model = model;
    }
    cell.separatorInset =UIEdgeInsetsMake(0, 0, 0, 0);
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (section==0) {
        return 0;
    }else{
        return self.noticeViewModel.dataArray.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 260;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.noticeViewModel.cellclickSubject sendNext:nil];
}
-(void)bindViewModel{
    @weakify(self);
    [self.noticeViewModel.refreshScrollDataCommand execute:nil];
    [self.noticeViewModel.refreshDataCommand execute:nil];
    [self.noticeViewModel.refreshUI subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
   
    
    [self.noticeViewModel.refreshEndSubject subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
        switch ([x integerValue]) {
            case HeaderRefresh_HasMoreData:
                [self.tableView.mj_header endRefreshing];
                
                if (!self.tableView.mj_footer) {
                    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                        @strongify(self)
                        
                        [self.noticeViewModel.refreshDataCommand execute:nil];
                        [self.noticeViewModel.refreshScrollDataCommand execute:nil];
                        
                    }];
                }
                
                break;
                
                
            case HeaderRefresh_HasNoMoreData:
                [self.tableView.mj_header endRefreshing];
                self.tableView.mj_footer = nil;
                
                break;
                
            case FooterRefresh_HasMoreData:
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer resetNoMoreData];
                [self.tableView.mj_footer endRefreshing];
                
                break;
                
            case FooterRefresh_HasNoMoreData:
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                
                
                break;
            case RefreshError:
                [self.tableView.mj_footer endRefreshing];
                [self.tableView.mj_header endRefreshing];
                break;
                
            default:
                break;
        }
    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)updateConstraints{
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self);
    }];
    
    [super updateConstraints];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        @weakify(self)
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self)
            [self.noticeViewModel.refreshDataCommand execute:nil];
        }];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self.noticeViewModel.refreshDataCommand execute:nil];
        }];
    }
    return _tableView;
}
@end
