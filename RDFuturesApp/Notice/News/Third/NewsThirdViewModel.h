//
//  NewsThirdViewModel.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/10.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BaseViewModel.h"

@interface NewsThirdViewModel : BaseViewModel

@property (nonatomic,strong)RACSubject *cellClick;//cell点击

@property(nonatomic,strong)RACSubject *refreshUI;

@property(nonatomic,strong)RACSubject *refreshEndSubject;//刷新结束

@property(nonatomic,strong)NSMutableArray * dataArray;//数据数组

@property (nonatomic,strong)RACCommand * refreshDataCommand;//刷新数据

@property (nonatomic,strong) RACCommand *nextPageCommand;//下一页
@end
