//
//  NoticeModel.h
//  RDFuturesApp
//
//  Created by user on 17/4/11.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoticeModel : NSObject
@property(nonatomic,copy)NSString *content_url;
@property(nonatomic,copy)NSString *create_time;
@property(nonatomic,copy)NSString *image;
@property(nonatomic,copy)NSString *log;
@property(nonatomic,copy)NSString *notice_id;
@property(nonatomic,copy)NSString *title;
@end
