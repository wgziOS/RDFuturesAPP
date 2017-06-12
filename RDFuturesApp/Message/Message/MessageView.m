


//
//  MessageView.m
//  RDFuturesApp
//
//  Created by user on 17/5/11.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "MessageView.h"
#import "MessageTableViewCell.h"
#import "MessageViewModel.h"




@interface MessageView()
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *modelArray;
@property(nonatomic,strong)MessageViewModel *viewModel;

@end


@implementation MessageView

-(void)setupViews{
    
    [self addSubview:self.tableView];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints{
    WS(weakself)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    [super updateConstraints];
}

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (MessageViewModel*)viewModel;
    return [super initWithViewModel:viewModel];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MessageTableViewCell class])] forIndexPath:indexPath];
    cell.model = self.modelArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.viewModel.cellClickSubject sendNext:nil];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(NSMutableArray *)modelArray{
    if (!_modelArray) {
        _modelArray = [[NSMutableArray alloc] init];
        MessageModel *model = [[MessageModel alloc] init];
        model.image = @"Message_online_service_icon";
        model.titleText = @"在线客服";
        model.subtitle = @"最新聊天记录";
        model.time = @"昨天";
        model.newNotice = NO;
        [_modelArray addObject:model];
        MessageModel *model1 = [[MessageModel alloc] init];
        model1.image = @"Message_RDNotice_icon";
        model1.titleText = @"瑞达通知";
        model1.subtitle = @"最新推送消息和标题";
        model1.time = @"16：00";
        model1.newNotice = YES;
        [_modelArray addObject:model1];
        
    }
    return _modelArray;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MessageTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([MessageTableViewCell class])]];
        
    }
    return _tableView;;
}
@end
