//
//  OtherInforViewController.m
//  RDFuturesApp
//
//  Created by user on 17/3/10.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "OtherInforViewController.h"
#import "OtherInforCell.h"
#import "OtherHeadView.h"
#import "OtherClickModel.h"

@interface OtherInforViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *headViewArray;//头部VIEW数组
@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic,strong)NSMutableArray *sectionModelArray;
@property (nonatomic,strong)NSArray *cellTitleArray;
@property (nonatomic,strong)NSArray *cellStyleArray;
@property (nonatomic,weak) IBOutlet UIButton *sumbit;
@end

@implementation OtherInforViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 7;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    CGSize size =  [self.superclass textForFont:14 andMAXSize:CGSizeMake(VIEW_WIDTH-60, 300) andText:self.titleArray[section]];
    CGFloat height  = size.height+20;
    if (height<=50) {
        height = 50.0;
    }
    OtherHeadView *headView = [[OtherHeadView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, height)];
    headView.title = self.titleArray[section];
    headView.tag = section;
    
    OtherClickModel  *sectionModel = self.sectionModelArray[section];
    BOOL  state = sectionModel.on_Off;
    headView.selectButton.selected = state;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(headViewClick:)];
    [headView addGestureRecognizer:tap];
    if (self.headViewArray.count<8) {
        [self.headViewArray addObject:headView];
    }
    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGSize size =  [self.superclass textForFont:15 andMAXSize:CGSizeMake(VIEW_WIDTH-60, 300) andText:self.titleArray[section]];
    CGFloat height  = size.height+20;
    if (height<=50) {
        height = 50.0;
    }
    return  height ;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    OtherClickModel  *sectionModel =self.sectionModelArray[section];
    
    return sectionModel.on_Off ? 0:sectionModel.cellStyleArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OtherInforFirstCell *cell1 = [tableView dequeueReusableCellWithIdentifier:kOtherInforFirstCell];

    OtherInforSecondCell *cell2 = [tableView dequeueReusableCellWithIdentifier:kOtherInforSecondCell];
    
    OtherInforThirdCell *cell3 = [tableView dequeueReusableCellWithIdentifier:kOtherInforThirdCell];
    
    OtherClickModel  *sectionModel = self.sectionModelArray[indexPath.section];
    OtherCellModel *cellModel = sectionModel.cellStyleArray[indexPath.row];
    NSLog(@"%@",cellModel.cellStyle);
    if ([cellModel.cellStyle isEqualToString:@"1"]) {
        
        return cell1;
        
    }else if([cellModel.cellStyle isEqualToString:@"2"]){
        cell2.title.text = cellModel.cellTitle;
        return cell2;

    }else {
        cell2.title.text = cellModel.cellTitle;
        return cell3;
    }
    
    return cell2;

}

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"本人是该证券账户的最终且唯一是的收益拥有人;",@"本人和瑞达(此处写公司全称)或其联营公司的董事或雇员没有任何关系;",@"本人不是联合交易所参与者或证监会的持牌人或注册人的董事、雇员或认可人士;",@"本人没有在(公司全称)开设，由本人或本人代表他人、团体公司益持有、拥有或运作、或本人拥有直接或间接利益的账户(无论个人、联名、公司、托管);",@"本人配偶没有在（公司全称）开立保证金账户;",@"本人或本人配偶没有共同控制（公司全称）的其他保证金账户的35%或以上的股权;",@"本人不是美国永久居民(绿卡持有人)。", nil ];
    }
    
    return _titleArray;
}

-(NSMutableArray *)sectionModelArray{
    if (!_sectionModelArray){
        _sectionModelArray = [[NSMutableArray alloc] init];
        for (int i=0; i<7; i++) {
            
            OtherClickModel  *sectionModel = [[OtherClickModel alloc] init];
            NSArray *titleArray = self.cellTitleArray[i];
            NSArray *styleArray = self.cellStyleArray[i];
            
            for(int b = 0 ;b < titleArray.count ; b++){
                OtherCellModel *cellModel = [[OtherCellModel alloc] init];
                cellModel.cellTitle = titleArray[b];
                cellModel.cellStyle = styleArray[b];
                [sectionModel.cellStyleArray addObject:cellModel];
            }
            sectionModel.on_Off = YES;
            if (i==0) {
                sectionModel.head_on_Off = NO;
            }
            [_sectionModelArray addObject:sectionModel];

        }
        
        
    }
    return _sectionModelArray;
}
-(NSArray *)cellTitleArray{
    if (!_cellTitleArray) {
        NSArray *groupNames = @[@[@"请填写最终及唯一受益拥有人资料",@"姓名",@"证件类型",@"证件号码",@"联系电话",@"联系地址"],@[@"关系人姓名",@"何种关系"],@[@"有关资料"],@[@"姓名",@"瑞达账号"],@[],@[],@[]];
        _cellTitleArray = groupNames;
    }
    return _cellTitleArray;
}
-(NSArray *)cellStyleArray{
    if (!_cellStyleArray) {
        NSArray *groupNames = @[@[@"1",@"2",@"3",@"2",@"2",@"2"],@[@"2",@"2"],@[@"2"],@[@"2",@"2"],@[],@[],@[]];
        _cellStyleArray = groupNames;
    }
    return _cellStyleArray;
}
-(void)headViewClick:(UITapGestureRecognizer*)tap{
    
    long index  = tap.view.tag;
    
    OtherHeadView *headView =(OtherHeadView *)tap.view;
    
    headView.selectButton.selected = !headView.selectButton.selected;
    OtherClickModel  *sectionModel = self.sectionModelArray[index];

    sectionModel.on_Off = headView.selectButton.selected;
   
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:index];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    for (int i = 0; i<self.headViewArray.count ; i++) {
        OtherHeadView *headView = self.headViewArray[index];

        if (!headView.selectButton.selected == NO) {
            headView.backgroundColor = [UIColor whiteColor];
        }else{
            headView.backgroundColor = [UIColor clearColor];
        }
    }
}
-(NSMutableArray *)headViewArray{
    if (!_headViewArray) {
        _headViewArray = [[NSMutableArray alloc] init];
    }
    return _headViewArray;
}
@end
