//
//  URLRequestViewController.m
//  UINavgationController
//
//  Created by 张鑫 on 14-7-12.
//  Copyright (c) 2014年 niexin. All rights reserved.
//

#import "URLRequestViewController.h"

#import "Url.h"

@interface URLRequestViewController (){
    NSMutableData* receivedData;
    NSURLConnection *theConnection;
    
    BOOL finishLoad;
}

@end

@implementation URLRequestViewController

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
    // Do any additional setup after loading the view.
    
    
//    ASIFormDataRequest *requestForm = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    
    [self sendPostRequest];
    
//    LOGINFO(@"%@",[self sendRequestSync]);
    
//    [self uploadImages];
    
    
    
    
    //线程堵塞
    finishLoad = NO;
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
    
    while (!finishLoad) {
        for (NSString *mode in (__bridge NSArray *)allModes) {
            CFRunLoopRunInMode((__bridge CFStringRef)mode, 0.001, false);
        }
    }
    
    LOGINFO(@"%@",@"sdjhfksajdhfsakjghaksjfhaskdjhfaskjdghaskjdhf");
    
}

// 同步发送
- (NSString *)sendRequestSync
{
    NSData* content = [NSData data];
    
    // 初始化请求, 这里是变长的, 方便扩展
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    // 设置
    [request setURL:[NSURL URLWithString:API_GetDoctorControl]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"host" forHTTPHeaderField:@"Host"];
    NSString* dataLength = [NSString stringWithFormat:@"%d",content.length];
    [request setValue:dataLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:content];
    
    // 发送同步请求, data就是返回的数据
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (data == nil) {
        LOGINFO(@"send request failed: %@", error);
        return nil;
    }
    
    NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    LOGINFO(@"response: %@", response);
    return response;
    
    
    
    
    
}

#pragma mark 设置post request

