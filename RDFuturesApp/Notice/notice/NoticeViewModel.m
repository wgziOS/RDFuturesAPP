//
//  NoticeViewModel.m
//  RDFuturesApp
//
//  Created by user on 17/4/11.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NoticeViewModel.h"

@implementation NoticeViewModel
-(void)initialize{
    @weakify(self)
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSMutableArray *array) {
        
        
        @strongify(self);
        self.dataArray = array;
        
        [self.refreshUI sendNext:nil];
        [self.refreshEndSubject sendNext:@(FooterRefresh_HasMoreData)];
        
    }];
   
    
    
}

-(RACCommand *)refreshDataCommand{
    
    if (!_refreshDataCommand) {
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error;
                    RDRequestModel * model = [RDRequest postHomeNoticeListWithParam:nil
                                                                              error:&error];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error==nil) {
                            
                            [subscriber sendNext:model.Data];
                            [subscriber sendCompleted];
                        }
                    });
                });
                
                
                
                return nil;
            }];
            
        }];
        
    }
    return _refreshDataCommand;
}


-(RACSubject *)refreshEndSubject{
    if (!_refreshEndSubject) {
        _refreshEndSubject = [RACSubject subject];
    }
    return _refreshEndSubject;
}


-(RACSubject *)refreshUI{
    if (!_refreshUI) {
        _refreshUI = [RACSubject subject];
    }
    return _refreshUI;
}

-(RACSubject *)cellclickSubject{
    if (!_cellclickSubject) {
        
        _cellclickSubject = [RACSubject subject];
    }
    return _cellclickSubject;
}

-(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

@end
