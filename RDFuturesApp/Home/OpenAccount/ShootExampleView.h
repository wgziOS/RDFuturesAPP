//
//  ShootExampleView.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/3/3.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#define MyEditorWidth 300.0f
#define MyEditorHeight 420.0f
@interface ShootExampleView : UIView
{
    
}

@property (nonatomic, strong) UILabel * title;
@property (nonatomic, strong) UILabel * subTitle;
@property (nonatomic, strong) UIView  * backImageView;

@property(nonatomic,strong) void (^goonBlock)();

-(id)initViewTitleImgString:(NSString *)titleImgString TitleString:(NSString *)titleString SubTitleString:(NSString *)subTitleString BtnImgString:(NSString *)btnImgString;

- (void)show;
-(id)initViewTitleImgString:(NSString *)title cachString:(NSString *)cach financingString:(NSString *)financing;
- (void)showCachAccount;

@end
