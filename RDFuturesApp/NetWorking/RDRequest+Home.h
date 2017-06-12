//
//  RDRequest+Home.h
//  RDFuturesApp
//
//  Created by user on 17/3/20.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "RDRequest.h"

@interface RDRequest (Home)

+(NSString *)postTakePhotoWithParam:(NSDictionary*)data_dic
                              error:(NSError* __autoreleasing*)error andMessage:(NSString *)message ;


+(NSString *)getHomeDataWithParam:(NSDictionary*)data_dic
                            error:(NSError* __autoreleasing*)error andMessage:(NSString *)message;



@end
