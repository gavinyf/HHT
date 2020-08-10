//
//  CSWebViewController.m
//  ColorStar
//
//  Created by gavin on 2020/8/6.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSWebViewController.h"
#import <WebKit/WebKit.h>

@interface CSWebViewController ()

@property (nonatomic,strong)WKWebView  * webView;

@end

@implementation CSWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WKWebViewConfiguration *webConfiguration = [WKWebViewConfiguration new];
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:webConfiguration];
    NSString *urlStr = self.url;
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    self.webView.allowsBackForwardNavigationGestures = YES;
    [self.webView loadRequest:request];
    
}



@end
