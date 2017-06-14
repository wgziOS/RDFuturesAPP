//
//  NotificationModel.h
//  RDFuturesApp
//
//  Created by user on 2017/5/18.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationModel : NSObject
@property(nonatomic,copy)NSString *skip_type;
@property(nonatomic,copy)NSString *out_url;
@property(nonatomic,copy)NSString *inward_id;
@property(nonatomic,copy)NSString *msg_type;

@end
