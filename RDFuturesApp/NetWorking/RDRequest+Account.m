//
//  RDRequest+Account.m
//  RDFuturesApp
//
//  Created by user on 17/3/23.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "RDRequest+Account.h"

@implementation RDRequest (Account)
//其他信息披露
+(RDRequestModel *)postOtherDataInfoWithParam:(NSDictionary*)data_dic
                                        error:(NSError* __autoreleasing*)error{
    
    NSString *hostUrl = [NSString stringWithFormat:@"%@/api/account/setOtherDataInfo.api",HostUrlBak];
    
    __block RDRequestModel *model=nil;
    __block NSError *blockError = nil;
    [[RDRequest request] POST:hostUrl
                   parameters:data_dic
                      success:^(RDRequest *request, id response) {
                          
                          model = [RDRequestModel mj_objectWithKeyValues:response];

                      }
                      failure:^(RDRequest *request, NSError *error) {
                          blockError = error;
                          
                      }];
    
    if (blockError!=nil) {
        *error = blockError;
    }
    return model;
    
}
//提交账户选择信息
+(RDRequestModel *)postAccountChooseInfoWithParam:(NSDictionary*)data_dic
                                            error:(NSError* __autoreleasing*)error{
    
    NSString *hostUrl = [NSString stringWithFormat:@"%@/api/account/setAccountChooseInfo.api.api",HostUrlBak];
    
    __block RDRequestModel *model=nil;
    __block NSError *blockError = nil;
    [[RDRequest request] POST:hostUrl
                   parameters:data_dic
                      success:^(RDRequest *request, id response) {
                          
                          
                          model = [RDRequestModel mj_objectWithKeyValues:response];
                          
                      }
                      failure:^(RDRequest *request, NSError *error) {
                          blockError = error;
                          
                      }];
    
    if (blockError!=nil) {
        *error = blockError;
    }
    return model;
    
}
//提交拍照确认信息
+(RDRequestModel *)postPhotoConfirmInfoWithParam:(NSDictionary*)data_dic
                                         error:(NSError* __autoreleasing*)error{
    
    
    
    NSString *hostUrl = [NSString stringWithFormat:@"%@/api/account/setPhotoConfirmInfo.api",HostUrlBak];
    __block RDRequestModel *model=nil;
    __block NSError *blockError = nil;
    [[RDRequest request] POST:hostUrl
                   parameters:data_dic
                      success:^(RDRequest *request, id response) {
                          
                          model = [RDRequestModel mj_objectWithKeyValues:response];
                      }
                      failure:^(RDRequest *request, NSError *error) {
                          blockError = error;
                          
                      }];
    
    if (blockError!=nil) {
        *error = blockError;
    }
    return model;
    
}
@end
