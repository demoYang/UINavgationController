//
//  SecondViewController.m
//  UINavgationController
//
//  Created by niexin on 12-10-29.
//  Copyright (c) 2012年 niexin. All rights reserved.
//

#import "WebViewViewController.h"

@interface WebViewViewController ()

@end

@implementation WebViewViewController

@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"webView";
    
    UIBarButtonItem* item1 = [[UIBarButtonItem alloc]initWithTitle:@"返回2" style:UIBarButtonItemStyleDone target:self action:@selector(backButtonPressed:)];//backBarButtonItem必须设置一个UIBarButtonItem才能修改标题，而且事件添加无效！
    self.navigationItem.backBarButtonItem = item1;
    //右键
    UIBarButtonItem* item2 = [[UIBarButtonItem alloc]initWithTitle:@"下一步"style:UIBarButtonItemStyleBordered target:self action:@selector(nextStep:)];
    self.navigationItem.rightBarButtonItem = item2;
    //ios 6.0 去除背景的阴影
    for (UIView *aView in [webView subviews]){
        if ([aView isKindOfClass:[UIScrollView class]]){
            for (UIView *shadowView in aView.subviews){
                if ([shadowView isKindOfClass:[UIImageView class]]){
                    shadowView.hidden = YES;  //上下滚动出边界时的黑色的图片 也就是拖拽后的上下阴影
                }
            }
        }
    }
    webView.backgroundColor = [UIColor grayColor];
    webView.delegate = self;
    
    NSArray* array = [[NSMutableArray alloc]initWithObjects:@"Gurmukhi MN",@"Malayalam Sangam MN",@"Bradley Hand",@"Kannada Sangam MN",@"Bodoni 72 Oldstyle",@"Cochin",@"Sinhala Sangam MN",@"Hiragino Kaku Gothic ProN",@"Papyrus",@"Verdana",@"Zapf Dingbats",@"Courier",@"Hoefler Text",@"Euphemia UCAS",@"Helvetica",@"Hiragino Mincho ProN",@"Bodoni Ornaments",@"Apple Color Emoji",@"Optima",@"Gujarati Sangam MN",@"Devanagari Sangam MN",@"Times New Roman",@"Kailasa",@"Telugu Sangam MN",@"Heiti SC",@"Futura",@"Bodoni 72",@"Baskerville",@"Chalkboard SE",@"Heiti TC",@"Copperplate",@"Bangla Sangam MN",@"Noteworthy",@"Zapfino",@"Tamil Sangam MN",@"DB LCD Temp",@"Arial Hebrew",@"Chalkduster",@"Georgia",@"Helvetica Neue",@"Gill Sans",@"Palatino",@"Courier New",@"Oriya Sangam MN",@"Didot",@"Bodoni 72 Smallcaps",@"Party LET",@"American Typewriter",@"AppleGothic", nil];
    NSInteger a = rand()%array.count;
    LOGINFO(@"%d",a );
    NSString* tempHTMLQuery = [NSString stringWithFormat:@"%@%@%@", @"<p style=\"font-size:14px;line-height:24px;font-family:",[array objectAtIndex:a],@"\">温馨提示：</br>1、如果您还不是华安基金客户，请先访问</br>&nbsp; &nbsp; &nbsp; www.huaan.com.cn自助开户。</br>2、华安基金客户可直接使用基金账号或开户</br>&nbsp; &nbsp; &nbsp; 证件号，输入查询密码登录。</br>3、如有任何疑问，请致电40088-50099。</p>"];
    NSString* tempHTMLTransaction = @"<p style=\"font-size:14px;line-height:24px;font-family:Arial\">温馨提示：</br>1、如果您还不是华安基金电子直销客户，请</br>&nbsp; &nbsp; &nbsp; 先访问www.huaan.com.cn自助开户。</br>2、华安基金电子直销客户可直接使用基金账</br>&nbsp; &nbsp; &nbsp; 号或开户证件号，输入交易密码登录。</br>3、如有任何疑问，请致电40088-50099。</p>";
    NSString* HTML = NO ? tempHTMLTransaction : tempHTMLQuery;
    [webView loadHTMLString:HTML baseURL:nil];
    
    
    
}

#pragma mark web view load https
-(BOOL)webView:(UIWebView *)awebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString* scheme = [[request URL] scheme];
    NSLog(@"scheme = %@",scheme);    //判断是不是https
    if ([scheme isEqualToString:@"HTTPS"]) {//如果是https:的话，那么就用NSURLConnection来重发请求。从而在请求的过程当中吧要请求的URL做信任处理。
//        if (!self.isAuthed) {
//            originRequest = request;
            NSURLConnection* conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];            [conn start];
            [awebView stopLoading];
            return NO;
//        }
    }
//    [self reflashButtonState];
//    [self freshLoadingView:YES];
//    NSURL *theUrl = [request URL];
//    self.currenURL = theUrl;
    return YES;
}

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
    if ([challenge previousFailureCount]== 0) {
//        _authed = YES;        //NSURLCredential 这个类是表示身份验证凭据不可变对象。凭证的实际类型声明的类的构造函数来确定。
        NSURLCredential* cre = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];        [challenge.sender useCredential:cre forAuthenticationChallenge:challenge];
    }else{
//    最后在NSURLConnection 代理方法中收到响应之后，再次使用web view加载https站点。
//    pragma mark ================= NSURLConnectionDataDelegate

    }
}
- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response{
    NSLog(@"%@",request);
    return request;
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
//    self.authed = YES;    //webview 重新加载请求。
//    [webView loadRequest:originRequest];
    [connection cancel];
}







-(void)nextStep:(id)sender{
    LastViewController* lastView = [[LastViewController alloc] initWithNibName:@"LastViewController" bundle:nil];
    
    [self.navigationController pushViewController:lastView animated:YES];

}

-(void)viewWillAppear:(BOOL)animated{
    LOGINFO(@"viewWillAppear");
}

-(void)viewDidAppear:(BOOL)animated{
    LOGINFO(@"viewDidAppear");
}

-(BOOL)shouldAutorotate{
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}




@end
