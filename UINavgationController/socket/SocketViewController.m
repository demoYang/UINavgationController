//
//  SocketViewController.m
//  UINavgationController
//
//  Created by 张鑫 on 14-9-15.
//  Copyright (c) 2014年 niexin. All rights reserved.
//

#import "SocketViewController.h"

@interface SocketViewController (){
    CFSocketRef _socket;
}

@end

@implementation SocketViewController

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
}

#pragma mark 客户端

-(void)initClientSocket{
    NSString* strAddress = @"";
    
    CFSocketContext sockContext = {0, // 结构体的版本，必须为0
        (__bridge void *)(self),  // 一个任意指针的数据，可以用在创建时CFSocket对象相关联。这个指针被传递给所有的上下文中定义的回调。
        NULL, // 一个定义在上面指针中的retain的回调， 可以为NULL
        NULL, NULL};
    
    _socket = CFSocketCreate(kCFAllocatorDefault, // 为新对象分配内存，可以为nil
                             PF_INET, // 协议族，如果为0或者负数，则默认为PF_INET
                             SOCK_STREAM, // 套接字类型，如果协议族为PF_INET,则它会默认为SOCK_STREAM
                             IPPROTO_TCP, // 套接字协议，如果协议族是PF_INET且协议是0或者负数，它会默认为IPPROTO_TCP
                             kCFSocketConnectCallBack, // 触发回调函数的socket消息类型，具体见Callback Types
                             TCPServerConnectCallBack, // 上面情况下触发的回调函数
                             &sockContext // 一个持有CFSocket结构信息的对象，可以为nil
                             );
    
    if (_socket != nil) {
        struct sockaddr_in addr4;   // IPV4
        memset(&addr4, 0, sizeof(addr4));
        addr4.sin_len = sizeof(addr4);
        addr4.sin_family = AF_INET;
        addr4.sin_port = htons(8888);
        addr4.sin_addr.s_addr = inet_addr([strAddress UTF8String]);  // 把字符串的地址转换为机器可识别的网络地址
        
        // 把sockaddr_in结构体中的地址转换为Data
        CFDataRef address = CFDataCreate(kCFAllocatorDefault, (UInt8 *)&addr4, sizeof(addr4));
        CFSocketConnectToAddress(_socket, // 连接的socket
                                 address, // CFDataRef类型的包含上面socket的远程地址的对象
                                 -1  // 连接超时时间，如果为负，则不尝试连接，而是把连接放在后台进行，如果_socket消息类型为kCFSocketConnectCallBack，将会在连接成功或失败的时候在后台触发回调函数
                                 );
        
        CFRunLoopRef cRunRef = CFRunLoopGetCurrent();    // 获取当前线程的循环
        // 创建一个循环，但并没有真正加如到循环中，需要调用CFRunLoopAddSource
        CFRunLoopSourceRef sourceRef = CFSocketCreateRunLoopSource(kCFAllocatorDefault, _socket, 0);
        CFRunLoopAddSource(cRunRef, // 运行循环
                           sourceRef,  // 增加的运行循环源, 它会被retain一次
                           kCFRunLoopCommonModes  // 增加的运行循环源的模式
                           );
        CFRelease(sourceRef);
    }
}

// socket回调函数的格式：
static void TCPServerConnectCallBack(CFSocketRef socket, CFSocketCallBackType type, CFDataRef address, const void *data, void *info) {
    
    if (data != NULL) {
        // 当socket为kCFSocketConnectCallBack时，失败时回调失败会返回一个错误代码指针，其他情况返回NULL
        NSLog(@"连接失败");
        return;
    }
//    TCPClient *client = (TCPClient *)info;
    // 读取接收的数据,（TCPClient 是自己的类，就是初始化是设置的self）
//    [info performSlectorInBackground:@selector(readStream) withObject:nil];
    
}

// 读取接收的数据
- (void)readStream {
    char buffer[1024];
//    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    @autoreleasepool {
        while (recv(CFSocketGetNative(_socket), //与本机关联的Socket 如果已经失效返回－1:INVALID_SOCKET
                    buffer, sizeof(buffer), 0)) {
            NSLog(@"%@", [NSString stringWithUTF8String:buffer]);
        }
    }
}

