//
//  SecondViewController.h
//  UINavgationController
//
//  Created by niexin on 12-10-29.
//  Copyright (c) 2012年 niexin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransformViewController.h"
#import "BaseViewController.h"

@interface WebViewViewController : BaseViewController<UIWebViewDelegate>{
    UIWebView* webView;
}

@property(strong ,nonatomic) IBOutlet UIWebView* webView;
@end
