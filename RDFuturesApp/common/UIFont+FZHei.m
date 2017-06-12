//
//  UIFont+FZHei.m
//  RDFuturesApp
//
//  Created by user on 17/4/11.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "UIFont+FZHei.h"

@implementation UIFont (FZHei)

+(UIFont *)rdSystemFontOfSize:(CGFloat)fontSize{
    UIFont *font = [UIFont fontWithName:@"FZHei-B01S" size:fontSize];
    
    return font;
}
@end
