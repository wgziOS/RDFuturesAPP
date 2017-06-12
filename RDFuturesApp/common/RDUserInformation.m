//
//  RDUserInformation.m
//  RDFuturesApp
//
//  Created by user on 17/3/24.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "RDUserInformation.h"

@implementation RDUserInformation

+(RDUserInformation*)getInformation{
    static RDUserInformation *userInfor;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        userInfor = [[RDUserInformation alloc] init];

    });
    
    return userInfor;
}

-(void)PostUserInformationDataWithUserId:(NSString *)userid andtoken:(NSString*)token{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:userid forKey:@"user_id"];
    [defaults setObject:token forKey:@"token"];
    
    
}
-(NSMutableDictionary *)getUserInformationData{
    NSMutableDictionary *infoDictionary = [[NSMutableDictionary alloc] init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    [infoDictionary setObject:[defaults objectForKey:@"user_id"] forKey:@"user_id"];
    [infoDictionary setObject:[defaults objectForKey:@"token"] forKey:@"token"];
    
    
    
    return infoDictionary;
}
-(NSMutableDictionary *)postDataDictionary:(BOOL)state{
    NSMutableDictionary *dic;
    if (state == YES) {
        dic = [self getUserInformationData];

    }
    NSMutableDictionary *infoDictionary = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    NSString *version_no = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    [infoDictionary setObject:version_no forKey:@"version_no"];
    
    NSString *app_Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [infoDictionary setObject:app_Version forKey:@"version"];
    
    NSString *uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    [infoDictionary setObject:uuid forKey:@"uuid"];
    [infoDictionary setObject:@"2" forKey:@"platform"];
    
    
    return infoDictionary;
}
@end
