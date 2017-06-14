//
//  AdvertisementImageView.m
//  RDFuturesApp
//
//  Created by user on 2017/5/21.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "AdvertisementImageView.h"

@interface AdvertisementImageView ()

@property (nonatomic ,strong) UIImageView *advertisingPageImageView;
@property (nonatomic ,strong) UIImageView *advertisingLogoImageView;

@end


@implementation AdvertisementImageView


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        
        [self addSubview:self.advertisingPageImageView];
        [self addSubview:self.advertisingLogoImageView];

    }
    return self;
}


- (void)setPageURLString:(NSString *)pageURLString {
    _pageURLString = pageURLString;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

#pragma mark --- 响应点击广告页的方法
- (void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    if (self.blockSelect) {
        self.blockSelect();
    }
}
-(UIImageView *)advertisingPageImageView{
    if (!_advertisingPageImageView) {
        _advertisingPageImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _advertisingPageImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [_advertisingPageImageView addGestureRecognizer:singleTap];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *state = [defaults objectForKey:@"Advertisement_logo"];
        if (state==nil) {
            [_advertisingPageImageView setImage:[UIImage imageNamed:@"Advertisement_backgroundImage"]];
        }else{
            [_advertisingPageImageView setImage:[self loadImage]];
        }
        
    }
    return _advertisingPageImageView;
}
-(UIImageView *)advertisingLogoImageView{
    if (!_advertisingLogoImageView) {
        _advertisingLogoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-(SCREEN_WIDTH-30)*0.1793-30, SCREEN_WIDTH, (SCREEN_WIDTH-30)*0.1793+30)];
        [_advertisingLogoImageView setBackgroundColor:[UIColor whiteColor]];
        _advertisingLogoImageView.contentMode = UIViewContentModeScaleAspectFill;
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, (SCREEN_WIDTH-30), (SCREEN_WIDTH-30)*0.1793)];
        [image setImage:[UIImage imageNamed:@"Advertisement_logo"]];
        [_advertisingLogoImageView addSubview:image];
    }
    return _advertisingLogoImageView;
}
- (UIImage*)loadImage
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      @"advertisement.png" ];
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    return image;
}
@end
