//
//  RDUserInformation.h
//  RDFuturesApp
//
//  Created by user on 17/3/24.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RDUserInformation : NSObject

+(RDUserInformation*)getInformation;

-(void)PostUserInformationDataWithUserId:(NSString *)userid andtoken:(NSString*)token;
-(NSMutableDictionary *)postDataDictionary:(BOOL)state;
@end

