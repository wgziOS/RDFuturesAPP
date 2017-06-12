//
//  RDRequest.m
//  RDFuturesApp
//
//  Created by user on 17/3/20.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "RDRequest.h"


@implementation RDRequest


+ (instancetype)request {
    return [[self alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.operationManager = [AFHTTPSessionManager manager];
    }
    return self;
}


- (void)GET:(NSString *)URLString
 parameters:(NSDictionary*)parameters
    success:(void (^)(RDRequest * request, id response))success
    failure:(void (^)(RDRequest * request, NSError *error))failure {
    
    self.operationQueue=self.operationManager.operationQueue;
    self.operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [self.operationManager GET:URLString
                    parameters:parameters
                      progress:^(NSProgress * _Nonnull downloadProgress) {
                          
                      }
                       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                           id object = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
                           
                           NSLog(@" GET  请求成功 ");
                           success(self,object);
                       }
                       failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                           NSLog(@"[RDRequest]: 请求失败 %@",error.localizedDescription);
                           failure(self,error);
                       }
     ];

    
}

- (void)POST:(NSString *)URLString
  parameters:(NSDictionary*)parameters
     success:(void (^)(RDRequest *request, id response))success
     failure:(void (^)(RDRequest *request, NSError *error))failure{
    
    self.operationQueue = self.operationManager.operationQueue;
    self.operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [self.operationManager POST:URLString
                     parameters:parameters
                       progress:^(NSProgress * _Nonnull uploadProgress) {
                           
                       }
                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                            id object = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
                            
                            NSLog(@"[RDRequest]:POST 请求成功 %@",object);
                            success(self,object);
                        }
                        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                            NSLog(@"[RDRequest]: 请求失败 %@",error.localizedDescription);
                            failure(self,error);
                        }];
    
}

- (void)postWithURL:(NSString *)URLString parameters:(NSDictionary *)parameters {
    
    [self POST:URLString
    parameters:parameters
       success:^(RDRequest *request, id  response) {
           if ([self.delegate respondsToSelector:@selector(RDRequest:finished:)]) {
               [self.delegate RDRequest:request finished:response];
               
           }
       }
       failure:^(RDRequest *request, NSError *error) {
           if ([self.delegate respondsToSelector:@selector(RDRequest:Error:)]) {
               [self.delegate RDRequest:request Error:error.description];
           }
       }];
}

- (void)getWithURL:(NSString *)URLString {
    
    [self GET:URLString parameters:nil success:^(RDRequest *request, id response) {
        if ([self.delegate respondsToSelector:@selector(RDRequest:finished:)]) {
            [self.delegate RDRequest:request finished:response];
        }
    } failure:^(RDRequest *request, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(RDRequest:Error:)]) {
            [self.delegate RDRequest:request Error:error.description];
        }
    }];
}

- (void)cancelAllOperations{
    [self.operationQueue cancelAllOperations];
}

@end
