//
//  RDUserInformation.h
//  RDFuturesApp
//
//  Created by user on 17/3/24.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RDUserInformation : NSObject
@property(nonatomic,copy)NSString *messageState;//消息状态
+(RDUserInformation*)getInformation;
@property(nonatomic,assign)BOOL advertisementClick;
-(BOOL)getLoginState;//获取登录状态
-(void)PostUserInformationDataWithUserId:(NSString *)userid andtoken:(NSString*)token andPhoneNumber:(NSString *)phoneNumber;


-(NSMutableDictionary *)postDataDictionary:(BOOL)state;
+ (NSString *)transString:(NSString *)string;
+ (NSString *)transBase64WithImage:(UIImage *)image;
-(void)cleanUserInfo;
@end

