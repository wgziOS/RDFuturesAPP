//
//  CeShiViewController.m
//  RDFuturesApp
//
//  Created by user on 17/3/17.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "CeShiViewController.h"

@interface CeShiViewController ()
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation CeShiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.webView];\
    self.title = @"客服热线";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        NSURL *url = [NSURL URLWithString:@"http://p.qiao.baidu.com/cps/chat?siteId=10497801&userId=23236096"];
        // 3.创建Request
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        // 4.加载网页
        [_webView loadRequest:request];
    }
    return _webView;
}

@end
