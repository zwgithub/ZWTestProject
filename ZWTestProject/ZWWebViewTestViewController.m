//
//  ZWWebViewTestViewController.m
//  ZWTestProject
//
//  Created by shanWu on 16/4/19.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWWebViewTestViewController.h"
#import "WebViewJavascriptBridge_JS.h"

@interface ZWWebViewTestViewController () <UIWebViewDelegate>

@end

@implementation ZWWebViewTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    webView.delegate = self;
    [self.view addSubview:webView];
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://192.168.13.0/www/phpStudy/JS/interactWithNative.html"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark- UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"shouldStartLoadWithRequest");
    if ([request.URL.scheme isEqualToString:@"wvjbscheme"]) {
        NSLog(@"scheme:%@   host:%@",request.URL.scheme,request.URL.host);
//
        if ([[request.URL host] isEqualToString:@"__BRIDGE_LOADED__"]) {
            NSLog(@"开始执行本地的 JS 初始化代码");
            
            NSString *js = WebViewJavascriptBridge_js();
            NSString *str = [webView stringByEvaluatingJavaScriptFromString:js];
            NSLog(@"初始化后的返回值:%@",str);
        }
        
        
        return NO;
    }
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    NSLog(@"didFailLoadWithError:%@",error);
}

@end
