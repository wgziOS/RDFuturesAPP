//
//  RDRequest+Home.m
//  RDFuturesApp
//
//  Created by user on 17/3/20.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "RDRequest+Home.h"

@implementation RDRequest (Home)
+(NSString *)getHomeDataWithParam:(NSDictionary*)data_dic
                            error:(NSError* __autoreleasing*)error andMessage:(NSString *)message{
    
    __block NSString *blockMessage=nil;
    __block NSError *blockError = nil;
    [[RDRequest request] GET:@"http://api.douban.com/v2/movie/nowplaying?app_name=doubanmovie&client=e:iPhone4,1%7Cy:iPhoneOS_6.1%7Cs:mobile%7Cf:doubanmovie_2%7Cv:3.3.1%7Cm:PP_market%7Cudid:aa1b815b8a4d1e961347304e74b9f9593d95e1c5&alt=json&city=%E5%8C%97%E4%BA%ACversion=2&apikey=0df993c66c0c636e29ecbb5344252a4a"
                  parameters:nil success:^(RDRequest *request, id response) {
                      NSLog(@"%@",response);
                      blockMessage = [NSString stringWithFormat:@"%@",[response objectForKey:@"title"]];
                  } failure:^(RDRequest *request, NSError *error) {
                      blockError = error;
                  }];
    if (blockMessage!=nil) {
        message = blockMessage;
    }
    if (blockError!=nil) {
        *error = blockError;
    }
    return nil;
}

+(NSString *)postTakePhotoWithParam:(NSDictionary*)data_dic
                             error:(NSError* __autoreleasing*)error andMessage:(NSString *)message{
    
    NSString *hostUrl = [NSString stringWithFormat:@"%@api/account/setIdCardImage.api",HostUrlBak];
//    [MBProgressHUD showMessage:@"" toView:self];
    __block NSString *blockMessage=nil;
    __block NSError *blockError = nil;
    [[RDRequest request] POST:hostUrl
                   parameters:data_dic
                      success:^(RDRequest *request, id response) {
                          
                          
                          blockMessage = [NSString stringWithFormat:@"%@",[response objectForKey:@"title"]];
                      }
                      failure:^(RDRequest *request, NSError *error) {
                          blockError = error;

                      }];
    if (blockMessage!=nil){
        
        message = blockMessage;
    }
    if (blockError!=nil) {
        *error = blockError;
    }
    return nil;
}
@end