// 发送数据
- (void)sendMessage {
    NSString *stringTosend = @"你好";
    char *data = (char*)[stringTosend UTF8String];
    send(CFSocketGetNative(_socket), data, strlen(data) + 1, 0);
//    send(SFSocketGetNative(_socket), data, strlen(data) + 1, 0);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 服务器端
static CFWriteStreamRef outputStream = NULL;

// 开辟一个线程线程函数中
-(void)runLoopInThread {
    int res = [self initSocketService];
    if (!res) {
        exit(1);
    }
    CFRunLoopRun();    // 运行当前线程的CFRunLoop对象
}

-(int)initSocketService{

    _socket = CFSocketCreate(kCFAllocatorDefault, PF_INET, SOCK_STREAM,IPPROTO_TCP, kCFSocketAcceptCallBack, TCPServerAcceptCallBack, NULL);
    if (NULL == _socket) {
        NSLog(@"Cannot create socket!");
        return 0;
    }
    
    int optval = 1;
    setsockopt(CFSocketGetNative(_socket), SOL_SOCKET, SO_REUSEADDR, // 允许重用本地地址和端口
               (void *)&optval, sizeof(optval));
    
    struct sockaddr_in addr4;
    memset(&addr4, 0, sizeof(addr4));
    addr4.sin_len = sizeof(addr4);
    addr4.sin_family = AF_INET;
    addr4.sin_port = htons(8888);
    addr4.sin_addr.s_addr = htonl(INADDR_ANY);
    CFDataRef address = CFDataCreate(kCFAllocatorDefault, (UInt8*)&addr4, sizeof(addr4));
    
    if (kCFSocketSuccess != CFSocketSetAddress(_socket, address)) {
        NSLog(@"Bind to address failed!");
        if (_socket)
            CFRelease(_socket);
        _socket = NULL;
        return 0;
    }
    
    CFRunLoopRef cfRunLoop = CFRunLoopGetCurrent();
    CFRunLoopSourceRef source = CFSocketCreateRunLoopSource(kCFAllocatorDefault,_socket, 0);
    CFRunLoopAddSource(cfRunLoop, source, kCFRunLoopCommonModes);
    CFRelease(source);
    
    return 1;
}
// socket回调函数，同客户端
void TCPServerAcceptCallBack(CFSocketRef socket, CFSocketCallBackType type, CFDataRef address, const void *data, void*info) {
    if (kCFSocketAcceptCallBack == type) {
        // 本地套接字句柄
        CFSocketNativeHandle nativeSocketHandle = *(CFSocketNativeHandle *)data;
        uint8_t name[SOCK_MAXADDRLEN];
        socklen_t nameLen = sizeof(name);
        if (0 != getpeername(nativeSocketHandle, (struct sockaddr *)name,&nameLen)) {
            NSLog(@"error");
            exit(1);
        }
        NSLog(@"%s connected.", inet_ntoa( ((struct sockaddr_in*)name)->sin_addr ));
        CFReadStreamRef iStream;
        CFWriteStreamRef oStream;
        // 创建一个可读写的socket连接
        CFStreamCreatePairWithSocket(kCFAllocatorDefault,nativeSocketHandle, &iStream, &oStream);
        if (iStream && oStream) {
            CFStreamClientContext streamContext = {0, NULL, NULL, NULL};
            if (!CFReadStreamSetClient(iStream, kCFStreamEventHasBytesAvailable,
                                       readStream, // 回调函数，当有可读的数据时调用
                                       &streamContext)){
                exit(1);
            }

            if (!CFWriteStreamSetClient(oStream, kCFStreamEventCanAcceptBytes, writeStream, &streamContext)){
                exit(1);
            }
            CFReadStreamScheduleWithRunLoop(iStream, CFRunLoopGetCurrent(),kCFRunLoopCommonModes);
            CFWriteStreamScheduleWithRunLoop(oStream, CFRunLoopGetCurrent(),kCFRunLoopCommonModes);
            CFReadStreamOpen(iStream);
            CFWriteStreamOpen(oStream);
        } else {
            close(nativeSocketHandle);
        }
    }
}
// 读取数据
void readStream(CFReadStreamRef stream,CFStreamEventType eventType, void *clientCallBackInfo) {
    UInt8 buff[255];
    CFReadStreamRead(stream, buff, 255);
    printf("received: %s", buff);
}

void writeStream (CFWriteStreamRef stream, CFStreamEventType eventType, void *clientCallBackInfo) {
    outputStream = stream;
//}
//main {
    char *str = "nihao";
    
    if (outputStream != NULL) {
        CFWriteStreamWrite(outputStream, (const UInt8)str, strlen(str) + 1);
    } else {
        NSLog(@"Cannot send data!");
    }
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
