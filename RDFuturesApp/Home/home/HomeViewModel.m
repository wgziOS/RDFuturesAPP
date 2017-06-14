//
//  HomeViewModel.m
//  RDFuturesApp
//
//  Created by user on 17/3/1.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "HomeViewModel.h"
#import "HomeScrollModel.h"
#import "HomeModel.h"

@implementation HomeViewModel

-(void)initialize{
    WS(weakself)
    [self.refreshScrollDataCommand.executionSignals.switchToLatest subscribeNext:^(NSMutableArray *array) {
        
        if (array==nil) {
            [self.refreshUI sendNext:nil];
            return ;
        }
        if (weakSelf.dataArray.count!= 0) {
            [weakSelf.dataArray removeAllObjects];
        }
        
        
        for (NSDictionary *dic in array) {
            HomeScrollModel *model = [HomeScrollModel mj_objectWithKeyValues:dic];
            [weakSelf.dataArray addObject:model];
        }
        
        [self.refreshUI sendNext:nil];
        

    }];
    
    
    [self.refreshAccountCommand.executionSignals.switchToLatest subscribeNext:^(NSString * x) {
        
        [self.accountSubject sendNext:x];
    }];
    
}
-(RACCommand *)refreshAccountCommand{

    if (!_refreshAccountCommand) {
        
        _refreshAccountCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {

                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error ;
                    
                    RDRequestModel * model = [RDRequest getWithApi:@"/api/account/getQueryAccount.api" andParam:nil error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if ([model.State intValue]==1) {
                            NSString * str = [NSString stringWithFormat:@"%@",model.Data[@"speed_status"]];
                            [subscriber sendNext:str];
                        }else{
                            [subscriber sendNext:nil];
                            
                        }
                        [subscriber sendCompleted];
                        
                    });
                    
                });
                
                return nil;
            }];
            
        }];
        
        
    }
    return _refreshAccountCommand;
}
-(RACCommand *)refreshScrollDataCommand{
    
    if (!_refreshDataCommand) {
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error;
                    RDRequestModel * model = [RDRequest postAdvListWithParam:nil
                                                                       error:&error];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error==nil) {
                            if ([model.State intValue]==1) {
                                
                                [subscriber sendNext:model.Data];
                            }else{
                                [subscriber sendNext:nil];
                                
                            }
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


-(RACSubject *)accountSubject{
    
    if (!_accountSubject) {
        _accountSubject = [RACSubject subject];
    }
    return _accountSubject;
}

-(RACSubject *)refreshUI{
    if (!_refreshUI) {
        _refreshUI = [RACSubject subject];
    }
    return _refreshUI;
}

-(RACSubject *)cellClickSubject{
    if (!_cellClickSubject) {
        
        _cellClickSubject = [RACSubject subject];
    }
    return _cellClickSubject;
}
-(RACSubject *)itemclickSubject{
    if (!_itemclickSubject) {
        
        _itemclickSubject = [RACSubject subject];
    }
    return _itemclickSubject;
}
-(RACSubject *)imageclickSubject{
    if (!_imageclickSubject) {
        
        _imageclickSubject = [RACSubject subject];
    }
    return _imageclickSubject;
}
-(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

@end
