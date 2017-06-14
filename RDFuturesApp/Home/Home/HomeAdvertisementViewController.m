

//
//  HomeAdvertisementViewController.m
//  RDFuturesApp
//
//  Created by user on 2017/5/22.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "HomeAdvertisementViewController.h"

@interface HomeAdvertisementViewController()
@property(nonatomic,strong)WKWebView *webView;
@end

@implementation HomeAdvertisementViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self setTitle:self.titleName];
    [self.view addSubview:self.webView];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        _webView.backgroundColor = [UIColor whiteColor];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.web_url]];
//        ,
        // 3.创建Request
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        // 4.加载网页
        [_webView loadRequest:request];
    }
    return _webView;
}
@end
