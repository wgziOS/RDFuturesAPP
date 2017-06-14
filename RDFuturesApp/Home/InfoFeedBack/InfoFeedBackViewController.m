//
//  InfoFeedBackViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/6/13.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "InfoFeedBackViewController.h"
#import <WebKit/WebKit.h>
@interface InfoFeedBackViewController ()
@property(nonatomic, strong)WKWebView * webView;
@end

@implementation InfoFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title= @"信息反馈";
    [self.view addSubview:self.webView];
}
-(WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT-64)];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://p.qiao.baidu.com/cps/chat?siteId=10801271&userId=23236096"]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
    }
    return _webView;
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
