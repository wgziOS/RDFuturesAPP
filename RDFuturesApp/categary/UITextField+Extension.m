//
//  UITextField+Extension.m
//  RDFuturesApp
//
//  Created by user on 17/5/9.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)
-(void)setPlaceholderString:(NSString *)placeholder{
    self.placeholder = placeholder;
    UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(10,0,10,26)];
    leftView.backgroundColor = [UIColor clearColor];
    self.leftView = leftView;

}
@end
