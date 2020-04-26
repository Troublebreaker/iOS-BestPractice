//
//  GTDetailViewController.m
//  SampleApp
//
//  Created by 曹亮 on 2020/3/3.
//  Copyright © 2020 曹亮. All rights reserved.
//

#import "GTDetailViewController.h"
#import <WebKit/WebKit.h>
#import "GTScreen.h"

@interface GTDetailViewController ()<WKNavigationDelegate>
@property(strong,nonatomic,readwrite) WKWebView *webView;
@property(strong,nonatomic,readwrite) UIProgressView *progressView;
@property(strong,nonatomic,readwrite) NSString *articleUrl;


@end

@implementation GTDetailViewController

- (instancetype)initWithUrlStr:(NSString *)urlStr
{
    self = [super init];
    if (self) {
        self.articleUrl = urlStr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:({
//        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 88, self.view.bounds.size.width, self.view.bounds.size.height- 88)];
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, STATUSBARHEIGHT + 44, self.view.bounds.size.width, self.view.bounds.size.height- STATUSBARHEIGHT - 44)];

        self.webView.navigationDelegate = self;
        self.webView;
    })];
    
    [self.view addSubview:({
//        self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, 20)];
        self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, STATUSBARHEIGHT +44, self.view.frame.size.width, 20)];
        self.progressView;
    })];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.articleUrl]]];

//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.articleUrl]]];
}


- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    // 业务逻辑
    [self.progressView setProgress:self.webView.estimatedProgress];
}

// 是否加载
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
}

@end