-(void)sendPostRequest:(NSURL*)url withBody:(NSDictionary*)reqDict imageDict:(NSDictionary*)imageDict{
    
    /*
     --AaB03x
     Content-Disposition: form-data; name="args"
     
     {"servicecode":"IDoctorService_update","plant":"IOS","data":{"export":[],"doctor":{"qualificationCertificate":"","city":"37","countries":"567","isValid":"0","docAccount":"","sex":"1","docTitle":"0","docName":"zhangxin","province":"1","birthday":"1988-07-09","docRoomid":"1","docDescription":"Asdasdfasdf","docEmail":"123456@126.com","cerCode":"3212548965578524","createBy":"","docHospitalid":"1","cerType":"0","headSculpture":""}}}
     --AaB03x
     Content-Disposition: form-data; name="headFile"; filename="pic0.jpg"
     Content-Type: image/jpeg
     
     imageasdfasdf
     --AaB03x
     Content-Disposition: form-data; name="cerFile"; filename="pic1.jpg"
     Content-Type: image/jpeg
     
     imageasdfasdf
     --AaB03x--
     */
    
    //分界线的标识符
    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    
    NSError* error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:reqDict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *reqstring = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    //添加分界线，换行
    [myRequestData appendData:[[NSString stringWithFormat:@"%@\r\n",MPboundary] dataUsingEncoding:NSUTF8StringEncoding]];
    //添加字段名称，换2行
    [myRequestData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"args"] dataUsingEncoding:NSUTF8StringEncoding]];
    //添加字段的值
    [myRequestData appendData:[[NSString stringWithFormat:@"%@", reqstring] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //参数的集合的所有key的集合
    NSArray *keys= [imageDict allKeys];
    //遍历keys
    for(int i = 0; i < [keys count]; i++)
    {
        //得到当前key
        NSString *key = [keys objectAtIndex:i];
        //如果key不是pic，说明value是字符类型，比如name：Boris
        ////添加分界线，换行
        [myRequestData appendData:[[NSString stringWithFormat:@"\r\n%@\r\n",MPboundary] dataUsingEncoding:NSUTF8StringEncoding]];
        //声明pic字段，文件名为boris.png
        [myRequestData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@.jpg\"\r\n",key,[NSString stringWithFormat:@"pic%d", i]] dataUsingEncoding:NSUTF8StringEncoding]];
        //声明上传文件的格式
        [myRequestData appendData:[[NSString stringWithFormat:@"Content-Type: image/jpeg\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        //将image的data加入
//        [myRequestData appendData:[imageDict objectForKey:key]];
        [myRequestData appendData:[[NSString stringWithFormat:@"imageasdfasdf"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@\r\n",endMPboundary];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    LOGINFO(@"%@",[[NSString alloc]initWithData:myRequestData encoding:NSUTF8StringEncoding]);

    //根据url初始化request
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; charset=utf-8; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:myRequestData];
    [request setHTTPMethod:@"POST"];
    //建立连接，设置代理
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    //设置接受response的data
    if (conn) {
        receivedData = [NSMutableData data];
    }
}

-(void)sendPostRequest{
    // In body data for the 'application/x-www-form-urlencoded' content type,
    // form fields are separated by an ampersand. Note the absence of a
    // leading ampersand.

    
    NSError* error = nil;
    NSMutableDictionary* sendDict = [[NSMutableDictionary alloc]init];
    [sendDict setValue:@"liginsdfas" forKey:@"servicecode"];
    [sendDict setValue:@"IOS" forKey:@"plant"];
    NSMutableDictionary* userDict = [[NSMutableDictionary alloc]init];
    [userDict setObject:@"13841161610" forKey:@"usercode"];
    [userDict setObject:@"123456" forKey:@"password"];
    [userDict setObject:@"1" forKey:@"type"];
    NSMutableDictionary* dataDict = [[NSMutableDictionary alloc]init];
    [dataDict setValue:userDict forKey:@"user"];
    [sendDict setObject:dataDict forKey:@"data"];
    //字典转data
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:sendDict options:NSJSONWritingPrettyPrinted error:&error];
    if ([jsonData length] > 0 && error == nil){
        LOGINFO(@"Successfully serialized the dictionary into data. %@",jsonData);
        //NSData转换为String
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        LOGINFO(@"JSON String = %@", jsonString);
    }
    else if ([jsonData length] == 0 && error == nil){
        LOGINFO(@"No data was returned after serialization.");
    }
    else if (error != nil){
        LOGINFO(@"An error happened = %@", error);
    }
    
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:API_GetControl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    // Set the request's content type to application/x-www-form-urlencoded，text/xml，application/javascript或application/json,application/x-plist
    [postRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // Designate the request a POST request and specify its body data
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setHTTPBody:jsonData];
    
    // Initialize the NSURLConnection and proceed as described in
    // Retrieving the Contents of a URL
    receivedData = [NSMutableData dataWithCapacity: 0];
    theConnection=[[NSURLConnection alloc] initWithRequest:postRequest delegate:self];
    if (!theConnection) {
        // Release the receivedData object.
        receivedData = nil;
        
        // Inform the user that the connection failed.
    }
}

#pragma mark 普通的request
-(void)test{//简单的req
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.apple.com/"]
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:60.0];
    
    // Create the NSMutableData to hold the received data.
    // receivedData is an instance variable declared elsewhere.
    receivedData = [NSMutableData dataWithCapacity: 0];
    
    // create the connection with the request
    // and start loading the data
    theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (!theConnection) {
        // Release the receivedData object.
        receivedData = nil;
        
        // Inform the user that the connection failed.
    }
}

#pragma mark 普通的connection delegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse object.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    // receivedData is an instance variable declared elsewhere.
    
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // Release the connection and the data object
    // by setting the properties (declared elsewhere)
    // to nil.  Note that a real-world app usually
    // requires the delegate to manage more than one
    // connection at a time, so these lines would
    // typically be replaced by code to iterate through
    // whatever data structures you are using.
    theConnection = nil;
    receivedData = nil;
    
    // inform the user
    LOGINFO(@"Connection failed! Error - %@ %@",
    [error localizedDescription],
    [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a property elsewhere
    finishLoad = YES;
    NSError* error;//data转dict
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingAllowFragments error:&error];


    LOGINFO(@"Succeeded! Received %d bytes of data %@", [receivedData length], json);
    LOGINFO(@"message %@",[json objectForKey:@"message"]);
    
    // Release the connection and the data object
    // by setting the properties (declared elsewhere)
    // to nil.  Note that a real-world app usually
    // requires the delegate to manage more than one
    // connection at a time, so these lines would
    // typically be replaced by code to iterate through
    // whatever data structures you are using.
    theConnection = nil;
    receivedData = nil;
}
//下面两段是重点，要服务器端单项HTTPS 验证，iOS 客户端忽略证书验证。最后一个是官方的API， 按理说这个应该放到最前面，因为是官方的嘛，但是实际上我一次都没有试成功过，所以有点怀疑他的真实性，不过也许有人成功了，所以也拿上来讨论一下。
//简单来说通过NSurlconnection的这两个委托方法来忽略认证，关于Certificate Authentication是有官方文档的，但是官方文档太长了，我没有心思看完，所以还没有深入研究下去。
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
    
    
    LOGINFO(@"protectionSpace: %@", [protectionSpace authenticationMethod]);
    
    // We only know how to handle NTLM authentication.
    if([[protectionSpace authenticationMethod] isEqualToString:NSURLAuthenticationMethodNTLM])
        return YES;
    
    // Explicitly reject ServerTrust. This is occasionally sent by IIS.
    if([[protectionSpace authenticationMethod] isEqualToString:NSURLAuthenticationMethodServerTrust])
        return NO;
    
    return NO;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    
    LOGINFO(@"didReceiveAuthenticationChallenge %@ %zd", [[challenge protectionSpace] authenticationMethod], (ssize_t) [challenge previousFailureCount]);
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]){
        
        [[challenge sender]  useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        
    }
    [[challenge sender] continueWithoutCredentialForAuthenticationChallenge:challenge];
    [[challenge sender] continueWithoutCredentialForAuthenticationChallenge:challenge];
}

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    [[challenge sender] useCredential:[NSURLCredential credentialWithUser:@"user" password:@"password" persistence:NSURLCredentialPersistencePermanent] forAuthenticationChallenge:challenge];
    
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
