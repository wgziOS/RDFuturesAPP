//
//  ViewBaseController.h
//  RDFuturesApp
//
//  Created by user on 17/2/28.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewBaseController : UIViewController
@property(nonatomic,copy)NSString *centerTitle;


- (void)hideTabbar:(BOOL)hidden;
- (UIView *)centerView;
-(void)gotoGoshopViewController;
-(void)gotoStoreViewController;
-(void)puchOpenfirst;
-(void)puchOtherInformation;
-(void)puchAccountChoose;
-(void)puchRiskWarning;
-(void)puchtakePhoto;
+(CGSize)textForFont:(int)font andMAXSize:(CGSize)size andText:(NSString*)text;
@end
