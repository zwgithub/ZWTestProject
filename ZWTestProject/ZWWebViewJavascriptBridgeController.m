//
//  ZWWebViewJavascriptBridgeController.m
//  ZWTestProject
//
//  Created by shanWu on 16/4/19.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import "ZWWebViewJavascriptBridgeController.h"
#import "WebViewJavascriptBridge.h"
#import "ZWWebViewTestViewController.h"

@interface ZWWebViewJavascriptBridgeController ()

@property WebViewJavascriptBridge *bridge;

@end

@implementation ZWWebViewJavascriptBridgeController

- (void)viewWillAppear:(BOOL)animated {
    if (_bridge) {
        return;
    }
    
    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 60)];
    [self.view addSubview:webView];
    
    [WebViewJavascriptBridge enableLogging];
    
    _bridge = [WebViewJavascriptBridge bridgeForWebView:webView];
    
    [_bridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"testObjcCallback called: %@", data);
        responseCallback(@{ @"name":@"OC回调给js的参数" });
    }];
    
    [self renderButtons:webView];
    [self loadExamplePage:webView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createRightItem];
}

- (void)createRightItem {
    UIButton *rightItemButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
    [rightItemButton addTarget:self action:@selector(rightItemButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [rightItemButton setTitle:@"测试" forState:UIControlStateNormal];
    [rightItemButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItemButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)rightItemButtonAction {
    ZWWebViewTestViewController *ctl = [[ZWWebViewTestViewController alloc] init];
    [self.navigationController pushViewController:ctl animated:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad");
}

- (void)renderButtons:(UIWebView*)webView {
    UIFont* font = [UIFont fontWithName:@"HelveticaNeue" size:12.0];
    
    UIButton *callbackButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    callbackButton.backgroundColor = [UIColor purpleColor];
    [callbackButton setTitle:@"OC 调用 JS 代码" forState:UIControlStateNormal];
    [callbackButton addTarget:self action:@selector(callHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:callbackButton];

    callbackButton.frame = CGRectMake(0, self.view.height - 60, self.view.width, 60);
    callbackButton.titleLabel.font = font;
}

- (void)callHandler:(id)sender {
    //开始调用 JS 代码
    id data = @{ @"greetingDataFromObjC": @"Hi there, JS!" };
    [_bridge callHandler:@"testJavascriptHandler" data:data responseCallback:^(id response) {
        NSLog(@"testJavascriptHandler responded: %@", response);
    }];
}

- (void)loadExamplePage:(UIWebView*)webView {
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"ExampleApp" ofType:@"html"];
    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    [webView loadHTMLString:appHtml baseURL:baseURL];
}


@end
