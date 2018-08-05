//
//  PreviewController.m
//  OfficeManage
//
//  Created by Hsusue on 2018/8/5.
//  Copyright © 2018年 Hsusue. All rights reserved.
//

#import "PreviewController.h"

@interface PreviewController ()<UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;

@end

@implementation PreviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    _webView.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [_webView loadRequest:request];
    [_webView setScalesPageToFit:YES];
    [self.view addSubview:_webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
