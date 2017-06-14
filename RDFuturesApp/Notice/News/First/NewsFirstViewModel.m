//
//  NewsFirstViewModel.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/20.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NewsFirstViewModel.h"
#import "NewsListModel.h"

@interface NewsFirstViewModel ()

@property (nonatomic, assign)NSInteger currentPage;

@end

@implementation NewsFirstViewModel

-(void)initialize{
    
    WS(weakself)
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSMutableArray *array) {
        
        if (weakSelf.dataArray.count!= 0) {
            [weakSelf.dataArray removeAllObjects];
        }
        NSLog(@"abcd=%@",array);
        
        for (NSDictionary *dic in array) {
            NewsListModel *model = [NewsListModel mj_objectWithKeyValues:dic];

            [weakSelf.dataArray addObject:model];
        }
        
        [self.refreshUI sendNext:nil];
        
        [self.refreshEndSubject sendNext:@(FooterRefresh_HasMoreData)];
        
        
    }];
    
    
    [self.nextPageCommand.executionSignals.switchToLatest subscribeNext:^(NSMutableArray *array) {
       
        for (NSDictionary *dic in array) {
            NewsListModel *model = [NewsListModel mj_objectWithKeyValues:dic];
            
            [weakSelf.dataArray addObject:model];
        }
        
        [self.refreshEndSubject sendNext:@(FooterRefresh_HasMoreData)];
        
    }];
    
}

-(NSInteger)currentPage
{
    if (!_currentPage) {
        _currentPage = 1;
    }
    return _currentPage;
}
-(RACCommand *)refreshDataCommand{

//    (109：要闻 102：股指 103：债券 104：外汇 105：贵金属
//     106：农产品 107：有色金属 108：能源化工)
    if (!_refreshDataCommand) {
        
        _refreshDataCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                //请求
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error;
                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    
                    [dic setObject:@"109" forKey:@"channelId"];
                    [dic setObject:@"1" forKey:@"page"];
                    
                    RDRequestModel * model = [RDRequest getNewsListWithApi:@"/api/news/list.api" andParam:dic error:&error];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error==nil) {
                            if ([model.State intValue]==1) {
                                    [subscriber sendNext:model.Data];
                            }else{
                                showMassage(model.Message)
                            }
                        }else{
                            [MBProgressHUD showError:promptString];
                        }
                        [subscriber sendCompleted];

                    });
                    
                    
                });
                
                return nil;
            }];
        }];
    }
    return _refreshDataCommand;
}


-(RACCommand *)nextPageCommand{

    if (!_nextPageCommand) {
        
        @weakify(self);
        _nextPageCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self);
                self.currentPage ++;
                
                //请求
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    
                    [dic setObject:@"109" forKey:@"channelId"];
                    [dic setObject:[NSString stringWithFormat:@"%ld",(long)self.currentPage] forKey:@"page"];
                    
                    
                    [RDRequest postNewsWithApi:@"/api/news/list.api" andParam:dic success:^(RDRequestModel *model) {
                        
                        if ([model.Data isKindOfClass:[NSArray class]]) {
                            NSArray * arr = model.Data;
                            if (arr.count==0) {
                                self.currentPage --;
                                showMassage(@"暂无数据")
                            }
                        }
                        
                        [subscriber sendNext:model.Data];
                        [subscriber sendCompleted];
                        
                    } failure:^(NSError *error) {
                        
                        @strongify(self);
                        self.currentPage --;
                        [subscriber sendCompleted];
                    }];
                    
                    
                });
                
                return nil;
            }];
        }];
    }
    return _nextPageCommand;
}

-(RACSubject *)cellClick{
    
    if (!_cellClick) {
        _cellClick = [[RACSubject alloc]init];
    }
    return _cellClick;
}

-(RACSubject *)refreshUI{
    
    if (!_refreshUI) {
        _refreshUI = [RACSubject subject];
    }
    return _refreshUI;
}

-(RACSubject *)refreshEndSubject{
    
    if (!_refreshEndSubject) {
        _refreshEndSubject = [RACSubject subject];
    }
    return _refreshEndSubject;
}

-(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}


@end
