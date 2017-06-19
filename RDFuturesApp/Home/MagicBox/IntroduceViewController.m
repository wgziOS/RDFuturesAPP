//
//  IntroduceViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/6/16.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "IntroduceViewController.h"
#import <WebKit/WebKit.h>
@interface IntroduceViewController ()
@property(nonatomic, strong)WKWebView * webView;
@end

@implementation IntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT-64)];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/companyProfile/detail.api?contentId=%@",HostUrlBak,self.contentId]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];

    _webView.contentScaleFactor = YES;
    [self.view addSubview:_webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
