//
//  AutographViewController.h
//  RDFuturesApp
//
//  Created by user on 17/5/10.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "AccountBaseController.h"
#import <GLKit/GLKit.h>

@interface AutographViewController : UIViewController
@property(nonatomic,strong) void (^AutographBlock)(BOOL result);
@end
