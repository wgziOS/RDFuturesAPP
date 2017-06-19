//
//  ImportantNoticeView.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/6/16.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#define MyEditorWidth 300.0f
#define MyEditorHeight 420.0f
@interface ImportantNoticeView : UIView

@property(nonatomic,strong) void (^goonBlock)();


- (void)show;
- (void)showCachAccount;
@end
