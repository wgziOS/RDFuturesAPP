//
//  RDRequest+Account.h
//  RDFuturesApp
//
//  Created by user on 17/3/23.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "RDRequest.h"

@interface RDRequest (Account)
+(RDRequestModel *)postOtherDataInfoWithParam:(NSDictionary*)data_dic
                                  error:(NSError* __autoreleasing*)error ;
+(RDRequestModel *)postPhotoConfirmInfoWithParam:(NSDictionary*)data_dic
                                         error:(NSError* __autoreleasing*)error;
@end
